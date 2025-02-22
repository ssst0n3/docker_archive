# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_containerd-v2.0.2_v0.1.0 AS static

# ipv4 forwarding
RUN echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/k8s.conf 
    # not work in dockerfile
    # sysctl --system

# cgroup driver: systemd is the default

# install CNI plugins
ADD https://github.com/containernetworking/plugins/releases/download/v1.6.2/cni-plugins-linux-amd64-v1.6.2.tgz /tmp/cni-plugins.tgz
RUN mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin /tmp/cni-plugins.tgz

# install kubeadm, kubelet, kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gpg && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubelet=1.32.2-1.1 kubeadm=1.32.2-1.1 kubectl=1.32.2-1.1 && \
    apt-mark hold kubelet kubeadm kubectl && \
    apt-get install -y kmod

# FROM static AS dynamic
# RUN mv /usr/bin/systemctl /usr/bin/systemctl.orig
# ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-images/f67d3a2a21a6b4f1b540a5ddae88101ba10f3633/files/docker/systemctl3.py /usr/bin/
# RUN chmod +x /usr/bin/systemctl3.py && ln -s /usr/bin/systemctl3.py /usr/bin/systemctl

# FROM dynamic AS preflight
# # pull kubeadm image
# RUN --security=insecure systemctl start containerd && \
#     kubeadm config images list --kubernetes-version v1.32.2 | xargs -n 1 ctr -n k8s.io images pull && \
#     crictl images
# # RUN --security=insecure containerd & \
# #     sleep 5 && \
# #     kubeadm config images list --kubernetes-version v1.32.2 | xargs -n 1 ctr -n k8s.io images pull && \
# #     crictl images

# # FROM busybox AS mknod
# # RUN mknod /console c 5 1
# # RUN --security=insecure ls -lah /console && echo 123 > /console

FROM static AS kubeadm_init
# kubeadm init
COPY --from=kindest/node:v1.32.2 /kind/ /kind/
COPY --from=kindest/node:v1.32.2 /etc/systemd/system/kubelet.service.d/11-kind.conf /etc/systemd/system/kubelet.service.d/11-kind.conf
COPY kubeadm.conf /kind/
COPY kubeadm-init.service /usr/lib/systemd/system/kubeadm-init.service
RUN systemctl enable kubelet.service
RUN systemctl enable kubeadm-init.service
# RUN ln -s /etc/systemd/system/kubeadm-init.service /etc/systemd/system/multi-user.target.wants/
ENV KUBECONFIG=/etc/kubernetes/admin.conf
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

# RUN apt install -y systemd
# # COPY entrypoint /entrypoint
# RUN find /lib/systemd/system/sysinit.target.wants/ -name "systemd-tmpfiles-setup.service" -delete \
#     && rm -f /lib/systemd/system/multi-user.target.wants/* \
#     && rm -f /etc/systemd/system/*.wants/* \
#     && rm -f /lib/systemd/system/local-fs.target.wants/* \
#     && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
#     && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
#     && rm -f /lib/systemd/system/basic.target.wants/* \
#     && echo "ReadKMsg=no" >> /etc/systemd/journald.conf \
#     && ln -sf "$(which systemd)" /sbin/init

# RUN echo "Enabling / Disabling services ... " \
#     && systemctl enable kubelet.service \
#     && systemctl enable containerd.service \
#     && systemctl mask systemd-binfmt.service
# STOPSIGNAL SIGRTMIN+3
# RUN apt update && apt install -y systemd && rm /sbin/init && ln -s "$(which systemd)" /sbin/init
# ["/entrypoint", "/sbin/init", "-log-target=kmsg"]
# RUN --security=insecure \
#     systemctl start containerd && \
#     /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///run/containerd/containerd.sock --node-ip=172.17.0.2 --node-labels= --pod-infra-container-image=registry.k8s.io/pause:3.10 --provider-id=kind://docker/kind/kind-control-plane --runtime-cgroups=/system.slice/containerd.service
    # systemctl start kubelet || \
    # systemctl status kubelet
# RUN --security=insecure --mount=type=bind,rw,from=mknod,source=/console,target=/dev/null \
    # ["/sbin/init", "--log-target=console"]
# COPY kubeadm.conf /kind/
# COPY kubeadm-init.service /etc/systemd/system/kubeadm-init.service
# RUN rm /usr/bin/systemctl && ln -s /usr/bin/systemctl.orig /usr/bin/systemctl
# RUN ln -s /etc/systemd/system/kubeadm-init.service /etc/systemd/system/multi-user.target.wants/
# RUN --security=insecure ["/sbin/init", "--log-target=console"]
# RUN --security=insecure ["/usr/lib/systemd/systemd", "--log-target=console", "--default-standard-output=tty", "--default-standard-error=tty", "--log-level=debug"]
# RUN --security=insecure ["/sbin/init", "--default-standard-output=journal+console", "--default-standard-error=journal+console", "--log-level=debug"]


# # create cluster
# RUN sh -c 'containerd &' && \
#     sleep 5 && \
#     kubeadm init --pod-network-cidr=192.168.0.0/16 --kubernetes-version=1.32.2 && \
#     mkdir -p /root/.kube && \
#     cp /etc/kubernetes/admin.conf /root/.kube/config

# ENV KUBECONFIG=/etc/kubernetes/admin.conf

# RUN kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# CMD []
