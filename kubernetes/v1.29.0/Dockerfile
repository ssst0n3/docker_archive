# syntax=docker/dockerfile:1-labs

ARG VERSION_K8S=1.29.0
ARG VERSION_KIND=0.20.0
ARG URL_ARTIFACT_KIND=https://raw.githubusercontent.com/kubernetes-sigs/kind/refs/tags/v${VERSION_KIND}
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-base

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS pre
ARG URL_ARTIFACT_KIND
# kubeadm init
ADD ${URL_ARTIFACT_KIND}/images/base/files/etc/systemd/system/kubelet.service.d/11-kind.conf /etc/systemd/system/kubelet.service.d/11-kind.conf
ADD --chmod=755 ${URL_ARTIFACT_KIND}/images/base/files/kind/bin/create-kubelet-cgroup-v2.sh /kind/bin/create-kubelet-cgroup-v2.sh
RUN sed -i '/exit 1/d' /kind/bin/create-kubelet-cgroup-v2.sh
COPY service/kubeadm.conf /kind/
COPY --chmod=755 service/init.sh /
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/hosts.sh /
COPY service/hosts.service /usr/lib/systemd/system/
RUN systemctl enable kubelet.service && \
    systemctl enable init.service

FROM pre AS kube_init
ENV KUBECONFIG=/etc/kubernetes/admin.conf
ARG CACHE_BUST
RUN echo "No cache from here, value: $CACHE_BUST"
# copy image snapshots
RUN --mount=type=cache,id=kubernetes-v1.29.0-snapshots,target=/trick \
    cp -r /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.29.0-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0)
# fix: `#20 5.255 cp: cannot create special file '/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/27/fs/var/cache/debconf/config.dat': Operation not permitted`
RUN --mount=type=cache,id=kubernetes-v1.29.0-snapshots,target=/trick \
    --security=insecure \
    cp -rf /trick/* /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ || true

FROM kube_init AS final
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh && \
    systemctl enable hosts.service
