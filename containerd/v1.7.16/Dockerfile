FROM ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.1.0

# install containerd
ADD https://github.com/containerd/containerd/releases/download/v1.7.16/containerd-1.7.16-linux-amd64.tar.gz /tmp/containerd.tar.gz
RUN tar Cxzvf /usr/local /tmp/containerd.tar.gz

# config systemd
ADD https://raw.githubusercontent.com/containerd/containerd/main/containerd.service /usr/local/lib/systemd/system/containerd.service