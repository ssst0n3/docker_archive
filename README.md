# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-16.04_kubeadm-1.9.3_kubelet-1.9.3_kubectl-1.9.3_kubernetes-cni-0.6.0_flannel-0.9.1_docker-ce-17.03.3`

```
# kubelet --version
Kubernetes v1.9.3
```