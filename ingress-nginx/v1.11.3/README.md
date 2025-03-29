# ingress-nginx v1.11.3

* dqd:
  * ssst0n3/docker_archive:ingress-nginx-v1.11.3 -> ssst0n3/docker_archive:ingress-nginx-v1.11.3_v0.1.0
  * ssst0n3/docker_archive:ingress-nginx-v1.11.3_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_ingress-nginx-v1.11.3 -> ssst0n3/docker_archive:ctr_ingress-nginx-v1.11.3_v0.1.0
  * ssst0n3/docker_archive:ctr_ingress-nginx-v1.11.3_v0.1.0

## usage

```shell
$ cd ingress-nginx/v1.11.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A                  
NAMESPACE          NAME                                        READY   STATUS      RESTARTS      AGE
calico-apiserver   calico-apiserver-68b75f8799-82jfk           1/1     Running     2 (77s ago)   109m
calico-apiserver   calico-apiserver-68b75f8799-9dq4v           1/1     Running     2 (77s ago)   109m
calico-system      calico-kube-controllers-578c9fc9f9-p2j6f    1/1     Running     2 (77s ago)   109m
calico-system      calico-node-vt674                           1/1     Running     2 (77s ago)   109m
calico-system      calico-typha-86888f5ddb-cqpqx               1/1     Running     2 (77s ago)   109m
calico-system      csi-node-driver-g6mt7                       2/2     Running     4 (77s ago)   109m
ingress-nginx      ingress-nginx-admission-create-dh9bh        0/1     Completed   0             14m
ingress-nginx      ingress-nginx-admission-patch-24748         0/1     Completed   2             14m
ingress-nginx      ingress-nginx-controller-9456df685-js8h8    1/1     Running     1 (77s ago)   14m
kube-system        coredns-668d6bf9bc-9n5l9                    1/1     Running     2 (77s ago)   148m
kube-system        coredns-668d6bf9bc-m47jq                    1/1     Running     2 (77s ago)   148m
kube-system        etcd-k8s-control-plane                      1/1     Running     3 (77s ago)   148m
kube-system        kube-apiserver-k8s-control-plane            1/1     Running     5 (77s ago)   148m
kube-system        kube-controller-manager-k8s-control-plane   1/1     Running     3 (77s ago)   148m
kube-system        kube-proxy-mr87q                            1/1     Running     3 (77s ago)   148m
kube-system        kube-scheduler-k8s-control-plane            1/1     Running     3 (77s ago)   148m
tigera-operator    tigera-operator-789496d6f5-jwk2v            1/1     Running     2 (77s ago)   109m
$ kubectl --kubeconfig=kubeconfig get services -A              
NAMESPACE          NAME                                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
calico-apiserver   calico-api                           ClusterIP      10.96.212.146   <none>        443/TCP                      109m
calico-system      calico-kube-controllers-metrics      ClusterIP      None            <none>        9094/TCP                     107m
calico-system      calico-typha                         ClusterIP      10.96.129.221   <none>        5473/TCP                     109m
default            kubernetes                           ClusterIP      10.96.0.1       <none>        443/TCP                      149m
ingress-nginx      ingress-nginx-controller             LoadBalancer   10.96.250.182   <pending>     80:31136/TCP,443:31303/TCP   14m
ingress-nginx      ingress-nginx-controller-admission   ClusterIP      10.96.240.119   <none>        443/TCP                      14m
kube-system        kube-dns                             ClusterIP      10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP       148m
$ kubectl --kubeconfig=kubeconfig describe service -n ingress-nginx ingress-nginx-controller          
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
IP:                       10.96.250.182
IPs:                      10.96.250.182
Port:                     http  80/TCP
TargetPort:               http/TCP
NodePort:                 http  31136/TCP
Endpoints:                192.168.229.144:80
Port:                     https  443/TCP
TargetPort:               https/TCP
NodePort:                 https  31303/TCP
Endpoints:                192.168.229.144:443
Session Affinity:         None
External Traffic Policy:  Local
HealthCheck NodePort:     31007
Events:                   <none>
```

```shell
$ ./ssh
root@k8s-control-plane:~# kubectl version
Client Version: v1.32.3
Kustomize Version: v5.5.0
Server Version: v1.32.3
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
* ssh root/root 10.0.2.16 to debug
