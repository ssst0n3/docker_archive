FROM ssst0n3/docker_archive:ctr_runc-v1.2.5_v0.1.0

# install containerd
ADD https://github.com/containerd/containerd/releases/download/v2.0.3/containerd-2.0.3-linux-amd64.tar.gz /tmp/containerd.tar.gz
RUN tar Cxzvf /usr/local /tmp/containerd.tar.gz \
    && rm /tmp/containerd.tar.gz

# config systemd
ADD https://raw.githubusercontent.com/containerd/containerd/main/containerd.service /usr/local/lib/systemd/system/containerd.service

# squash
FROM scratch AS release
COPY --from=build / /