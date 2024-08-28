# ubuntu 12.04

* dqd: ssst0n3/docker_archive:ubuntu-12.04_v0.1.0

## usage

```shell
cd ubuntu/12.04
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 12040 root@127.0.0.1
```

```shell
root@localhost:~# uname -a
Linux localhost.localdomain 3.2.0-150-virtual #197-Ubuntu SMP Mon Apr 5 23:03:53 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release   
NAME="Ubuntu"
VERSION="12.04.5 LTS, Precise Pangolin"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu precise (12.04.5 LTS)"
VERSION_ID="12.04"
```

## build

```shell
make all DIR=ubuntu/12.04
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-12.04_v0.1.0
```