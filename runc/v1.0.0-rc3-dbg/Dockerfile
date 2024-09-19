FROM ssst0n3/docker_archive:ctr_runc-v1.0.0-rc3_v0.1.0

WORKDIR /root
RUN mkdir -p rootfs/bin/ && \
    cp /bin/busybox rootfs/bin/ && \
    ln -s /bin/busybox rootfs/bin/sh && \
    runc spec
ADD https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v1.22.1 /tmp/dlv 
RUN install -m 755 /tmp/dlv /usr/local/sbin/dlv && \
    rm /tmp/dlv
ADD https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v1.0.0-rc3-debug-flag /tmp/runc-v1.0.0-rc3-debug-flag
RUN install -m 755 /tmp/runc-v1.0.0-rc3-debug-flag /usr/local/sbin/runc-v1.0.0-rc3-debug-flag && \
    rm /tmp/runc-v1.0.0-rc3-debug-flag && \
    mv /usr/local/sbin/runc /usr/local/sbin/runc.bak
COPY debug.sh /usr/local/sbin/runc
COPY attach.sh /usr/local/sbin/attach