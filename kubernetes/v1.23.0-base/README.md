# kubernetes v1.23.0 base image

* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-base -> ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-base_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-base_v0.1.0

## usage

Based on `ssst0n3/docker_archive:ctr_containerd-v1.5.2_v0.1.0`, installs Helm, CNI plugins, crictl, and Kubernetes v1.23.0 binaries (kubeadm, kubelet, kubectl) with corresponding systemd service configurations, and pre pulled kubernetes images.

## build

```shell
make ctr DIR=kubernetes/v1.23.0-base
```

### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-base_v0.1.0
```
