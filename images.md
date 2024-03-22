## basic images



## preliminary images

| tag | version | alias | spec | note |
| --- | --- | --- | --- | --- |
| [pre_ubuntu-16.04](https://github.com/ssst0n3/docker_archive/tree/pre_ubuntu-16.04) | v0.1.1 | | v0.3.0 | |
| [pre_ubuntu-20.04](https://github.com/ssst0n3/docker_archive/tree/pre_ubuntu-20.04) | v0.1.2 | | v0.3.0 | |
| [pre_ubuntu-22.04](https://github.com/ssst0n3/docker_archive/tree/pre_ubuntu-22.04) | v0.1.0 | | v0.3.0 | |
| [pre_operator](https://github.com/ssst0n3/docker_archive/tree/pre_operator) | v0.1.0 | | v0.3.0 | contains packages needed for instructions |

## runc

| tag                     | version | alias               | spec | note |
|-------------------------| --- | ---------------------|------| --- |
| [ubuntu-16.04_runc-0.0.1](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-16.04_runc-0.0.1) | v0.1.0 | | v0.3.0 |
| [ubuntu-16.04_runc-0.1.0](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-16.04_runc-0.1.0) | v0.1.0 | | v0.3.0 |
| [ubuntu-16.04_runc-0.1.1](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-16.04_runc-0.1.1) | v0.1.0 | | v0.3.0 |
| [ubuntu-16.04_runc-1.0.0-rc1](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-16.04_runc-1.0.0-rc1) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_runc-1.0.0-rc3](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_runc-1.0.0-rc3) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_runc-1.0.0-rc4](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_runc-1.0.0-rc4) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_runc-1.0.0-rc9](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_runc-1.0.0-rc9) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_runc-1.0.0-rc10](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_runc-1.0.0-rc10) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_runc-1.0.0-rc95](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_runc-1.0.0-rc95) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_runc-1.0.2](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_runc-1.0.2) | v0.1.0 | | v0.3.0 |
| [ubuntu-22.04_runc-1.1.4](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-22.04_runc-1.1.4) | v0.1.0 | CVE-2023-27561 | v0.3.0 |
|                         | | CVE-2023-27561_runc |

## kata

| tag                     | version | alias               | spec | note |
|-------------------------| --- | ---------------------|------| --- |
| [ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_kata-1.10.4](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_kata-1.10.4) |
| [ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_kata-1.10.4-debug](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_kata-1.10.4-debug) | | |
| [ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.0](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.0) | v0.1.0 | | v0.3.0 | 
| [ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.0-debug](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.0-debug) | v0.1.1 | | v0.3.0 |
| [ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.1](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.1) | v0.1.0 | | v0.3.0 |

## docker
### linuxkit(slim version)

| tag | alias | note |
|---|---|---|
| linuxkit_docker-17.06.0                                                          |                     |                                                                    |
| linuxkit_docker-19.03.0                                                          |                     | cannot be used to reproduce CVE-2019-14271 because of static build |
| linuxkit_docker-19.03.0-rc3                                                      |                     |                                                                    |
| linuxkit_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd-1.2.6_runc-1.0.0-rc8 |                     |                                                                    |
| linuxkit_docker-19.03.14                                                         |                     |                                                                    |
| linuxkit_docker-20.10.0                                                          |                     |                                                                    |
| linuxkit_docker-20.10.2                                                          | cve-2021-21285_slim |                                                                    |

### ubuntu

| tag | version | alias | spec | note |
| --- | --- | --- | --- | --- |
| [ubuntu-20.04_docker-ce-17.03.0](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-17.03.0) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_docker-ce-17.06.0](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-17.06.0) | v0.1.0 | cve-2024-21626-statedir | v0.3.0 |
| ubuntu-20.04_docker-ce-18.06.1 | | cve-2019-5736      | 
| ubuntu-20.04_docker-ce-18.09.0_docker-ce-cli-18.09.0_containerd.io-1.2.6-3_runc-1.0.0-rc8                  |
| ubuntu-20.04_docker-ce-18.09.9_docker-ce-cli-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6                  |
| ubuntu-20.04_docker-ce-19.03.0_docker-ce-cli-19.03.0_containerd.io-1.2.6-3_runc-1.0.0-rc8                  | | CVE-2019-14271     |
| ubuntu-20.04_docker-ce-19.03.1_docker-ce-cli-19.03.1_containerd.io-1.2.6-3_runc-1.0.0-rc8                  |
| ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.6-3_runc-1.0.0-rc8                  | | CVE-2019-16884     || |
| ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.10-3_runc-1.0.0-rc8-dev             |
| [ubuntu-20.04_docker-ce-19.03.5_containerd.io-1.2.6.3_runc-1.0.0-rc8](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.5_containerd.io-1.2.6.3_runc-1.0.0-rc8) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_runc-1.0.0-rc8](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_runc-1.0.0-rc8) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1) | v0.1.2 | | v0.3.0 |
| ubuntu-20.04_docker-ce-19.03.12_docker-ce-cli-19.03.12_containerd.io-1.2.13_runc-1.0.0-rc10                |
| ubuntu-20.04_docker-ce-19.03.13_docker-ce-cli-19.03.13_containerd.io-1.3.7_runc-1.0.0-rc10                 |
| ubuntu-20.04_docker-ce-19.03.14_docker-ce-cli-19.03.14_containerd.io-1.3.9_runc-1.0.0-rc10                 |
| [ubuntu-20.04_docker-ce-19.03.15_containerd.io-1.4.3_runc-1.0.0-rc92](https://github.com/ssst0n3/docker_archive/blob/branch_ubuntu-20.04_docker-ce-19.03.15_docker-ce-cli-19.03.15_containerd.io-1.4.3_runc-1.0.0-rc92/README.md) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92) | v0.1.0 | | v0.3.0 |
| [ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.6.25_runc-1.1.10](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.6.25_runc-1.1.10) | v0.1.0 | | v0.3.0 |
| ubuntu-20.04_docker-ce-20.10.0_docker-ce-cli-20.10.0_containerd.io-1.4.3_runc-1.0.0-rc92                   |
| ubuntu-20.04_docker-ce-20.10.1_docker-ce-cli-20.10.1_containerd.io-1.4.3_runc-1.0.0-rc92                   |
| ubuntu-20.04_docker-ce-20.10.2_docker-ce-cli-20.10.2_containerd.io-1.4.3_runc-1.0.0-rc92                   | | cve-2021-21285     |
| ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92                   |
| ubuntu-20.04_docker-ce-20.10.6_docker-ce-cli-20.10.6_containerd.io-1.4.4_runc-1.0.0-rc93                   |
| ubuntu-22.04_docker-ce-20.10.19_docker-ce-cli-20.10.19_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 | | git_cve-2022-39253 |
| ubuntu-22.04_docker-ce-20.10.20_docker-ce-cli-20.10.20_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 |                    |
| ubuntu-22.04_docker-ce-20.10.21_docker-ce-cli-20.10.21_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 |                    |
| ubuntu-22.04_docker-ce-20.10.22_docker-ce-cli-20.10.22_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 |                    |
| [ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11) | v0.1.0 | cve-2024-21626 | v0.3.0 |
| [ubuntu-22.04_docker-ce-25.0.0-beta.1_containerd.io-1.6.25_runc-1.1.10](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-22.04_docker-ce-25.0.0-beta.1_containerd.io-1.6.25_runc-1.1.10) | v0.1.0 | | v0.3.0 |

## podman

| tag                                  | version | alias | spec | note |
|--------------------------------------|-------|------| --- | --- |
| [ubuntu-22.04_podman-4.4.3_runc-1.1.4](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-22.04_podman-4.4.3_runc-1.1.4) | v0.1.0 | | v0.3.0 |

## k8s

| tag                                                                                                                         | alias            | note                                                               |
|-----------------------------------------------------------------------------------------------------------------------------|------------------|--------------------------------------------------------------------|
| ubuntu-16.04_kubeadm-1.9.3_kubelet-1.9.3_kubectl-1.9.3_kubernetes-cni-0.6.0_flannel-0.9.1_docker-ce-17.03.3                 | CVE-2017-1002101 |
| ubuntu-16.04_kubeadm-1.9.4_kubelet-1.9.4_kubectl-1.9.4_kubernetes-cni-0.6.0_flannel-0.9.1_docker-ce-17.03.3                 |
| centos-stream-8_kubeadm-1.22.2_kubernetes-1.22.2_kubernetes-cni-0.8.7_flannel-0.14.0_docker-ce-20.10.9_containerd.io-1.4.11 |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.4.12-1_calico-3.22.1                                                         | CVE-2022-23648   |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1                                                            |                  |                                                                    |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.6.0_calico-3.22.1                                                            |                  | [A known bug](https://github.com/ssst0n3/docker_archive/issues/15) |

## istio

| tag                                                                           | alias | note                                                                                                     |
|-------------------------------------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------|
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.16.0 |       |                                                                                                          |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.15.0 |       | CVE-2022-39278                                                                                           |
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.14.0 |       | CVE-2022-31045,CVE-2022-29225,CVE-2022-29224,CVE-2022-29226,CVE-2022-29227,CVE-2022-29228,CVE-2022-39278 | 
| ubuntu-20.04_kubernetes-1.23.4_containerd.io-1.5.9_calico-3.22.1_istio-1.13.0 |       | CVE-2022-23635,CVE-2021-43824,CVE-2021-43825,CVE-2021-43826,CVE-2022-21654,CVE-2022-21655,CVE-2022-23606 | 
