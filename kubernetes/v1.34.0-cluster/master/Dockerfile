# syntax=docker/dockerfile:1-labs
ARG VERSION_K8S=1.34.0
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-calico

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS wait-join
COPY --chmod=755 service/init.sh /init.sh
COPY service/init.service /usr/lib/systemd/system/
COPY --chmod=755 service/setup-hosts.sh /setup-hosts.sh
COPY service/setup-hosts.service /usr/lib/systemd/system/
RUN systemctl enable init.service && \
    systemctl reenable setup-hosts.service
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

FROM wait-join AS final
RUN rm /usr/lib/systemd/system/init.service /init.sh
RUN apt update && \
    apt install -y cloud-init && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
