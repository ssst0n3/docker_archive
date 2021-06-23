# docker archive

## usage

```
docker run -ti ssst0n3/docker_archive:linuxkit_docker-17.06.0
docker version
```

details
```
st0n3@yoga:~$ docker run -ti ssst0n3/docker_archive:linuxkit_docker-17.06.0
// wait container startup
...
Welcome to LinuxKit

                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
          {                       /  ===-
           \______ O           __/
             \    \         __/
              \____\_______/
...
getty: starting getty for ttyS0

linuxkit-525400123456 login: root (automatic login)

Welcome to LinuxKit!

NOTE: This system is namespaced.
The namespace you are currently in may not be the root.
System services are namespaced; to access, use `ctr -n services.linuxkit ...`
(ns: getty) linuxkit-525400123456:~# ctr --namespace services.linuxkit tasks exe
c --tty --exec-id sh docker /bin/ash -l

linuxkit-525400123456:/#
linuxkit-525400123456:/# docker version
Client:
 Version:      17.06.0-ce
 API version:  1.30
 Go version:   go1.8.3
 Git commit:   02c1d87
 Built:        Fri Jun 23 21:15:15 2017
 OS/Arch:      linux/amd64

Server:
 Version:      17.06.0-ce
 API version:  1.30 (minimum version 1.12)
 Go version:   go1.8.3
 Git commit:   02c1d87
 Built:        Fri Jun 23 21:51:55 2017
 OS/Arch:      linux/amd64
 Experimental: false
linuxkit-525400123456:/# docker-runc -version
runc version 1.0.0-rc3
commit: 2d41c047c83e09a6d61d464906feb2a2f3c52aa4
spec: 1.0.0-rc5
```