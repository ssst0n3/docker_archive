# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## version
`ubuntu-22.04_podman-4.4.3_runc-1.1.4`

## usage
### with kvm
```
docker run --device /dev/kvm -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-22.04_podman-4.4.3_runc-1.1.4 /start_vm.sh -enable-kvm
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# runc --version
runc version 1.1.4-0ubuntu1~22.04.1
spec: 1.0.2-dev
go: go1.18.1
libseccomp: 2.5.3
root@ubuntu:~# podman --version
podman version 4.4.3
```

### without kvm
```
docker run -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-22.04_podman-4.4.3_runc-1.1.4
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# runc --version
```

or 

```
docker-compose up -d
```

## Note
The podman v4.4.3 package is not available in the official repository.

So i rebuild it at https://build.opensuse.org/package/show/home:ssst0n3/podman-v4.4.3 .