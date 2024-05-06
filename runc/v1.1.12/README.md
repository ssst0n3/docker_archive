
## use

```shell
cd runc/v1.1.12
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 11120 root@127.0.0.1
```

## build

```
make all DIR=runc/v1.1.12
```