# ingress-nginx v1.11.3

* dqd:
  * ssst0n3/docker_archive:ingress-nginx-v1.11.3 -> ssst0n3/docker_archive:ingress-nginx-v1.11.3_v0.1.0
  * ssst0n3/docker_archive:ingress-nginx-v1.11.3_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_ingress-nginx-v1.11.3 -> ssst0n3/docker_archive:ctr_ingress-nginx-v1.11.3_v0.1.0
  * ssst0n3/docker_archive:ctr_ingress-nginx-v1.11.3_v0.1.0

## usage

```shell
cd ingress-nginx/v1.11.3
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@k8s-control-plane:~# kubectl describe service -n ingress-nginx ingress-nginx-controller
Name:                     ingress-nginx-controller
Namespace:                ingress-nginx
Labels:                   app.kubernetes.io/component=controller
                          app.kubernetes.io/instance=ingress-nginx
                          app.kubernetes.io/name=ingress-nginx
                          app.kubernetes.io/part-of=ingress-nginx
                          app.kubernetes.io/version=1.11.3
Annotations:              <none>
Selector:                 app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
Type:                     LoadBalancer
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.96.110.135
IPs:                      10.96.110.135
Port:                     http  80/TCP
TargetPort:               http/TCP
NodePort:                 http  30534/TCP
Endpoints:                192.168.229.144:80
Port:                     https  443/TCP
TargetPort:               https/TCP
NodePort:                 https  30705/TCP
Endpoints:                192.168.229.144:443
Session Affinity:         None
External Traffic Policy:  Local
Internal Traffic Policy:  Cluster
HealthCheck NodePort:     31480
Events:                   <none>
```

```shell
root@k8s-control-plane:~# kubectl version
Client Version: v1.32.3
Kustomize Version: v5.5.0
Server Version: v1.32.3
root@k8s-control-plane:~# kubectl get pods -A
NAMESPACE          NAME                                        READY   STATUS      RESTARTS      AGE
calico-apiserver   calico-apiserver-57dd8f7454-k9xxg           1/1     Running     2 (93s ago)   11h
calico-apiserver   calico-apiserver-57dd8f7454-pr2zh           1/1     Running     2 (93s ago)   11h
calico-system      calico-kube-controllers-df4bbfd8-w8ppj      1/1     Running     2 (93s ago)   11h
calico-system      calico-node-qk6vt                           1/1     Running     2 (93s ago)   11h
calico-system      calico-typha-766f455b86-ptrvx               1/1     Running     2 (93s ago)   11h
calico-system      csi-node-driver-476g9                       2/2     Running     4 (93s ago)   11h
ingress-nginx      ingress-nginx-admission-create-7dj2s        0/1     Completed   0             59m
ingress-nginx      ingress-nginx-admission-patch-jzwpx         0/1     Completed   0             59m
ingress-nginx      ingress-nginx-controller-9456df685-9rlkg    1/1     Running     1 (93s ago)   59m
kube-system        coredns-668d6bf9bc-cvzp8                    1/1     Running     2 (93s ago)   11h
kube-system        coredns-668d6bf9bc-pbl46                    1/1     Running     2 (93s ago)   11h
kube-system        etcd-k8s-control-plane                      1/1     Running     3 (93s ago)   11h
kube-system        kube-apiserver-k8s-control-plane            1/1     Running     3 (93s ago)   11h
kube-system        kube-controller-manager-k8s-control-plane   1/1     Running     3 (93s ago)   11h
kube-system        kube-proxy-t62f7                            1/1     Running     3 (93s ago)   11h
kube-system        kube-scheduler-k8s-control-plane            1/1     Running     3 (93s ago)   11h
tigera-operator    tigera-operator-789496d6f5-4dckq            1/1     Running     2 (93s ago)   11h
root@k8s-control-plane:~# kubectl get service -A
NAMESPACE          NAME                                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
calico-apiserver   calico-api                           ClusterIP      10.96.169.64    <none>        443/TCP                      11h
calico-system      calico-kube-controllers-metrics      ClusterIP      None            <none>        9094/TCP                     11h
calico-system      calico-typha                         ClusterIP      10.96.67.10     <none>        5473/TCP                     11h
default            kubernetes                           ClusterIP      10.96.0.1       <none>        443/TCP                      11h
ingress-nginx      ingress-nginx-controller             LoadBalancer   10.96.110.135   <pending>     80:30534/TCP,443:30705/TCP   60m
ingress-nginx      ingress-nginx-controller-admission   ClusterIP      10.96.70.181    <none>        443/TCP                      60m
kube-system        kube-dns                             ClusterIP      10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP       11h
```

```shell
root@k8s-control-plane:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.3 06b99ca80cdbfbc6cc8bd567021738c9af2b36ce
root@k8s-control-plane:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@k8s-control-plane:~# uname -a
Linux k8s-control-plane 6.8.0-56-generic #58-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb 14 15:33:28 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@k8s-control-plane:~# cat /etc/os-release
PRETTY_NAME="Ubuntu 24.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.1 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
```

## build

```shell
make all DIR=ingress-nginx/v1.11.3
```


### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_ingress-nginx-v1.11.3_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.17 to debug
