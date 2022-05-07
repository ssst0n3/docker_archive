# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-20.04_docker-ce-18.06.1`


```
root@ubuntu:~# docker version
Client:
 Version:           18.06.1-ce
 API version:       1.38
 Go version:        go1.10.3
 Git commit:        e68fc7a
 Built:             Tue Aug 21 17:24:51 2018
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          18.06.1-ce
  API version:      1.38 (minimum version 1.12)
  Go version:       go1.10.3
  Git commit:       e68fc7a
  Built:            Tue Aug 21 17:23:15 2018
  OS/Arch:          linux/amd64
  Experimental:     false
```

```
root@ubuntu:~# docker-containerd -version
containerd github.com/containerd/containerd v1.1.2 468a545b9edcd5932818eb9de8e72413e616e86e
```

```
root@ubuntu:~# docker-runc -version
runc version 1.0.0-rc5+dev
commit: 69663f0bd4b60df09991c08812a60108003fa340
spec: 1.0.0
```

## usage
### with kvm

```
docker network create test
docker run --net=test --dev /dev/kvm -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.06.1 /start_vm.sh -enable-kvm
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

### without kvm
```
docker network create test
docker run --net=test -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.06.1
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```