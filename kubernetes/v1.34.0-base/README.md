# kubernetes v1.34.0 base image

* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-base -> ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-base_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-base_v0.1.0

## usage

only for development

## build

```shell
make ctr DIR=kubernetes/v1.34.0-base
```

### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-base_v0.1.0
```
