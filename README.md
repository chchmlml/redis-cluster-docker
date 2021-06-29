# redis-cluster-docker
基于docker compose构建redis集群环境。 基于docker compose构建redis集群环境。 


redis-cluster-docker
A redis cluster environment is built based on docker compose.

代码实现源自这篇博文，理论及过程可参考 (Docker-compose之Redis Cluster集群)[https://blog.csdn.net/weixin_50236329/article/details/109771983]

### redis-cluster.tmpl模板
在docker环境中，配置文件映射宿主机的时候，(宿主机)必须有配置文件。大家可以根据自己的需求定制配置文件。
下边是我的配置文件 redis-cluster.tmpl

### cluster 集群配置
```
sh build-cluster.sh
```

或者

```
docker exec -it redis7001 redis-cli -p 7001 --cluster create 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006 --cluster-replicas 1
```


### 其他
项目中的ip均为 `127.0.0.1`，按需调整为需要的地址。