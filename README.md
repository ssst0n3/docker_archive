# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.0`


```
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           19.03.11
 API version:       1.40
 Go version:        go1.13.10
 Git commit:        42e35e61f3
 Built:             Mon Jun  1 09:12:34 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.11
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.10
  Git commit:       42e35e61f3
  Built:            Mon Jun  1 09:11:07 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.9
  GitCommit:        e25210fe30a0a703442421b0f60afac609f950a3
 runc:
  Version:          1.0.1
  GitCommit:        v1.0.1-0-g4144b63
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

```
root@ubuntu:~# containerd --version
containerd containerd.io 1.4.9 e25210fe30a0a703442421b0f60afac609f950a3
```

```
root@ubuntu:~# runc --version
runc version 1.0.1
commit: v1.0.1-0-g4144b63
spec: 1.0.2-dev
go: go1.15.14
libseccomp: 2.4.3
```

```
root@ubuntu:~# /opt/kata/bin/kata-runtime --version
kata-runtime  : 1.11.0
   commit   : 23e554b316aa994c6f48c9b1bd84060629fd6361
   OCI specs: 1.0.1-dev
```