### 关于redis Dockerfile的说明
* 可用变量及默认变量
```shell
    REDIS_PASSWORD=passw0ord
    REDIS_MASTER_PASSWORD=${REDIS_PASSWORD}
    REDIS_RUN_MODE=standard 可选cluster 
    MAX_MEMORY=100mb
    REDIS_OTHER_OPTS=
```
* 其中REDIS_OTHER_OPTS设置为redis-server其他可用参数