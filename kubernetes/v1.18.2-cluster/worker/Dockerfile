# syntax=docker/dockerfile:1-labs
ARG HOSTNAME=kubernetes-1-18-2-worker
# k8s version: https://github.com/kubernetes-sigs/kind/blob/v0.28.0/pkg/apis/config/defaults/image.go#L21
ARG VERSION_K8S=1.18.2
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-base

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS pre
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname
COPY service/kubeadm.conf /kind/
COPY kubeconfig /etc/kubernetes/admin.conf
COPY --chmod=755 service/init.sh /init.sh
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/hosts.sh /hosts.sh
COPY service/hosts.service /usr/lib/systemd/system/
# fix systemd-245 systemd-shutdown hangs on containerd-shim
# https://github.com/k3s-io/k3s/issues/6218
COPY service/cgroup-kill.service /usr/lib/systemd/system/cgroup-kill.service
RUN systemctl disable kubelet.service && \
    systemctl enable init.service && \
    systemctl enable hosts.service && \
    systemctl enable cgroup-kill.service

FROM pre AS join
# there seems a bug in systemd when executing `systemctl exit 0`:
#   ExitCode can only be set for user service managers or in containers.
# a trick to allow `systemctl exit 0` is setup the env container
# https://github.com/systemd/systemd/blob/v245.4/src/basic/virt.c#L503
ENV container=docker
# copy image snapshots
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/trick \
    cp -r /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
ARG CACHE_BUST
RUN echo "No cache from here, value: $CACHE_BUST"
# wait join
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# copy snapshots from cache
RUN --mount=type=cache,id=kubernetes-v1.18.2-snapshots,target=/trick \
    cp -rf /trick/* /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ || true

FROM join AS final
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh
RUN apt update && \
    apt install -y cloud-init && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
