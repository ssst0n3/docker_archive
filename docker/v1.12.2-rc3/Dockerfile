ARG VERSION_DOCKER=1.12.2-rc3
ARG VERSION_UBUNTU=16.04
ARG VERSION_IMAGE=0.2.0
ARG URL_ARTIFACT_SYSTEMD=https://raw.githubusercontent.com/moby/moby/refs/tags/v${VERSION_DOCKER}/contrib/init/systemd
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}

FROM docker:${VERSION_DOCKER} AS docker_bins

FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG VERSION_DOCKER
ARG URL_ARTIFACT_SYSTEMD
# install docker bins
COPY --chmod=755 --from=docker_bins /usr/local/bin/* /usr/bin/
# install systemd services
ADD ${URL_ARTIFACT_SYSTEMD}/docker.service /usr/local/lib/systemd/system/docker.service
ADD ${URL_ARTIFACT_SYSTEMD}/docker.socket /usr/local/lib/systemd/system/docker.socket
RUN groupadd --system docker && \
    systemctl enable docker.service
# install dependencies
RUN apt update && apt install -y iptables
