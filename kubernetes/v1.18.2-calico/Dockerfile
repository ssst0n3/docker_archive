# syntax=docker/dockerfile:1-labs
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v1.18.2
ARG VERSION_IMAGE=0.1.0
FROM ${BASE_IMAGE}_v${VERSION_IMAGE}

COPY --chmod=755 service/init.sh /init.sh
COPY service/init.service /usr/lib/systemd/system/

RUN systemctl enable init.service

# there seems a bug in systemd when executing `systemctl exit 0`:
#   ExitCode can only be set for user service managers or in containers.
# a trick to allow `systemctl exit 0` is setup the env container
# https://github.com/systemd/systemd/blob/v245.4/src/basic/virt.c#L503
ENV container=docker

RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/trick \
    cp -r /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# copy snapshots from cache
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/trick \
    cp -r /trick/* /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/

# finish
RUN rm /usr/lib/systemd/system/init.service /init.sh
