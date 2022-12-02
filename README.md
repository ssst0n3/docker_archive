# kubernetes archive

Provide most versions of kubernetes. 

You can get specify version of kubernetes such as kubernetes 1.23.4 by pull an container image.

There will be an qemu in the docker image, and a kubernetes 1.23.4 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.14.0`

```
# kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.4", GitCommit:"e6c093d87ea4cbb530a7b2ae91e54c0842d8308a", GitTreeState:"clean", BuildDate:"2022-02-16T12:38:05Z", GoVersion:"go1.17.7", Compiler:"gc", Platform:"linux/}
Server Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.4", GitCommit:"e6c093d87ea4cbb530a7b2ae91e54c0842d8308a", GitTreeState:"clean", BuildDate:"2022-02-16T12:32:02Z", GoVersion:"go1.17.7", Compiler:"gc", Platform:"linux/}
# kubelet --version
Kubernetes v1.23.4
# containerd --version
containerd github.com/containerd/containerd v1.5.9 1407cab509ff0d96baa4f0eb6ff9980270e6e620
# /istio-1.14.0/bin/istioctl version
client version: 1.14.0
control plane version: 1.14.0
data plane version: 1.14.0 (2 proxies)
```

## usage

**with kvm**
```
docker run --dev /dev/kvm -d -p 2222:22 -ti ssst0n3/docker_archive:ssst0n3/docker_archive:ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.14.0 /start_vm.sh -enable-kvm
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# /wait-for.sh
```

**with out kvm**
```
docker run ssst0n3/docker_archive:ssst0n3/docker_archive:ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.14.0
...
Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-56-generic x86_64)
...
ubuntu login: root
Password: root

root@ubuntu:~# /wait-for.sh
```
