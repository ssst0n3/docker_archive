# syntax=docker/dockerfile:1-labs

ARG VERSION_K8S=1.24.0
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-base

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS pre
COPY service/kubeadm.conf /kind/
COPY --chmod=755 service/init.sh /
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/hosts.sh /
COPY service/hosts.service /usr/lib/systemd/system/
# fix systemd-245 systemd-shutdown hangs on containerd-shim
# https://github.com/k3s-io/k3s/issues/6218
COPY service/cgroup-kill.service /usr/lib/systemd/system/cgroup-kill.service
RUN systemctl enable kubelet.service && \
    systemctl enable init.service && \
    systemctl enable cgroup-kill.service
# fix 'apparmor-parser missing'
# Nov 23 08:11:51 kubernetes-1-24-0 kubelet[296]: E1123 08:11:51.915042     296 pod_workers.go:951] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"kube-controller-manager\" with CreateContainerError: \"failed to create containerd container: get apparmor_parser version: exec: \\\"apparmor_parser\\\": executable file not found in $PATH\"" pod="kube-system/kube-controller-manager-kubernetes-1-24-0" podUID=d8429215a7530d61ed99b0c6d45b1806
RUN apt update && \
    apt install -y apparmor-utils && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/containerd && \
    containerd config default > /etc/containerd/config.toml && \
    sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

FROM pre AS kube_init
# kubeadm init
ENV KUBECONFIG=/etc/kubernetes/admin.conf
# there seems a bug in systemd when executing `systemctl exit 0`:
#   ExitCode can only be set for user service managers or in containers.
# a trick to allow `systemctl exit 0` is setup the env container
# https://github.com/systemd/systemd/blob/v245.4/src/basic/virt.c#L503
ENV container=docker
ARG CACHE_BUST
RUN echo "No cache from here, value: $CACHE_BUST"
# copy image snapshots
RUN --mount=type=cache,id=kubernetes-v1.24.0-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.24.0-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0)
# fix: `#20 5.255 cp: cannot create special file '/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/27/fs/var/cache/debconf/config.dat': Operation not permitted`
RUN --mount=type=cache,id=kubernetes-v1.24.0-snapshots,target=/trick \
    # use tar to preserve file capabilities
    tar -C /trick -cf - . | tar -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -

FROM kube_init AS final
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh && \
    systemctl enable hosts.service
