# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-20.04_docker-ce-18.09.9_docker-ce-cli-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6`


```
root@ubuntu:~# docker version
Client:
 Version:           18.09.9
 API version:       1.39
 Go version:        go1.11.13
 Git commit:        039a7df9ba
 Built:             Wed Sep  4 17:24:10 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.9
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.11.13
  Git commit:       039a7df
  Built:            Wed Sep  4 16:19:38 2019
  OS/Arch:          linux/amd64
  Experimental:     false
```

```
root@ubuntu:~# containerd --version
containerd github.com/containerd/containerd 1.2.2 9754871865f7fe2f4e74d43e2fc7ccd237edcbce
```

```
root@ubuntu:~# runc -version
runc version 1.0.0-rc6+dev
commit: 09c8266bf2fcf9519a651b04ae54c967b9ab86ec
spec: 1.0.1-dev
```