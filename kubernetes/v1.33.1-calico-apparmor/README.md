# kubernetes v1.33.1 with calico, apparmor

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.1-calico-apparmor -> ssst0n3/docker_archive:kubernetes-v1.33.1-calico-apparmor_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.1-calico-apparmor_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico-apparmor -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico-apparmor_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico-apparmor_v0.1.0

## usage

```shell
$ cd kubernetes/v1.33.1-calico-apparmor
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### apparmor

```shell
$ ./ssh
root@kubernetes-1-33-1:~# cat << EOF > job.yaml 
apiVersion: batch/v1
kind: Job
metadata:
  name: apparmor-job
spec:
  template:
    spec:
      securityContext:
        appArmorProfile:
          type: RuntimeDefault
      
      containers:
      - name: task-runner
        image: busybox:1.36
        command:
          - "sh"
          - "-c"
          - |
            cat /proc/self/attr/current
      restartPolicy: Never
root@kubernetes-1-33-1:~# kubectl apply -f job.yaml 
job.batch/apparmor-job created
root@kubernetes-1-33-1:~# kubectl get pods 
NAME                 READY   STATUS      RESTARTS   AGE
apparmor-job-26n9n   0/1     Completed   0          13s
root@kubernetes-1-33-1:~# kubectl logs apparmor-job-26n9n
cri-containerd.apparmor.d (enforce)
```

### env details

```shell
$ until kubectl --kubeconfig=kubeconfig wait --for=condition=Ready pod --all -A --timeout=30s; do sleep 10; done
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-789bcb55b-cckpl            1/1     Running   1 (2m15s ago)   86d
calico-apiserver   calico-apiserver-789bcb55b-w4zqk            1/1     Running   1 (2m15s ago)   86d
calico-system      calico-kube-controllers-945bcc5f8-p8czx     1/1     Running   1 (2m15s ago)   86d
calico-system      calico-node-zf9qf                           1/1     Running   1 (2m15s ago)   86d
calico-system      calico-typha-7dccd7876b-4596t               1/1     Running   1 (2m15s ago)   86d
calico-system      csi-node-driver-vj6n9                       2/2     Running   2 (2m15s ago)   86d
calico-system      goldmane-86cd9d999d-74dfv                   1/1     Running   1 (2m15s ago)   86d
calico-system      whisker-699cdc85cb-gwsjm                    2/2     Running   2 (2m15s ago)   86d
kube-system        coredns-674b8bbfcf-bz69g                    1/1     Running   1 (2m15s ago)   86d
kube-system        coredns-674b8bbfcf-f2k2f                    1/1     Running   1 (2m15s ago)   86d
kube-system        etcd-kubernetes-1-33-1                      1/1     Running   2 (2m15s ago)   86d
kube-system        kube-apiserver-kubernetes-1-33-1            1/1     Running   3 (2m15s ago)   86d
kube-system        kube-controller-manager-kubernetes-1-33-1   1/1     Running   2 (2m15s ago)   86d
kube-system        kube-proxy-s4qzw                            1/1     Running   2 (2m15s ago)   86d
kube-system        kube-scheduler-kubernetes-1-33-1            1/1     Running   2 (2m15s ago)   86d
tigera-operator    tigera-operator-68f7c7984d-vknxx            1/1     Running   1 (2m15s ago)   86d
```

```shell
$ ./ssh
root@kubernetes-1-33-1:~# systemctl status apparmor
● apparmor.service - Load AppArmor profiles
     Loaded: loaded (/usr/lib/systemd/system/apparmor.service; enabled; preset: enabled)
     Active: active (exited) since Sat 2025-10-04 14:48:01 UTC; 3min 38s ago
       Docs: man:apparmor(7)
             https://gitlab.com/apparmor/apparmor/wikis/home/
    Process: 243 ExecStart=/lib/apparmor/apparmor.systemd reload (code=exited, status=0/SUCCESS)
   Main PID: 243 (code=exited, status=0/SUCCESS)
        CPU: 332ms

Oct 04 14:48:01 kubernetes-1-33-1 apparmor.systemd[243]: Restarting AppArmor
Oct 04 14:48:01 kubernetes-1-33-1 apparmor.systemd[243]: /lib/apparmor/apparmor.systemd: 148: [: Illegal number: yes
Oct 04 14:48:01 kubernetes-1-33-1 apparmor.systemd[243]: Reloading AppArmor profiles
Oct 04 14:48:00 kubernetes-1-33-1 systemd[1]: Starting apparmor.service - Load AppArmor profiles...
Oct 04 14:48:01 kubernetes-1-33-1 systemd[1]: Finished apparmor.service - Load AppArmor profiles.
root@kubernetes-1-33-1:~# helm version
version.BuildInfo{Version:"v3.18.3", GitCommit:"6838ebcf265a3842d1433956e8a622e3290cf324", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-1:~# kubectl version
Client Version: v1.33.1
Kustomize Version: v5.6.0
Server Version: v1.33.1
root@kubernetes-1-33-1:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.0 061792f0ecf3684fb30a3a0eb006799b8c6638a7
root@kubernetes-1-33-1:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@kubernetes-1-33-1:~# uname -a
Linux kubernetes-1-33-1 6.8.0-85-generic #85-Ubuntu SMP PREEMPT_DYNAMIC Thu Sep 18 15:26:59 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-33-1:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
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
make all DIR=kubernetes/v1.33.1-calico-apparmor
```


### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico-apparmor_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
