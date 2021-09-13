#!/bin/sh

HERE=$(cd $(dirname "$0"); pwd)

source "$HERE/common.sh"

local_ip=""
getIpAddr

echo "\033[036m -->获取ip（mac本地） ${local_ip} \033[0m"
export LOCAL_IP=${local_ip}

echo "\033[036m -->开始创建目录 \033[0m"
for port in `seq 7001 7006`; do \
  export PORT=${port} \
  && mkdir -p ./${port}/conf \
  && envsubst < ./redis-cluster.tmpl > ./${port}/conf/redis.conf \
  && mkdir -p ./${port}/data \
  && cp ./lib/.gitignore ./${port}/conf/.gitignore \
  && cp ./lib/.gitignore ./${port}/data/.gitignore ;\
done

echo "\033[036m --分片前的清理工作 \033[0m"
sudo docker-compose stop

for port in `seq 7001 7006`; do \
  rm -rf ./${port}/data/appendonly.aof; \
  rm -rf ./${port}/data/nodes.conf; \
  rm -rf ./${port}/data/redis.log; \
  rm -rf ./${port}/data/dump.rdb; \
done

echo "\033[036m -->开始启动docker \033[0m"
sudo docker-compose up -d


echo "\033[036m -->开始手动redis cluster切片 \033[0m"
docker exec -it redis7001 redis-cli -p 7001 --cluster create ${local_ip}:7001 \
${local_ip}:7002 ${local_ip}:7003 ${local_ip}:7004 ${local_ip}:7005 ${local_ip}:7006 --cluster-replicas 1

echo "\033[036m -->完成 \033[0m"


echo "\033[036m -->使用时替换集群配置为\"${local_ip}:7001,${local_ip}:7002,${local_ip}:7003\" 即可。 \033[0m"