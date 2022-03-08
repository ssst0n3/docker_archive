# kubernetes archive

Provide most versions of kubernetes. 

You can get specify version of kubernetes such as kubernetes 1.23.4 by pull an container image.

There will be an qemu in the docker image, and a kubernetes 1.23.4 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.4.12-1_calico-3.22.1`

```
# kubelet --version
Kubernetes v1.23.4
# containerd --version
containerd github.com/containerd/containerd v1.4.12.m 7b11cfaabd73bb80907dd23182b9347b4245eb5d.m
```

## usage
```
docker run ssst0n3/docker_archive:ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.4.12-1_calico-3.22.1
...
Ubuntu 16.04.7 LTS ubuntu ttyS0

ubuntu login: root
Password: root

root@ubuntu:~# /wait-for.sh
```
