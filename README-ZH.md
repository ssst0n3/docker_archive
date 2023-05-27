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

**ssh**
```
$ docker network create test
$ docker run --network=test -d -p 2222:22 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92
$ ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
...
```

**tty**
```
docker run -tid --name archive ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92
docker attach --detach-keys="ctrl-x" archive
```

**kvm**
```
docker run -ti --dev /dev/kvm ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1 /start_vm.sh -enable-kvm
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
可以在 [tags页面](https://github.com/ssst0n3/docker_archive/tags) 查看，

或者在[这里](./images.md)查看所有的镜像列表。

## 已知问题

### ssh 连接失败 https://github.com/ssst0n3/docker_archive/issues/10

ssh 可能在使用有些镜像时可能会卡住，但有些不会。

我还不知道具体的原因，如果你遇到了同样的问题，可以尝试使用新创建的网桥启动容器：

```
docker network create test
docker run --network=test ...
```

### 虚拟机的窗口太小了

可以使用ssh连接，或在虚拟机中执行以下命令
```
apt install -y xterm && resize
```
