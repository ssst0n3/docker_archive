# docker archive: 提供不同版本的docker及其组件的镜像

[english version](./README.md), [如何贡献](./CONTRIBUTE-ZH.md)

你可以通过pull容器镜像的形式，来获取特定版本的docker环境，例如docker19.03等。

在你pull下来的镜像中，会有一个qemu，qemu中又会有一个docker 19.03。

是的，这种形式有点像俄罗斯套娃，但对于容器安全研究来说，这种形式确实非常方便。

## 使用说明
你可以在[dockerhub](https://hub.docker.com/repository/docker/ssst0n3/docker_archive/tags?page=1&ordering=last_updated) 上看到所有版本的镜像。

对于每一个版本的docker，我们都会提供两种镜像
* docker in ubuntu in qemu in docker: docker运行在ubuntu操作系统中
* docker in linuxkit in qemu in docker: docker运行在[linuxkit](https://github.com/linuxkit/linuxkit) 操作系统中

### for docker in ubuntu in qemu in docker
```
$ docker network create test
$ docker run --network=test -d -p 2222:22 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92
$ ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
...
```

### for docker in linuxkit in qemu in docker
```
docker run -ti ssst0n3/docker_archive:linuxkit_docker-19.03.0
// wait container start up
docker version
```

## tag template
{operating system version}_{docker and it's components version}

## 当前支持的版本列表
可以在 [tags页面](https://github.com/ssst0n3/docker_archive/tags) 查看 

### docker
#### linuxkit(slim version)

| tag | alias | note |
| --- | --- | --- | 
| linuxkit_docker-17.06.0 | | |
| linuxkit_docker-19.03.0 | | cannot be used to reproduce CVE-2019-14271 because of static build |
| linuxkit_docker-19.03.0-rc3 |
| linuxkit_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd-1.2.6_runc-1.0.0-rc8 |
| linuxkit_docker-19.03.14 |
| linuxkit_docker-20.10.0 |
| linuxkit_docker-20.10.2 | cve-2021-21285_slim |

#### ubuntu

| tag | alias | note |
| --- | --- | --- | 
| ubuntu-20.04_docker-ce-17.06.0 | 
| ubuntu-20.04_docker-ce-18.06.1 | cve-2019-5736 | 
| ubuntu-20.04_docker-ce-18.09.0_docker-ce-cli-18.09.0_containerd.io-1.2.6-3_runc-1.0.0-rc8 |
| ubuntu-20.04_docker-ce-18.09.9_docker-ce-cli-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6 |
| ubuntu-20.04_docker-ce-19.03.0_docker-ce-cli-19.03.0_containerd.io-1.2.6-3_runc-1.0.0-rc8 | CVE-2019-14271 |
| ubuntu-20.04_docker-ce-19.03.1_docker-ce-cli-19.03.1_containerd.io-1.2.6-3_runc-1.0.0-rc8 |
| ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.6-3_runc-1.0.0-rc8 | CVE-2019-16884 | cannot be built by linuxkit, because linux/kernel do not support apparmor |
| ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.10-3_runc-1.0.0-rc8-dev |
| ubuntu-20.04_docker-ce-19.03.5_docker-ce-cli-19.03.5_containerd.io-1.2.6.3_runc-1.0.0-rc8 |
| ubuntu-20.04_docker-ce-19.03.12_docker-ce-cli-19.03.12_containerd.io-1.2.13_runc-1.0.0-rc10 |
| ubuntu-20.04_docker-ce-19.03.13_docker-ce-cli-19.03.13_containerd.io-1.3.7_runc-1.0.0-rc10 |
| ubuntu-20.04_docker-ce-19.03.14_docker-ce-cli-19.03.14_containerd.io-1.3.9_runc-1.0.0-rc10 |
| ubuntu-20.04_docker-ce-19.03.15_docker-ce-cli-19.03.15_containerd.io-1.4.3_runc-1.0.0-rc92 |
| ubuntu-20.04_docker-ce-20.10.0_docker-ce-cli-20.10.0_containerd.io-1.4.3_runc-1.0.0-rc92 |
| ubuntu-20.04_docker-ce-20.10.1_docker-ce-cli-20.10.1_containerd.io-1.4.3_runc-1.0.0-rc92 |
| ubuntu-20.04_docker-ce-20.10.2_docker-ce-cli-20.10.2_containerd.io-1.4.3_runc-1.0.0-rc92 | cve-2021-21285 |
| ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92 |
| ubuntu-20.04_docker-ce-20.10.6_docker-ce-cli-20.10.6_containerd.io-1.4.4_runc-1.0.0-rc93 |
| ubuntu-22.04_docker-ce-20.10.19_docker-ce-cli-20.10.19_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 | git_cve-2022-39253 |
| ubuntu-22.04_docker-ce-20.10.20_docker-ce-cli-20.10.20_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 | |
| ubuntu-22.04_docker-ce-20.10.21_docker-ce-cli-20.10.21_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 | |

### k8s

| tag | alias | note |
| --- | --- | --- | 
| ubuntu-16.04_kubeadm-1.9.3_kubelet-1.9.3_kubectl-1.9.3_kubernetes-cni-0.6.0_flannel-0.9.1_docker-ce-17.03.3 | CVE-2017-1002101 |
| ubuntu-16.04_kubeadm-1.9.4_kubelet-1.9.4_kubectl-1.9.4_kubernetes-cni-0.6.0_flannel-0.9.1_docker-ce-17.03.3 |
| centos-stream-8_kubeadm-1.22.2_kubernetes-1.22.2_kubernetes-cni-0.8.7_flannel-0.14.0_docker-ce-20.10.9_containerd.io-1.4.11 |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.4.12-1_calico-3.22.1 | CVE-2022-23648 |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1 | | |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.6.0_calico-3.22.1 | | [A known bug](https://github.com/ssst0n3/docker_archive/issues/15) |

### istio

| tag | alias | note |
| --- | --- | --- | 
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.16.0 | | |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.15.0 | | CVE-2022-39278 |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.14.0 | | CVE-2022-31045,CVE-2022-29225,CVE-2022-29224,CVE-2022-29226,CVE-2022-29227,CVE-2022-29228,CVE-2022-39278 | 
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.13.0 | | CVE-2022-23635,CVE-2021-43824,CVE-2021-43825,CVE-2021-43826,CVE-2022-21654,CVE-2022-21655,CVE-2022-23606 | 

## 已知问题

### ssh 连接失败 https://github.com/ssst0n3/docker_archive/issues/10

Ssh 可能在使用有些镜像时可能会卡住，但有些不会。

我还不知道具体的原因，如果你遇到了同样的问题，可以尝试使用新创建的网桥启动容器：

```
docker network create test
docker run --network=test ...
```
