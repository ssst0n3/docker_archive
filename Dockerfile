FROM docker:19.03.0-dind
ADD https://docker-archive-iso.obs.cn-southwest-2.myhuaweicloud.com/dockerd-19.03.0_static-without-osusergo /usr/local/bin/dockerd
RUN chmod +x /usr/local/bin/dockerd