# 如何贡献

## 1. 原理

docker的一大优势在于，可以在基础镜像的基础上进行修改，生成新的镜像。要是虚拟机也能实现类似的效果就好了，刚好cloud-init提供了类似的能力！

本项目借助cloud-init安装了制定版本的容器软件，并通过docker in qemu in docker的形式，将容器环境封装成了容器镜像。

下面让我们具体了解一下实现原理。

### 1.1 项目结构
与传统的git仓库用法不同，本项目的每个分支之间没有联系，每个分支都对应一个容器镜像。

例如分支 `branch_ubuntu-22.04_docker-ce-20.10.17_docker-ce-cli-20.10.17_containerd.io-1.6.6-1_docker-compose-plugin-2.6.0` 对应一个 `ssst0n3/docker_archive:ubuntu-22.04_docker-ce-20.10.17_docker-ce-cli-20.10.17_containerd.io-1.6.6-1_docker-compose-plugin-2.6.0` 镜像，该分支维护了该镜像构建所需的源码。

为了新增一个容器镜像，我们需要向本项目提交一个新的分支，以如下结构提供镜像构建文件。

* Dockerfile: 镜像构建文件
* cloud.txt: cloud-init配置文件，定义了将要在虚拟机启动时执行的命令

下面我们分别解释这两个文件的内容：

#### 1.1.1 Dockerfile

以分支 `branch_ubuntu-22.04_docker-ce-20.10.17_docker-ce-cli-20.10.17_containerd.io-1.6.6-1_docker-compose-plugin-2.6.0` 为例，

```Dockerfile
FROM ssst0n3/docker_archive:build_basic_ubuntu-22.04-20220609
# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

RUN /init_qemu.expect 
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ssst0n3/docker_archive:release_basic_ubuntu-20.04
COPY --from=0 /ubuntu-server-cloudimg.img /
```

#### 1.1.2 cloud.txt



```
#cloud-config
user: root
password: root
chpasswd: {expire: False}
ssh_pwauth: True
runcmd:
  - echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
  - sed -i "s@http://.*.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
  - apt-get update
  - apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu jammy stable"
  - apt-get update
  - apt-get install -y docker-ce=5:20.10.17~3-0~ubuntu-jammy docker-ce-cli=5:20.10.17~3-0~ubuntu-jammy containerd.io=1.6.6-1 docker-compose-plugin=2.6.0~ubuntu-jammy
```

## 2. 编译镜像

### 2.1 手动编译

下载指定分支代码，执行docker build 命令编译镜像。例如：

```
git clone https://github.com/ssst0n3/docker_archive.git
git checkout branch_ubuntu-22.04_docker-ce-20.10.17_docker-ce-cli-20.10.17_containerd.io-1.6.6-1_docker-compose-plugin-2.6.0
docker build -t ubuntu-22.04_docker-ce-20.10.17_docker-ce-cli-20.10.17_containerd.io-1.6.6-1_docker-compose-plugin-2.6.0 .
```

### 2.2 自动编译

上述手动编译镜像的速度是很慢的，有这个时间手动搭建环境早都搭建完了，这真的值得吗？

别担心，我们有很多自动化手段，可以批量得在后台编译。

#### 2.2.1 dockerhub

#### 2.2.2 github action

#### 2.2.3 CI/CD