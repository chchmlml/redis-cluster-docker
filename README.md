# redis-cluster-docker
基于docker compose构建redis集群环境。 基于docker compose构建redis集群环境。 


redis-cluster-docker
A redis cluster environment is built based on docker compose.

代码实现源自这篇博文，理论及过程可参考 [Docker-compose之Redis Cluster集群](https://blog.csdn.net/weixin_50236329/article/details/109771983)

### redis-cluster.tmpl模板
在docker环境中，配置文件映射宿主机的时候，(宿主机)必须有配置文件。大家可以根据自己的需求定制配置文件。
下边是我的配置文件 redis-cluster.tmpl

### cluster 集群配置
```
sh build-cluster.sh
```

或者

```
docker exec -it redis7001 redis-cli -p 7001 --cluster create 192.168.20.249:7001 192.168.20.249:7002 192.168.20.249:7003 192.168.20.249:7004 192.168.20.249:7005 192.168.20.249:7006 --cluster-replicas 1
```


### 其他
项目中的ip均为 `192.168.20.249`，按需调整为需要的地址。