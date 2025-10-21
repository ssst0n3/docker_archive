# syntax=docker/dockerfile:1-labs
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v1.34.0
ARG VERSION_IMAGE=0.1.0
FROM ${BASE_IMAGE}_v${VERSION_IMAGE}

COPY service/init.sh /init.sh
COPY service/init.service /usr/lib/systemd/system/

RUN systemctl enable init.service
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

# finish
RUN rm /usr/lib/systemd/system/init.service /init.sh
