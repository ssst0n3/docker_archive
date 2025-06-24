ARG VERSION_RUNC=1.2.0
ARG VERSION_CENTOS=stream9
ARG VERSION_IMAGE=0.2.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_centos-${VERSION_CENTOS}
ARG URL_ARTIFACT_RUNC=https://github.com/opencontainers/runc/releases/download/v${VERSION_RUNC}/runc.amd64
ARG URL_ARTIFACT_BUSYBOX=https://github.com/docker-library/busybox/raw/31d342ad033e27c18723a516a2274ab39547be27/stable/glibc/busybox.tar.xz

FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG URL_ARTIFACT_RUNC
ARG URL_ARTIFACT_BUSYBOX
ADD ${URL_ARTIFACT_BUSYBOX} /tmp/busybox.tar.xz
RUN dnf -y install xz && \
    dnf clean all && \
    rm -rf /var/cache/dnf
RUN mkdir -p /root/rootfs && \
    tar --exclude './dev/*' -C /root/rootfs -xf /tmp/busybox.tar.xz && \
    rm /tmp/busybox.tar.xz
ADD --chmod=755 ${URL_ARTIFACT_RUNC} /usr/local/sbin/runc
