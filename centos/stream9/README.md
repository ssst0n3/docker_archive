# centos stream9

* dqd: 
	* ssst0n3/docker_archive:centos-stream9 -> ssst0n3/docker_archive:centos-stream9_v0.2.0
	* ssst0n3/docker_archive:centos-stream9_v0.2.0
	* ssst0n3/docker_archive:centos-stream9_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_centos-stream9 -> ssst0n3/docker_archive:ctr_centos-stream9_v0.2.0
	* ssst0n3/docker_archive:ctr_centos-stream9_v0.2.0: install the built-in ssh keys
	* ssst0n3/docker_archive:ctr_centos-stream9_v0.1.0

## usage

```shell
$ cd centos/stream9
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
[root@localhost ~]# uname -a
Linux localhost.localdomain 5.14.0-582.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Apr 30 18:29:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
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
[root@localhost ~]# systemctl status 
● localhost.localdomain
    State: running
    Units: 209 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Mon 2025-05-12 08:49:08 UTC; 40s ago
  systemd: 252-53.el9
   CGroup: /
           ├─init.scope
           │ └─1 /usr/lib/systemd/systemd --switched-root --system --deserialize 31
           ├─system.slice
           │ ├─NetworkManager-dispatcher.service
           │ │ └─612 /usr/libexec/nm-dispatcher
           │ ├─NetworkManager.service
           │ │ └─511 /usr/sbin/NetworkManager --no-daemon
           │ ├─dbus-broker.service
           │ │ ├─505 /usr/bin/dbus-broker-launch --scope system --audit
           │ │ └─510 dbus-broker --log 4 --controller 9 --machine-id e820efac9a4b48e2b63512ea604c5e41 --max-bytes 536870912 --max-fds 4096 --max-matches 131072 --audit
           │ ├─sshd.service
           │ │ └─550 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─552 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─554 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-hostnamed.service
           │ │ └─541 /usr/lib/systemd/systemd-hostnamed
           │ ├─systemd-journald.service
           │ │ └─463 /usr/lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─518 /usr/lib/systemd/systemd-logind
           │ └─systemd-udevd.service
           │   └─udev
           │     └─488 /usr/lib/systemd/systemd-udevd
           └─user.slice
             └─user-0.slice
               ├─session-1.scope
               │ ├─580 "sshd: root [priv]"
               │ ├─593 "sshd: root@pts/0"
               │ ├─594 -bash
               │ ├─617 systemctl status
               │ └─618 more
               └─user@0.service
                 └─init.scope
                   ├─584 /usr/lib/systemd/systemd --user
                   └─586 "(sd-pam)"
```

## build

```shell
make all DIR=centos/stream9
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_centos-stream9_v0.2.0
```