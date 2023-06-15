# wal-g

> * wal-g 是一个多功能数据库备份工具；
> * 项目地址https://github.com/wal-g/wal-g

> build docker image for postgresql

```shell
docker build \
--build-arg DBTYPE=pg \
--build-arg VERSION=2.0.1 \
-t echo21bash/wal-g:2.0.1-pg .
```

> build docker image for mysql

```shell
docker build \
--build-arg DBTYPE=mysql \
--build-arg VERSION=2.0.1 \
-t echo21bash/wal-g:2.0.1-mysql .
```

> build docker image for sqlserver

```shell
docker build \
--build-arg DBTYPE=sqlserver \
--build-arg VERSION=2.0.1 \
-t echo21bash/wal-g:2.0.1-sqlserver .
```

> build docker image for greenplum

```shell
docker build \
--build-arg DBTYPE=gp \
--build-arg VERSION=2.0.1 \
-t echo21bash/wal-g:2.0.1-gp .
```

> build docker image for mongo

```shell
docker build \
--build-arg DBTYPE=mongo \
--build-arg VERSION=2.0.1 \
-t echo21bash/wal-g:2.0.1-mongo .
```

