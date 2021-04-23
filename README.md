# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-20.04_docker-ce-20.10.1_docker-ce-cli-20.10.1_containerd.io-1.4.3_runc-1.0.0-rc92`


```
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           20.10.1
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        831ebea
 Built:             Tue Dec 15 04:34:58 2020
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.1
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       f001486
  Built:            Tue Dec 15 04:32:52 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.3
  GitCommit:        269548fa27e0089a8b8278fc4fc781d7f65a939b
 runc:
  Version:          1.0.0-rc92
  GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

```
root@ubuntu:~# containerd --version
containerd containerd.io 1.4.3 269548fa27e0089a8b8278fc4fc781d7f65a939b
```

```
root@ubuntu:~# runc -version
runc version 1.0.0-rc92
commit: ff819c7e9184c13b7c2607fe6c30ae19403a7aff
spec: 1.0.2-dev
```