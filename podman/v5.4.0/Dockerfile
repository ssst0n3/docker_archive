ARG VERSION_CENTOS=stream9
ARG VERSION_IMAGE=0.2.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_centos-${VERSION_CENTOS}

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS podman
# install podman
# RUN dnf list \
#     podman \
#     --showduplicates | sort -r
RUN dnf -y install \
    podman-5:5.4.0-5.el9

FROM podman AS rootless
# enable write /proc/[pid]/uid_map and /proc/[pid]/gid_map
RUN chmod 4755 /usr/bin/newuidmap /usr/bin/newgidmap
# add user
RUN useradd -m -U -d /home/user -s /bin/bash user
# enable systemd cgroup for user
# equivalent to loginctl enable-linger test
RUN mkdir -p /var/lib/systemd/linger && \
    touch /var/lib/systemd/linger/user && \
    chmod 644 /var/lib/systemd/linger/user