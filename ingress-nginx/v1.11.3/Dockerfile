# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.32.3-calico_v0.1.0 as build

COPY service/init.sh /init.sh
COPY service/init.service /usr/lib/systemd/system/

RUN systemctl enable init.service
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

# finish
RUN rm /usr/lib/systemd/system/init.service /init.sh

# squash
FROM scratch as release
COPY --from=build / /
