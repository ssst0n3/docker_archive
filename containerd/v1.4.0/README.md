# containerd v1.4.0

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.4.0 -> ssst0n3/docker_archive:containerd-v1.4.0_v0.2.0
    * ssst0n3/docker_archive:containerd-v1.4.0_v0.2.0
    * ssst0n3/docker_archive:containerd-v1.4.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.4.0 -> ssst0n3/docker_archive:ctr_containerd-v1.4.0_v0.2.0
    * ssst0n3/docker_archive:ctr_containerd-v1.4.0_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_containerd-v1.4.0_v0.1.0

## usage

```shell
$ cd containerd/v1.4.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-4-0:~# containerd --version
containerd github.com/containerd/containerd v1.4.0 09814d48d50816305a8e6c1a4ae3e2bcc4ba725a
root@containerd-1-4-0:~# runc --version
runc version 1.0.0-rc92
spec: 1.0.2-dev
root@containerd-1-4-0:~# ctr i pull docker.io/library/ubuntu:16.04
docker.io/library/ubuntu:16.04:                                                   resolved       |++++++++++++++++++++++++++++++++++++++| 
index-sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6:    done           |++++++++++++++++++++++++++++++++++++++| 
manifest-sha256:a3785f78ab8547ae2710c89e627783cfa7ee7824d3468cae6835c9f4eae23ff7: done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:fb15d46c38dcd1ea0b1990006c3366ecd10c79d374f341687eb2cb23a2c8672e:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:58690f9b18fca6469a14da4e212c96849469f9b1be6661d2342a4bf01774aa50:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:b51569e7c50720acf6860327847fe342a1afbe148d24c529fb81df105e3eed01:    done           |++++++++++++++++++++++++++++++++++++++| 
config-sha256:b6f50765242581c887ff1acc2511fa2d885c52d8fb3ac8c4bba131fd86567f2e:   done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:da8ef40b9ecabc2679fe2419957220c0272a965c5cf7e0269fa1aeeb8c56f2e1:    done           |++++++++++++++++++++++++++++++++++++++| 
elapsed: 25.2s                                                                    total:  43.9 M (1.7 MiB/s)                                       
unpacking linux/amd64 sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6...
done
root@containerd-1-4-0:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.4.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.4.0_v0.2.0
```
