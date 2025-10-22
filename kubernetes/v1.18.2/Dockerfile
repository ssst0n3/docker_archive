# syntax=docker/dockerfile:1-labs

ARG VERSION_K8S=1.18.2
ARG VERSION_KIND=0.12.0
ARG URL_ARTIFACT_KIND=https://raw.githubusercontent.com/kubernetes-sigs/kind/refs/tags/v${VERSION_KIND}
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-base

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS kube_init
ARG URL_ARTIFACT_KIND
COPY service/kubeadm.conf /kind/
COPY --chmod=755 service/init.sh /
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/hosts.sh /
COPY service/hosts.service /usr/lib/systemd/system/
RUN systemctl enable kubelet.service && \
    systemctl enable init.service
ENV KUBECONFIG=/etc/kubernetes/admin.conf

# there seems a bug in systemd when executing `systemctl exit 0`:
#   ExitCode can only be set for user service managers or in containers.
# a trick to allow `systemctl exit 0` is setup the env container
# https://github.com/systemd/systemd/blob/v245.4/src/basic/virt.c#L503
ENV container=docker

# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# copy snapshots from cache
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/trick \
    cp /trick/* /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/ -r

FROM kube_init AS final
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh && \
    systemctl enable hosts.service
