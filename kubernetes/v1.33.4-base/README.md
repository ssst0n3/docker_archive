# kubernetes v1.33.4 base image

* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.4-base -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.4-base_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.4-base_v0.1.0

## usage

Based on `ssst0n3/docker_archive:ctr_containerd-v2.1.4_v0.1.0`, installs Helm, CNI plugins, crictl, nerdctl, buildkit, and Kubernetes v1.33.3 binaries (kubeadm, kubelet, kubectl) with corresponding systemd service configurations, and pre pulled kubernetes images.

## build

```shell
make ctr DIR=kubernetes/v1.33.4-base
```

### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.4-base_v0.1.0
```
