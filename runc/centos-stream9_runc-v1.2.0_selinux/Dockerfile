ARG VERSION_RUNC=1.2.0
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_centos-stream9_runc-v${VERSION_RUNC}

FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
RUN dnf install -y \
    selinux-policy \
    selinux-policy-targeted \
    policycoreutils \
    policycoreutils-python-utils && \
    dnf clean all && \
    rm -rf /var/cache/dnf/* && \
    touch /.autorelabel
