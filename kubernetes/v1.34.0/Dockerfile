# syntax=docker/dockerfile:1-labs

# k8s version: https://github.com/kubernetes-sigs/kind/blob/v0.28.0/pkg/apis/config/defaults/image.go#L21
ARG VERSION_K8S=1.34.0
ARG VERSION_KIND=0.28.0
ARG URL_ARTIFACT_KIND=https://raw.githubusercontent.com/kubernetes-sigs/kind/refs/tags/v${VERSION_KIND}
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-base

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS kube_init
ARG URL_ARTIFACT_KIND
# kubeadm init
ADD ${URL_ARTIFACT_KIND}/images/base/files/etc/systemd/system/kubelet.service.d/11-kind.conf /etc/systemd/system/kubelet.service.d/11-kind.conf
ADD --chmod=755 ${URL_ARTIFACT_KIND}/images/base/files/kind/bin/create-kubelet-cgroup-v2.sh /kind/bin/create-kubelet-cgroup-v2.sh
RUN cat /etc/systemd/system/kubelet.service.d/11-kind.conf
COPY service/kubeadm.conf /kind/
COPY service/init.sh /
COPY service/init.service /usr/lib/systemd/system/
COPY service/setup-hosts.service /usr/lib/systemd/system/
RUN systemctl enable kubelet.service && \
    systemctl enable init.service
ENV KUBECONFIG=/etc/kubernetes/admin.conf
RUN sed -i '/exit 1/d' /kind/bin/create-kubelet-cgroup-v2.sh
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

FROM kube_init AS final
RUN apt update && \
    apt install -y cloud-init && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh && \
    systemctl enable setup-hosts.service
