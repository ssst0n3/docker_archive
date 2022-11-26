# kubernetes archive

Provide most versions of kubernetes. 

You can get specify version of kubernetes such as kubernetes 1.23.4 by pull an container image.

There will be an qemu in the docker image, and a kubernetes 1.23.4 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.6.0_calico-3.22.1`

```
# kubelet --version
Kubernetes v1.23.4
# containerd --version
containerd github.com/containerd/containerd v1.6.0 39259a8f35919a0d02c9ecc2871ddd6ccf6a7c6e
```

## usage

**with kvm**
```
docker run --dev /dev/kvm -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.6.0_calico-3.22.1 /start_vm.sh -enable-kvm
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# /wait-for.sh
```

**with out kvm**
```
docker run ssst0n3/docker_archive:ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.6.0_calico-3.22.1
...
Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-56-generic x86_64)
...
ubuntu login: root
Password: root

root@ubuntu:~# /wait-for.sh
```
