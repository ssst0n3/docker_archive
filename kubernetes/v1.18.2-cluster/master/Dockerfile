# syntax=docker/dockerfile:1-labs
ARG VERSION_K8S=1.18.2
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-calico

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS pre
COPY --chmod=755 service/init.sh /init.sh
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/setup-hosts.sh /setup-hosts.sh
COPY service/setup-hosts.service /usr/lib/systemd/system/
RUN systemctl enable init.service && \
    systemctl reenable setup-hosts.service

FROM pre AS wait-join
# there seems a bug in systemd when executing `systemctl exit 0`:
#   ExitCode can only be set for user service managers or in containers.
# a trick to allow `systemctl exit 0` is setup the env container
# https://github.com/systemd/systemd/blob/v245.4/src/basic/virt.c#L503
ENV container=docker
# copy image snapshots
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/trick \
    cp -r /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# wait join
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# copy snapshots from cache
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/trick \
    cp -rf /trick/* /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ || true

FROM wait-join AS final
RUN rm /usr/lib/systemd/system/init.service /init.sh
RUN apt update && \
    apt install -y cloud-init && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
