# containerd v1.5.1

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.5.1 -> ssst0n3/docker_archive:containerd-v1.5.1_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.5.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.5.1 -> ssst0n3/docker_archive:ctr_containerd-v1.5.1_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.5.1_v0.1.0

## usage

```shell
$ cd containerd/v1.5.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-5-1:~# containerd --version
containerd github.com/containerd/containerd v1.5.1 12dca9790f4cb6b18a6a7a027ce420145cb98ee7
root@containerd-1-5-1:~# runc --version
runc version 1.0.0-rc94
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
root@containerd-1-5-1:~# ctr i pull docker.io/library/ubuntu:16.04
docker.io/library/ubuntu:16.04: resolving      |--------------------------------------| 
elapsed: 10.0s                  total:   0.0 B (0.0 B/s)                                         
INFO[0010] trying next host                              error="failed to do request: Head \"https://registry-1.docker.io/v2/library/ubuntu/manifests/16.04\": net/http: TLS handshake timeout" host=registry-1.docker.io
ctr: failed to resolve reference "docker.io/library/ubuntu:16.04": failed to do request: Head "https://registry-1.docker.io/v2/library/ubuntu/manifests/16.04": net/http: TLS handshake timeout
root@containerd-1-5-1:~# ctr i pull docker.io/library/ubuntu:16.04
docker.io/library/ubuntu:16.04:                                                   resolved       |++++++++++++++++++++++++++++++++++++++| 
index-sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6:    exists         |++++++++++++++++++++++++++++++++++++++| 
manifest-sha256:a3785f78ab8547ae2710c89e627783cfa7ee7824d3468cae6835c9f4eae23ff7: exists         |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:fb15d46c38dcd1ea0b1990006c3366ecd10c79d374f341687eb2cb23a2c8672e:    exists         |++++++++++++++++++++++++++++++++++++++| 
config-sha256:b6f50765242581c887ff1acc2511fa2d885c52d8fb3ac8c4bba131fd86567f2e:   exists         |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:58690f9b18fca6469a14da4e212c96849469f9b1be6661d2342a4bf01774aa50:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:b51569e7c50720acf6860327847fe342a1afbe148d24c529fb81df105e3eed01:    exists         |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:da8ef40b9ecabc2679fe2419957220c0272a965c5cf7e0269fa1aeeb8c56f2e1:    exists         |++++++++++++++++++++++++++++++++++++++| 
elapsed: 12.7s                                                                    total:  44.3 M (3.5 MiB/s)                                       
unpacking linux/amd64 sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6...
done: 1.980885288s	
root@containerd-1-5-1:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
root@containerd-1-5-1:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="20.04.6 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.6 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
root@containerd-1-5-1:~# uname -a
Linux containerd-1-5-1 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=containerd/v1.5.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.5.1_v0.1.0
```
