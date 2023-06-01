# User-friendly SVN

通过WEB管理SVN代码库，代码来自https://github.com/usvn/usvn

## 使用

### 部署usvn

```shell
###创建持久化目录
mkdir -p /data/usvn/
chown -R 33.33 /data/usvn
###部署usvn
docker run  --name usvn \
-p 8888:80 \
-e USVN_SUBDIR=/usvn \
-v /data/usvn/:/var/lib/svn/ \
echo21bash/usvn:1.0.10
```

### 配置usvn

> 登陆http://YourIPaddress:8888/usvn/

### 配置ldap

```shell
ldap.options.host = "192.168.0.149"
ldap.options.port = "389"
ldap.options.username = "cn=admin,dc=alibaba,dc=com"
ldap.options.password = "123456789"
ldap.options.useStartTls = "0"
ldap.options.useSsl = "0"
ldap.options.bindRequiresDn = "1"
ldap.options.baseDn = "dc=alibaba,dc=com"
ldap.options.accountCanonicalForm = "0"
ldap.options.accountDomainName = "alibaba.com"
ldap.options.accountDomainNameShort = "alibaba"
ldap.options.accountFilterFormat = "(&(cn=%s))"
ldap.options.allowEmptyPassword = "0"
ldap.options.optReferrals = "0"
ldap.createGroupForUserInDB = "0"
ldap.createUserInDBOnLogin = "1"
```

