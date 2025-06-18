ARG VERSION_CENTOS=stream9
ARG VERSION_IMAGE=0.2.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_centos-${VERSION_CENTOS}
FROM ${BASE_IMAGE}_v${VERSION_IMAGE}

# install podman
# RUN dnf list \
#     podman \
#     --showduplicates | sort -r

RUN dnf -y install \
    podman-5:5.4.0-5.el9
