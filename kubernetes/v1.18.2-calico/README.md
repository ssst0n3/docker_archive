# kubernetes v1.18.2 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.18.2-calico -> ssst0n3/docker_archive:kubernetes-v1.18.2-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.18.2-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.18.2-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ until kubectl --kubeconfig=kubeconfig wait --for=condition=Ready pod --all -A --timeout=30s; do sleep 10; done
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE

```


```shell
$ ./ssh
root@kubernetes-1-34-0:~# helm version
root@kubernetes-1-34-0:~# kubectl version
root@kubernetes-1-34-0:~# containerd --version
root@kubernetes-1-34-0:~# runc --version
root@kubernetes-1-34-0:~# uname -a
root@kubernetes-1-34-0:~# cat /etc/os-release
```

## build

```shell
make all DIR=kubernetes/v1.18.2-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
