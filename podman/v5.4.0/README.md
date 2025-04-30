# podman v5.4.0

* dqd:
  * ssst0n3/docker_archive:podman-v5.4.0 -> ssst0n3/docker_archive:podman-v5.4.0_v0.1.0
  * ssst0n3/docker_archive:podman-v5.4.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_podman-v5.4.0 -> ssst0n3/docker_archive:ctr_podman-v5.4.0_v0.1.0
  * ssst0n3/docker_archive:ctr_podman-v5.4.0_v0.1.0

## usage

```shell
$ cd podman/v5.4.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
[root@localhost ~]# podman run hello-world
Resolved "hello-world" as an alias (/etc/containers/registries.conf.d/000-shortnames.conf)
Trying to pull quay.io/podman/hello:latest...
Getting image source signatures
Copying blob 81df7ff16254 done   | 
Copying config 5dd467fce5 done   | 
Writing manifest to image destination
!... Hello Podman World ...!

         .--"--.           
       / -     - \         
      / (O)   (O) \        
   ~~~| -=(,Y,)=- |         
    .---. /`  \   |~~      
 ~/  o  o \~~~~.----. ~~   
  | =(X)= |~  / (O (O) \   
   ~~~~~~~  ~| =(Y_)=-  |   
  ~~~~    ~~~|   U      |~~ 

Project:   https://github.com/containers/podman
Website:   https://podman.io
Desktop:   https://podman-desktop.io
Documents: https://docs.podman.io
YouTube:   https://youtube.com/@Podman
X/Twitter: @Podman_io
Mastodon:  @Podman_io@fosstodon.org
```

```shell
$ ./ssh
[root@localhost ~]# podman version
Client:       Podman Engine
Version:      5.4.0
API Version:  5.4.0
Go Version:   go1.23.4 (Red Hat 1.23.4-1.el9)
Built:        Tue Mar 18 14:41:15 2025
OS/Arch:      linux/amd64
[root@localhost ~]# cat /etc/os-release 
NAME="CentOS Stream"
VERSION="9"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="9"
PLATFORM_ID="platform:el9"
PRETTY_NAME="CentOS Stream 9"
ANSI_COLOR="0;31"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:centos:centos:9"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://issues.redhat.com/"
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 9"
REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream"
[root@localhost ~]# uname -a
Linux localhost.localdomain 5.14.0-580.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Apr 22 20:29:48 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=podman/v5.4.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_podman-v5.4.0_v0.1.0
```
