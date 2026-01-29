# syntax=docker/dockerfile:1-labs

ARG VERSION_K8S=1.32.4
ARG VERSION_CONTAINERD=2.0.4
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}_containerd-v${VERSION_CONTAINERD}-base

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS pre
COPY service/kubeadm.conf /kind/
COPY --chmod=755 service/init.sh /
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/hosts.sh /
COPY service/hosts.service /usr/lib/systemd/system/
RUN systemctl enable kubelet.service && \
    systemctl enable init.service
# k8s controller plane containers always restart when kubelet and containerd use different cgroup drviers.
# RUN mkdir -p /etc/containerd && \
#     containerd config default > /etc/containerd/config.toml && \
#     sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

FROM pre AS kube_init
# kubeadm init
ENV KUBECONFIG=/etc/kubernetes/admin.conf
ARG CACHE_BUST
RUN echo "No cache from here, value: $CACHE_BUST"
# copy image snapshots
RUN --mount=type=cache,id=kubernetes-v1.32.4_containerd-v2.0.4-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.32.4_containerd-v2.0.4-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0)
RUN --mount=type=cache,id=kubernetes-v1.32.4_containerd-v2.0.4-snapshots,target=/trick \
    # all these files are safe to delete, list each file path here for more clear
    rm /trick/snapshots/55/work/work/#* && \
    # use tar to preserve file capabilities
    tar -C /trick -cf - . | tar -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -

FROM kube_init AS final
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh && \
    systemctl enable hosts.service
