# docker archive: images of container's components

See all images listed
in [dockerhub](https://hub.docker.com/repository/docker/ssst0n3/docker_archive/tags?page=1&ordering=last_updated).

## How-To

### 1. quick-start

```shell
$ git clone https://github.com/ssst0n3/docker_archive
$ cd docker_archive/docker/v28.1.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           28.1.1
 API version:       1.49
 Go version:        go1.23.8
 Git commit:        4eba377
 Built:             Fri Apr 18 09:52:14 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.1.1
  API version:      1.49 (minimum version 1.24)
  Go version:       go1.23.8
  Git commit:       01f442b
  Built:            Fri Apr 18 09:52:14 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.27
  GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
 runc:
  Version:          1.2.5
  GitCommit:        v1.2.5-0-g59923ef
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

### 2. install built-in ssh config

```shell
$ ./script/install_ssh_config.sh
$ ssh dqd-docker-v28.1.1
root@localhost:~# docker version
...
```

## Images

### vul

| tag                                                                     | version | alias                            | note                       |
|-------------------------------------------------------------------------|---------|----------------------------------|----------------------------|
| [cve-2025-62725](./vul/cve-2025-62725/)                                 | v0.1.0  |
| [cve-2025-23266_mitigation](./vul/cve-2025-23266_mitigation/)           | v0.1.0  |
| [cve-2025-23266](./vul/cve-2025-23266/)                                 | v0.9.0  | nvidia-container-toolkit-v1.17.6 |                            |
| [cve-2025-47290](./vul/cve-2025-47290/)                                 | v0.1.0  | containerd-v2.1.0                |                            |
| [cve-2025-1974](./vul/cve-2025-1974/)                                   | v0.1.0  | ingress-nginx-v1.11.3            |                            |
| [cve-2024-40635](./vul/cve-2024-40635/)                                 | v0.1.0  | kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3 |
| [cve-2024-23650](./vul/cve-2024-23650/)                                 | v0.1.0  | buildkit-v0.12.4                 |
| [cve-2024-0132](./vul/cve-2024-0132/)                                   | v0.1.0  | nvidia-container-toolkit-v1.16.1 |
| [cve-2022-39253](./vul/cve-2022-39253/)                                 | v0.1.0  |
| [cve-2022-0492](./vul/cve-2022-0492/)                                   | v0.1.0  |
| [cve-2020-15257](./vul/cve-2020-15257/)                                 | v0.1.0  | docker-v19.03.13                 |                            |
| [cve-2020-8558](./vul/cve-2020-8558/)                                   | v0.1.0  | kubernetes-v1.18.2-cluster       |                            |
| [cve-2019-5736](./vul/cve-2019-5736/)                                   | v0.1.0  | docker-v17.06.0                  |                            |
| [cve-2016-8867](./vul/cve-2016-8867/)                                   | v0.1.0  | docker-v1.12.2                   |                            |
| [fork-bomb](./vul/fork-bomb/) | v0.1.0 | docker-v19.03.13 |
| [shocker_docker-v0.7.1](./vul/shocker/shocker_docker-v0.7.1/)           | v0.1.0  |                                  | lxc execdriver             |
| [shocker_docker-v0.7.2](./vul/shocker/shocker_docker-v0.7.2/)           | v0.1.0  |                                  | lxc(dockerinit) execdriver |
| [shocker_docker-v0.9.0](./vul/shocker/shocker_docker-v0.9.0/)           | v0.1.0  |                                  | native execdriver          |
| [shocker_docker-v0.9.0-lxc](./vul/shocker/shocker_docker-v0.9.0-lxc/)   | v0.1.0  |                                  | lxc(dockerinit) execdriver |
| [shocker_docker-v0.11.1](./vul/shocker/shocker_docker-v0.11.1/)         | v0.1.0  |                                  | native execdriver          |
| [shocker_docker-v0.11.1-lxc](./vul/shocker/shocker_docker-v0.11.1-lxc/) | v0.1.0  |                                  | lxc(dockerinit) execdriver |
| [shocker_docker-v0.12.0](./vul/shocker/shocker_docker-v0.12.0/)         | v0.1.0  |                                  | native execdriver, fixed   |
| [shocker_docker-v0.12.0-lxc](./vul/shocker/shocker_docker-v0.12.0-lxc/) | v0.1.0  |                                  | lxc(dockerinit) execdriver |
| [shocker_docker-v1.0.0-lxc](./vul/shocker/shocker_docker-v1.0.0-lxc/)   | v0.1.0  |                                  | lxc(dockerinit) execdriver |
| [shocker_docker-v1.0.1-lxc](./vul/shocker/shocker_docker-v1.0.1-lxc/)   | v0.1.0  |                                  | lxc(dockerinit) execdriver |
| [shocker_docker-v26.1.4](./vul/shocker/shocker_docker-v26.1.4/)         | v0.1.0  |                                  | capadd                     |

### ctf

| tag                                           | version | note |
|-----------------------------------------------|---------|------|
| [your-gpu-my-shell](./ctf/your-gpu-my-shell/) | v0.1.0  |      |
| [be-a-docker-escaper](./ctf/Be-a-Docker-Escaper/) | v0.1.0  |      |

### issue

| tag                                                                       | version | alias |
|---------------------------------------------------------------------------|---------|-------|
| [runc-issue-4047_commit-a6f4081](./issue/runc-issue-4047_commit-a6f4081/) | v0.1.0  |
| [runc-issue-4047_commit-ab3cd8d](./issue/runc-issue-4047_commit-ab3cd8d/) | v0.1.0  |
| [runc-issue-4047_commit-7396ca9](./issue/runc-issue-4047_commit-7396ca9/) | v0.1.0  |
| [runc-pr-3825_commit-7d09ba1](./issue/runc-pr-3825_commit-7d09ba1/)       | v0.1.0  |

### ingress-nginx

| tag                                               | version | alias         | note |
|---------------------------------------------------|---------|---------------|------|
| [ingress-nginx-v1.11.4](./ingress-nginx/v1.11.4/) | v0.1.0  |               |      |
| [ingress-nginx-v1.11.3](./ingress-nginx/v1.11.3/) | v0.1.0  | cve-2025-1974 |      |

### kubenertes

| tag                                                       | version | alias | note |
|-----------------------------------------------------------|---------|-------|------|
| [kubernetes-v1.34.0-cluster](./kubernetes/v1.34.0-cluster/) | v0.1.0  |       |      |
| [kubernetes-v1.34.0-calico](./kubernetes/v1.34.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.34.0](./kubernetes/v1.34.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.33.1-calico-apparmor](./kubernetes/v1.33.1-calico-apparmor/) | v0.1.0  |       |      |
| [kubernetes-v1.33.1-calico](./kubernetes/v1.33.1-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.33.1](./kubernetes/v1.33.1/)               | v0.1.0  |       |      |
| [kubernetes-v1.32.3-calico](./kubernetes/v1.32.3-calico/) | v0.2.0  |       |      |
| [kubernetes-v1.32.3](./kubernetes/v1.32.3/)               | v0.2.0  |       |      |
| [kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3](./kubernetes/v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3/) | v0.1.0  |       |      |
| [kubernetes-v1.32.2_containerd-v2.0.3-calico](./kubernetes/v1.32.2_containerd-v2.0.3-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.32.2_containerd-v2.0.3](./kubernetes/v1.32.2_containerd-v2.0.3/) | v0.1.0  |       |      |
| [kubernetes-v1.32.2-calico](./kubernetes/v1.32.2-calico/) | v0.2.0  |       |      |
| [kubernetes-v1.32.2](./kubernetes/v1.32.2/)               | v0.2.0  |       |      |
| [kubernetes-v1.31.0-calico](./kubernetes/v1.31.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.31.0](./kubernetes/v1.31.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.30.0-calico](./kubernetes/v1.30.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.30.0](./kubernetes/v1.30.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.29.0-calico](./kubernetes/v1.29.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.29.0](./kubernetes/v1.29.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.28.0-calico](./kubernetes/v1.28.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.28.0](./kubernetes/v1.28.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.27.0-calico](./kubernetes/v1.27.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.27.0](./kubernetes/v1.27.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.26.0-calico](./kubernetes/v1.26.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.26.0](./kubernetes/v1.26.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.25.0-calico](./kubernetes/v1.25.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.25.0](./kubernetes/v1.25.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.24.0-calico](./kubernetes/v1.24.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.24.0](./kubernetes/v1.24.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.23.0-calico](./kubernetes/v1.23.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.23.0](./kubernetes/v1.23.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.22.0-calico](./kubernetes/v1.22.0-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.22.0](./kubernetes/v1.22.0/)               | v0.1.0  |       |      |
| [kubernetes-v1.21.1-calico](./kubernetes/v1.21.1-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.21.1](./kubernetes/v1.21.1/)               | v0.1.0  |       |      |
| [kubernetes-v1.20.2-calico](./kubernetes/v1.20.2-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.20.2](./kubernetes/v1.20.2/)               | v0.1.0  |       |      |
| [kubernetes-v1.19.1-calico](./kubernetes/v1.19.1-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.19.1](./kubernetes/v1.19.1/)               | v0.1.0  |       |      |
| [kubernetes-v1.18.2-cluster](./kubernetes/v1.18.2-cluster/) | v0.1.0  |       |      |
| [kubernetes-v1.18.2-calico](./kubernetes/v1.18.2-calico/) | v0.1.0  |       |      |
| [kubernetes-v1.18.2](./kubernetes/v1.18.2/) | v0.1.0  |       |      |

### nvidia-container-toolkit

| tag                                                                                                             | version | alias | note |
|-----------------------------------------------------------------------------------------------------------------|---------|-------|------|
| [nvidia-container-toolkit-v1.17.8](./nvidia-container-toolkit/v1.17.8/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.7](./nvidia-container-toolkit/v1.17.7/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.6_podman-v5.5.1](./nvidia-container-toolkit/v1.17.6_podman-v5.5.1/)             | v0.1.0  |       |      |
| [nvidia-container-toolkit-v1.17.6_runc-v1.3.0-rc.2](./nvidia-container-toolkit/v1.17.6_runc-v1.3.0-rc.2/)       | v0.1.0  |       |      |
| [nvidia-container-toolkit-v1.17.6_docker-v28.0.0-rc.1](./nvidia-container-toolkit/v1.17.6_docker-v28.0.0-rc.1/) | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.6_docker-v27.5.1](./nvidia-container-toolkit/v1.17.6_docker-v27.5.1/)           | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.6-debug](./nvidia-container-toolkit/v1.17.6-debug/)                             | v0.9.1  |       |      |
| [nvidia-container-toolkit-v1.17.6](./nvidia-container-toolkit/v1.17.6/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.5](./nvidia-container-toolkit/v1.17.5/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.4](./nvidia-container-toolkit/v1.17.4/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.3](./nvidia-container-toolkit/v1.17.3/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.2](./nvidia-container-toolkit/v1.17.2/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.1](./nvidia-container-toolkit/v1.17.1/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.0](./nvidia-container-toolkit/v1.17.0/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.0-rc.2](./nvidia-container-toolkit/v1.17.0-rc.2/)                               | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.17.0-rc.1](./nvidia-container-toolkit/v1.17.0-rc.1/)                               | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.16.2](./nvidia-container-toolkit/v1.16.2/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.16.1](./nvidia-container-toolkit/v1.16.1/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.16.0](./nvidia-container-toolkit/v1.16.0/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.14.0](./nvidia-container-toolkit/v1.14.0/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.13.0](./nvidia-container-toolkit/v1.13.0/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.12.0](./nvidia-container-toolkit/v1.12.0/)                                         | v0.9.0  |       |      |
| [nvidia-container-toolkit-v1.10.0](./nvidia-container-toolkit/v1.10.0/)                                         | v0.9.0  |       |      |

### docker-compose

| tag                                                 | version| alias          | note |
|-----------------------------------------------------|--------|----------------|------|
| [docker-compose-v2.40.2](./docker-compose/v2.40.2/) | v0.1.0 |
| [docker-compose-v2.40.1](./docker-compose/v2.40.1/) | v0.1.0 |
| [docker-compose-v2.40.0](./docker-compose/v2.40.0/) | v0.1.0 |
| [docker-compose-v2.39.4](./docker-compose/v2.39.4/) | v0.1.0 |

### docker

| tag                                                                                                   | version | alias         | note                          |
|-------------------------------------------------------------------------------------------------------|---------|---------------|-------------------------------|
| [docker-v28.3.2-cron](./docker/v28.3.2-cron/)                                                         | v0.1.0  |
| [docker-v28.3.2](./docker/v28.3.2/)                                                                   | v0.1.0  |
| [docker-v28.2.2_containerd-v2.1.0](./docker/v28.2.2_containerd-v2.1.0/)                               | v0.1.0  |
| [docker-v28.2.2](./docker/v28.2.2/)                                                                   | v0.1.0  |
| [docker-v28.2.0](./docker/v28.2.0/)                                                                   | v0.1.0  |
| [docker-v28.1.1](./docker/v28.1.1/)                                                                   | v0.2.0  |
| [docker-v28.0.4_centos-stream9_runc-v1.2.5-debug](./docker/v28.0.4_centos-stream9_runc-v1.2.5-debug/) | v0.1.0  |
| [docker-v28.0.4_centos-stream9](./docker/v28.0.4_centos-stream9/)                                     | v0.2.0  |
| [docker-v28.0.4-debug](./docker/v28.0.4-debug/)                                                       | v0.1.0  |
| [docker-v28.0.4](./docker/v28.0.4/)                                                                   | v0.1.0  |
| [docker-v28.0.1](./docker/v28.0.1/)                                                                   | v0.1.0  |
| [docker-v28.0.0](./docker/v28.0.0/)                                                                   | v0.1.0  |
| [docker-v28.0.0-rc.1](./docker/v28.0.0-rc.1/)                                                         | v0.1.0  |
| [docker-v27.5.1](./docker/v27.5.1/)                                                                   | v0.2.0  |
| [docker-v27.5.0](./docker/v27.5.0/)                                                                   | v0.1.0  |
| [docker-v27.3.1](./docker/v27.3.1/)                                                                   | v0.1.0  |
| [docker-v27.1.0](./docker/v27.1.0/)                                                                   | v0.2.0  |
| [docker-v27.0.3](./docker/v27.0.3/)                                                                   | v0.1.0  |
| [ubuntu-22.04_docker-v26.1.4](./docker/v26.1.4/)                                                      | v0.1.0  |
| [docker-v24.0.5](./docker/v24.0.5/)                                                                   | v0.1.0  |
| [ubuntu-22.04_docker-v23.0.6](./docker/v23.0.6/)                                                      | v0.1.0  |
| [docker-v23.0.3](./docker/v23.0.3/)                                                                   | v0.1.0  |
| [docker-v23.0.0-devicemapper](./docker/v23.0.0-devicemapper/)                                         | v0.1.0  |
| [docker-v23.0.0](./docker/v23.0.0/)                                                                   | v0.1.0  |
| [docker-v20.10.24](./docker/v20.10.24/)                                                               | v0.1.0  |
| [docker-v20.10.19](./docker/v20.10.19/)                                                               | v0.1.0  |
| [docker-v20.10.17](./docker/v20.10.17/)                                                               | v0.1.0  |
| [docker-v20.10.12](./docker/v20.10.12/)                                                               | v0.1.0  |
| [docker-v19.03.13-debug](./docker/v19.03.13-debug/)                                                   | v0.1.0  |               | ubuntu20.04                   |
| [docker-v19.03.13](./docker/v19.03.13/)                                                               | v0.1.0  |               | ubuntu20.04                   |
| [ubuntu-18.04_docker-v23.0.6_aufs](./docker/ubuntu-18.04_docker-v23.0.6_aufs/)                        | v0.1.0  |
| [docker-v17.06.0](./docker/v17.06.0/)                                                                 | v0.1.0  |               |                               |
| [docker-v1.12.6](./docker/v1.12.6/)                                                                   | v0.1.0  |
| [docker-v1.12.5](./docker/v1.12.5/)                                                                   | v0.1.0  |
| [docker-v1.12.4](./docker/v1.12.4/)                                                                   | v0.1.0  |
| [docker-v1.12.3](./docker/v1.12.3/)                                                                   | v0.1.0  |
| [docker-v1.12.3-rc1](./docker/v1.12.3-rc1/)                                                           | v0.1.0  |               | fix cve-2016-8867             |
| [docker-v1.12.2](./docker/v1.12.2/)                                                                   | v0.1.0  | cve-2016-8867 |                               |
| [docker-v1.12.2-rc3](./docker/v1.12.2-rc3/)                                                           | v0.1.0  |               | also cve-2016-8867 vulnerable |
| [docker-v1.12.2-rc2](./docker/v1.12.2-rc2/)                                                           | v0.1.0  |               |                               |
| [docker-v1.12.1](./docker/v1.12.1/)                                                                   | v0.1.0  |
| [docker-v1.0.1-lxc](./docker/v1.0.1-lxc/)                                                             | v0.1.0  |               | lxc(dockerinit) execdriver    |
| [docker-v1.0.1](./docker/v1.0.1/)                                                                     | v0.1.0  |               | native execdriver             |
| [docker-v1.0.0-lxc](./docker/v1.0.0-lxc/)                                                             | v0.1.0  |               | lxc(dockerinit) execdriver    |
| [docker-v1.0.0](./docker/v1.0.0/)                                                                     | v0.1.0  |               | native execdriver             |
| [docker-v0.12.0-lxc](./docker/v0.12.0-lxc/)                                                           | v0.1.0  |               | lxc(dockerinit) execdriver    |
| [docker-v0.12.0](./docker/v0.12.0/)                                                                   | v0.1.0  |               | native execdriver             |
| [docker-v0.11.1-lxc](./docker/v0.11.1-lxc/)                                                           | v0.1.0  |               | lxc(dockerinit) execdriver    |
| [docker-v0.11.1](./docker/v0.11.1/)                                                                   | v0.1.0  |               | native execdriver             |
| [docker-v0.9.0-lxc](./docker/v0.9.0-lxc/)                                                             | v0.1.0  |               | lxc(dockerinit) execdriver    |
| [docker-v0.9.0](./docker/v0.9.0/)                                                                     | v0.1.0  |               | native execdriver             |
| [docker-v0.7.2](./docker/v0.7.2/)                                                                     | v0.1.0  |               | lxc(dockerinit) execdriver    |
| [docker-v0.7.1](./docker/v0.7.1/)                                                                     | v0.1.0  |               | lxc execdriver                |

### podman

| tag                                           | version | alias |
|-----------------------------------------------|---------|-------|
| [podman-v5.5.1-debug](./podman/v5.5.1-debug/) | v0.1.0  |
| [podman-v5.5.1](./podman/v5.5.1/)             | v0.1.0  |
| [podman-v5.4.0](./podman/v5.4.0/)             | v0.1.0  |

### nerdctl

| tag                                                                     | version | alias | note                                                           |
|-------------------------------------------------------------------------|---------|-------|----------------------------------------------------------------|
| [nerdctl-v2.1.2-apparmor](./nerdctl/v2.1.2-apparmor/)                   | v0.1.0  |       |
| [nerdctl-v2.1.2](./nerdctl/v2.1.2/)                                     | v0.1.0  |       |
| [nerdctl-v2.1.1](./nerdctl/v2.1.1/)                                     | v0.1.0  |       |
| nerdctl-v2.1.0                                                          | -       | -     | bug [#4241](https://github.com/containerd/nerdctl/issues/4241) |
| [nerdctl-v2.0.5](./nerdctl/v2.0.5/)                                     | v0.1.0  |
| [nerdctl-v2.0.4_runc-v1.2.5-debug](./nerdctl/v2.0.4_runc-v1.2.5-debug/) | v0.2.0  |
| [nerdctl-v2.0.4](./nerdctl/v2.0.4/)                                     | v0.2.0  | - | containerd-v2.0.4 |
| [nerdctl-v2.0.3_containerd-v2.0.3](./nerdctl/v2.0.3_containerd-v2.0.3/) | v0.1.0  | - | containerd-v2.0.3 |
| [nerdctl-v2.0.3](./nerdctl/v2.0.3/)                                     | v0.1.0  | - | containerd-v2.0.2 |
| [nerdctl-v1.7.4](./nerdctl/v1.7.4/)                                     | v0.1.0  |
| [nerdctl-v1.7.3](./nerdctl/v1.7.3/)                                     | v0.1.0  |
| [nerdctl-v1.7.0](./nerdctl/v1.7.0/)                                     | v0.1.0  |
| [nerdctl-v0.7.0-beta.0](./nerdctl/v0.7.0-beta.0/)                       | v0.1.0  |
| [nerdctl-v1.6.0](./nerdctl/v1.6.0/)                                     | v0.1.0  |
| [nerdctl-v1.5.0](./nerdctl/v1.5.0/)                                     | v0.1.0  |
| [nerdctl-v1.4.0](./nerdctl/v1.4.0/)                                     | v0.1.0  |
| [nerdctl-v1.3.0](./nerdctl/v1.3.0/)                                     | v0.1.0  |
| [nerdctl-v0.5.0](./nerdctl/v0.5.0/)                                     | v0.1.0  |

### containerd

| tag                                                                     | version | alias |
|-------------------------------------------------------------------------|---------|-------|
| [containerd-v2.1.4](./containerd/v2.1.4/)                               | v0.1.0  |
| [containerd-v2.1.1-debug](./containerd/v2.1.1-debug/)                   | v0.1.0  |
| [containerd-v2.1.1](./containerd/v2.1.1/)                               | v0.1.0  |
| [containerd-v2.1.0-debug](./containerd/v2.1.0-debug/)                   | v0.1.0  |
| [containerd-v2.1.0](./containerd/v2.1.0/)                               | v0.1.0  |
| [containerd-v2.1.0-rc.1](./containerd/v2.1.0-rc.1/)                     | v0.1.0  |
| [containerd-v2.1.0-rc.0](./containerd/v2.1.0-rc.0/)                     | v0.1.0  |
| [containerd-v2.0.5](./containerd/v2.0.5/)                               | v0.1.0  |
| [containerd-v2.1.0-beta.1](./containerd/v2.1.0-beta.1/)                 | v0.1.0  |
| [containerd-v2.1.0-beta.0](./containerd/v2.1.0-beta.0/)                 | v0.1.0  |
| [containerd-v2.0.4-fuse-overlayfs](./containerd/v2.0.4-fuse-overlayfs/) | v0.2.0  |
| [containerd-v2.0.4](./containerd/v2.0.4/)                               | v0.2.0  |
| [containerd-v2.0.3](./containerd/v2.0.3/)                               | v0.3.0  |
| [containerd-v2.0.2](./containerd/v2.0.2/)                               | v0.2.0  |
| [containerd-v1.7.18](./containerd/v1.7.18/)                             | v0.2.0  |
| [containerd-v1.7.16](./containerd/v1.7.16/)                             | v0.2.0  |
| [containerd-v1.7.15](./containerd/v1.7.15/)                             | v0.1.0  |
| [containerd-v1.7.13](./containerd/v1.7.13/)                             | v0.1.0  |
| [containerd-v1.7.8](./containerd/v1.7.8/)                               | v0.1.0  |
| [containerd-v1.7.6](./containerd/v1.7.6/)                               | v0.1.0  |
| [containerd-v1.7.3](./containerd/v1.7.3/)                               | v0.1.0  |
| [containerd-v1.7.1](./containerd/v1.7.1/)                               | v0.2.0  |
| [containerd-v1.7.0](./containerd/v1.7.0/)                               | v0.1.0  |
| [containerd-v1.6.21](./containerd/v1.6.21/)                             | v0.1.0  |
| [containerd-v1.6.19](./containerd/v1.6.19/)                             | v0.1.0  |
| [containerd-v1.6.9](./containerd/v1.6.9/)                               | v0.1.0  |
| [containerd-v1.6.7](./containerd/v1.6.7/)                               | v0.1.0  |
| [containerd-v1.6.4](./containerd/v1.6.4/)                               | v0.1.0  |
| [containerd-v1.5.2](./containerd/v1.5.2/)                               | v0.1.0  |
| [containerd-v1.5.1](./containerd/v1.5.1/)                               | v0.1.0  |
| [containerd-v1.5.0-beta.2](./containerd/v1.5.0-beta.2/)                 | v0.1.0  |
| [containerd-v1.4.3](./containerd/v1.4.3/)                               | v0.1.0  |
| [containerd-v1.4.0](./containerd/v1.4.0/)                               | v0.2.0  |
| [containerd-v1.3.8](./containerd/v1.3.8/)                               | v0.2.0  |
| [containerd-v1.3.3](./containerd/v1.3.3/)                               | v0.1.0  |
| [containerd-v0.2.4](./containerd/v0.2.4/)                               | v0.1.0  |

### buildkit

| tag                                             | version | alias | note |
|-------------------------------------------------|---------|-------|------|
| [buildkit-v0.21.1](./buildkit/v0.21.1/)         | v0.1.0  |
| [buildkit-v0.21.0](./buildkit/v0.21.0/)         | v0.1.0  |
| [buildkit-v0.21.0-rc2](./buildkit/v0.21.0-rc2/) | v0.1.0  |
| [buildkit-v0.21.0-rc1](./buildkit/v0.21.0-rc1/) | v0.1.0  |
| [buildkit-v0.20.2](./buildkit/v0.20.2/)         | v0.2.0  |
| [buildkit-v0.12.5-debug](./buildkit/v0.12.5-debug/) | v0.1.0  |
| [buildkit-v0.12.5](./buildkit/v0.12.5/) | v0.1.0  |
| [buildkit-v0.12.4-debug](./buildkit/v0.12.4-debug/) | v0.1.0  |
| [buildkit-v0.12.4](./buildkit/v0.12.4/) | v0.1.0  |
| [buildkit-v0.12.0](./buildkit/v0.12.0/) | v0.1.0  |
| [buildkit-v0.11.0](./buildkit/v0.11.0/) | v0.1.0  |
| [buildkit-v0.11.0-rc2](./buildkit/v0.11.0-rc2/) | v0.1.0  |
| [buildkit-v0.11.0-rc1](./buildkit/v0.11.0-rc1/) | v0.1.0  |
| [buildkit-v0.10.6](./buildkit/v0.10.6/) | v0.1.0  |
| [buildkit-v0.10.5](./buildkit/v0.10.5/) | v0.1.0  |
| [buildkit-v0.10.3](./buildkit/v0.10.3/) | v0.1.0  |
| [buildkit-v0.10.0](./buildkit/v0.10.0/) | v0.1.0  |
| [buildkit-v0.9.0](./buildkit/v0.9.0/) | v0.1.0  |
| [buildkit-v0.7.0](./buildkit/v0.7.0/) | v0.1.0  |
| [buildkit-v0.5.0](./buildkit/v0.5.0/) | v0.1.0  |
| [buildkit-v0.4.0](./buildkit/v0.4.0/) | v0.1.0  |
| [buildkit-v0.3.0](./buildkit/v0.3.0/) | v0.1.0  |

### runc

| tag                                                                                        | version | alias | note                                                                        |
|--------------------------------------------------------------------------------------------|---------|-------|-----------------------------------------------------------------------------|
| [runc-v1.3.3](./runc/v1.3.3/)                                                              | v0.1.0  |       | ubuntu24.04                                                                 |
| [runc-v1.3.0](./runc/v1.3.0/)                                                              | v0.1.0  |       | ubuntu24.04                                                                 |
| [runc-v1.3.0-rc.2_criu](./runc/v1.3.0-rc.2_criu/)                                          | v0.1.0  |       | ubuntu24.04                                                                 |
| [runc-v1.3.0-rc.2](./runc/v1.3.0-rc.2/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [debian-11.0_runc-v1.3.0-rc.1_criu-v3.14](./runc/debian-11.0_runc-v1.3.0-rc.1_criu-v3.14/) | v0.1.0  |       | debian-11.0                                                                 |
| [runc-v1.3.0-rc.1_criu](./runc/v1.3.0-rc.1_criu/)                                          | v0.1.0  |       | ubuntu24.04                                                                 |
| [centos-stream9_runc-v1.3.0-rc.1_selinux](./runc/centos-stream9_runc-v1.3.0-rc.1_selinux/) | v0.1.0  |       | centos-stream9                                                              |
| [centos-stream9_runc-v1.3.0-rc.1](./runc/centos-stream9_runc-v1.3.0-rc.1/)                 | v0.1.0  |       | centos-stream9                                                              |
| [debian-11.0_runc-v1.3.0-rc.1](./runc/debian-11.0_runc-v1.3.0-rc.1/)                       | v0.1.0  |       | debian-11.0                                                                 |
| [runc-v1.3.0-rc.1](./runc/v1.3.0-rc.1/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [debian-11.0_runc-v1.2.6_criu-v3.14](./runc/debian-11.0_runc-v1.2.6_criu-v3.14/)           | v0.1.0  |       | debian-11.0                                                                 |
| [debian-11.0_runc-v1.2.6](./runc/debian-11.0_runc-v1.2.6/)                                 | v0.1.0  |       | debian-11.0                                                                 |
| [runc-v1.2.6](./runc/v1.2.6/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.5](./runc/v1.2.5/)                                                              | v0.3.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.4](./runc/v1.2.4/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.3](./runc/v1.2.3/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.2](./runc/v1.2.2/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.1](./runc/v1.2.1/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [centos-stream9_runc-v1.2.0_selinux](./runc/centos-stream9_runc-v1.2.0_selinux/)           | v0.1.0  |       | centos-stream9                                                              |
| [centos-stream9_runc-v1.2.0](./runc/centos-stream9_runc-v1.2.0/)                           | v0.1.0  |       | centos-stream9                                                              |
| [runc-v1.2.0](./runc/v1.2.0/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.0-rc.3](./runc/v1.2.0-rc.3/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.0-rc.2](./runc/v1.2.0-rc.2/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.2.0-rc.1](./runc/v1.2.0-rc.1/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.0-a6f4081](./runc/v1.1.0-a6f4081/)                                              | v0.2.0  |       | PR#4102; ubuntu20.04                                                        |
| [runc-v1.1.0-ab3cd8d](./runc/v1.1.0-ab3cd8d/)                                              | v0.2.0  |       | PR#4102; ubuntu20.04                                                        |
| [runc-v1.1.0-7396ca9](./runc/v1.1.0-7396ca9/)                                              | v0.2.0  |       | PR#4102; ubuntu20.04                                                        |
| [runc-v1.1.0-d3d7f7d](./runc/v1.1.0-d3d7f7d/)                                              | v0.2.0  |       | PR#4102; ubuntu20.04                                                        |
| [runc-v1.1.0-7d09ba1](./runc/v1.1.0-7d09ba1/)                                              | v0.2.0  |       | PR#3825; ubuntu20.04                                                        |
| [runc-v1.1.15](./runc/v1.1.15/)                                                            | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.14](./runc/v1.1.14/)                                                            | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.13](./runc/v1.1.13/)                                                            | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.12](./runc/v1.1.12/)                                                            | v0.4.0  |       | ubuntu22.04                                                                 |
| [runc-v1.1.11](./runc/v1.1.11/)                                                            | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.10](./runc/v1.1.10/)                                                            | v0.2.0  |       | ubuntu24.04                                                                 |
| [ubuntu-20.04_runc-v1.1.9](./runc/ubuntu-20.04_runc-v1.1.9/)                               | v0.2.0  |       | ubuntu20.04                                                                 |
| [runc-v1.1.9](./runc/v1.1.9/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.8](./runc/v1.1.8/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.7](./runc/v1.1.7/)                                                              | v0.3.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.6](./runc/v1.1.6/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.5](./runc/v1.1.5/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.4](./runc/v1.1.4/)                                                              | v0.3.0  |       | ubuntu22.04                                                                 |
| [runc-v1.1.3](./runc/v1.1.3/)                                                              | v0.3.0  |       | ubuntu22.04                                                                 |
| [runc-v1.1.2](./runc/v1.1.2/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.1](./runc/v1.1.1/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.0](./runc/v1.1.0/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.1.0-rc.1](./runc/v1.1.0-rc.1/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.3](./runc/v1.0.3/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.2](./runc/v1.0.2/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.1](./runc/v1.0.1/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.0](./runc/v1.0.0/)                                                              | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.0-rc95](./runc/v1.0.0-rc95/)                                                    | v0.3.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc94](./runc/v1.0.0-rc94/)                                                    | v0.3.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc93](./runc/v1.0.0-rc93/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.0-rc92](./runc/v1.0.0-rc92/)                                                    | v0.3.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc91](./runc/v1.0.0-rc91/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.0-rc90](./runc/v1.0.0-rc90/)                                                    | v0.2.0  |       | ubuntu24.04                                                                 |
| [runc-v1.0.0-rc10](./runc/v1.0.0-rc10/)                                                    | v0.3.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc9](./runc/v1.0.0-rc9/)                                                      | v0.2.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc8](./runc/v1.0.0-rc8/)                                                      | v0.2.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc7](./runc/v1.0.0-rc7/)                                                      | v0.2.0  |       | ubuntu20.04; Bug: [#2043](https://github.com/opencontainers/runc/pull/2043) |
| [runc-v1.0.0-rc6](./runc/v1.0.0-rc6/)                                                      | v0.2.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc5](./runc/v1.0.0-rc5/)                                                      | v0.2.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc4](./runc/v1.0.0-rc4/)                                                      | v0.2.0  |       | ubuntu20.04                                                                 |
| [runc-v1.0.0-rc3-dbg](./runc/v1.0.0-rc3-dbg/)                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v1.0.0-rc3](./runc/v1.0.0-rc3/)                                                      | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v1.0.0-rc2-dbg](./runc/v1.0.0-rc2-dbg/)                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v1.0.0-rc2](./runc/v1.0.0-rc2/)                                                      | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v1.0.0-rc1](./runc/v1.0.0-rc1/)                                                      | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.1.1](./runc/v0.1.1/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.1.0](./runc/v0.1.0/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.9](./runc/v0.0.9/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.8](./runc/v0.0.8/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.7](./runc/v0.0.7/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.6](./runc/v0.0.6/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.5](./runc/v0.0.5/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.4](./runc/v0.0.4/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.3](./runc/v0.0.3/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.2.1](./runc/v0.0.2.1/)                                                          | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.2](./runc/v0.0.2/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |
| [runc-v0.0.1](./runc/v0.0.1/)                                                              | v0.2.0  |       | ubuntu16.04                                                                 |

### ubuntu

| tag                                     | version | alias |
|-----------------------------------------|---------|-------|
| [ubuntu-24.04](./ubuntu/24.04/)         | v0.3.0  |
| [ubuntu-22.04-dbg](./ubuntu/22.04-dbg/) | v0.2.0  |
| [ubuntu-22.04](./ubuntu/22.04/)         | v0.3.0  |
| [ubuntu-20.04](./ubuntu/20.04/)         | v0.2.0  |
| [ubuntu-18.04](./ubuntu/18.04/)         | v0.2.0  |
| [ubuntu-16.04](./ubuntu/16.04/)         | v0.2.0  |
| [ubuntu-14.04](./ubuntu/14.04/)         | v0.2.0  |
| [ubuntu-12.04](./ubuntu/12.04/)         | v0.2.0  |

### debian

| tag                           | version | alias |
|-------------------------------|---------|-------|
| [debian-12.0](./debian/12.0/) | v0.2.0  |       |
| [debian-11.0](./debian/11.0/) | v0.1.0  |       |

### centos

| tag                     | version | alias |
|-------------------------|---------|-------|
| [centos-9](./centos/9/) | v0.2.0  |       |
| [centos-8](./centos/8/) | v0.2.0  |       |

## Known Issues

### ssh stuck https://github.com/ssst0n3/docker_archive/issues/10

ssh will be stuck when running some images, but some won't.

I don't known the exactly reason. If you met this issue, try this command instead

```
docker network create test
docker run --network=test ...
```

### window size so small

use ssh or execute commands below in the vm

```
apt install -y xterm && resize
```
