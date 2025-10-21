# syntax=docker/dockerfile:1-labs
ARG HOSTNAME=kubernetes-1-34-0-worker
# k8s version: https://github.com/kubernetes-sigs/kind/blob/v0.28.0/pkg/apis/config/defaults/image.go#L21
ARG VERSION_K8S=1.34.0
ARG VERSION_KIND=0.28.0
ARG URL_ARTIFACT_KIND=https://raw.githubusercontent.com/kubernetes-sigs/kind/refs/tags/v${VERSION_KIND}
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-base

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS join
ARG HOSTNAME
ARG URL_ARTIFACT_KIND

RUN echo ${HOSTNAME} > /etc/hostname

ADD ${URL_ARTIFACT_KIND}/images/base/files/etc/systemd/system/kubelet.service.d/11-kind.conf /etc/systemd/system/kubelet.service.d/11-kind.conf
ADD --chmod=755 ${URL_ARTIFACT_KIND}/images/base/files/kind/bin/create-kubelet-cgroup-v2.sh /kind/bin/create-kubelet-cgroup-v2.sh
COPY kubeconfig /etc/kubernetes/admin.conf
COPY service/kubeadm.conf /kind/
COPY --chmod=755 service/init.sh /init.sh
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/setup-hosts.sh /setup-hosts.sh
COPY service/setup-hosts.service /usr/lib/systemd/system/
RUN systemctl enable kubelet.service && \
    systemctl enable init.service && \
    systemctl reenable setup-hosts.service
RUN sed -i '/exit 1/d' /kind/bin/create-kubelet-cgroup-v2.sh
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

FROM join AS final
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh
RUN apt update && \
    apt install -y cloud-init && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
