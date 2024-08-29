# docker archive: Provide many versions of images of docker and docker's components

See all images listed in [dockerhub](https://hub.docker.com/repository/docker/ssst0n3/docker_archive/tags?page=1&ordering=last_updated).

## How-To

## Images

### vul

| tag | version | alias | note |
| --- | --- | --- | --- |
| [shocker_docker-v0.7.1](./vul/shocker/shocker_docker-v0.7.1/) | v0.1.0 | | use lxc as execdriver |
| [shocker_docker-v0.7.2](./vul/shocker/shocker_docker-v0.7.2/) | v0.1.0 | | use lxc(dockerinit) as execdriver |

### docker

| tag | version | alias |
| --- | --- | --- |
| [docker-v0.7.1](./docker/v0.7.1/) | v0.1.0 |
| [docker-v0.7.2](./docker/v0.7.2/) | v0.1.0 |
| [docker-v0.9.0](./docker/v0.9.0/) | v0.1.0 |
| [ubuntu-18.04_docker-v23.0.6_aufs](./docker/ubuntu-18.04_docker-v23.0.6_aufs/) | v0.1.0 |
| [ubuntu-22.04_docker-v23.0.6](./docker/v23.0.6/) | v0.1.0 |
| [ubuntu-22.04_docker-v26.1.4](./docker/v26.1.4/) | v0.1.0 |

### containerd

| tag | version | alias |
| --- | --- | --- |
| [ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16](./containerd/v1.7.16/) | v0.1.0 |

### runc

| tag | version | alias |
| --- | --- | --- |
| [ubuntu-22.04_runc-v1.1.12](./runc/v1.1.12/) | v0.1.0 |

### ubuntu

| tag | version | alias |
| --- | --- | --- |
| [ubuntu-12.04](./ubuntu/12.04/) | v0.1.0 |
| [ubuntu-16.04](./ubuntu/16.04/) | v0.1.0 |
| [ubuntu-18.04](./ubuntu/18.04/) | v0.1.0 |
| [ubuntu-22.04](./ubuntu/22.04/) | v0.1.0 |

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
