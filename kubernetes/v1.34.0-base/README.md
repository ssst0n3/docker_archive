# kubernetes v1.34.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.34.0 -> ssst0n3/docker_archive:kubernetes-v1.34.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.34.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.34.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0_v0.1.0

## usage

only for development

## build

```shell
make ctr DIR=kubernetes/v1.34.0
```

### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.34.0_v0.1.0
```
