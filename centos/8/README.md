# centos 8

* dqd: 
	* ssst0n3/docker_archive:centos-8 -> ssst0n3/docker_archive:centos-8_v0.1.0
	* ssst0n3/docker_archive:centos-8_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_centos-8 -> ssst0n3/docker_archive:ctr_centos-8_v0.1.0
	* ssst0n3/docker_archive:ctr_centos-8_v0.1.0

## usage

```shell
$ cd centos/8
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
[root@localhost ~]# uname -a
Linux localhost.localdomain 4.18.0-348.7.1.el8_5.x86_64 #1 SMP Wed Dec 22 13:25:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@localhost ~]# cat /etc/os-release 
NAME="CentOS Linux"
VERSION="8"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="8"
PLATFORM_ID="platform:el8"
PRETTY_NAME="CentOS Linux 8"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:8"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"
CENTOS_MANTISBT_PROJECT="CentOS-8"
CENTOS_MANTISBT_PROJECT_VERSION="8"
[root@localhost ~]# systemctl status
● localhost.localdomain
    State: running
     Jobs: 0 queued
   Failed: 0 units
    Since: Thu 2025-04-10 07:54:37 UTC; 1min 40s ago
   CGroup: /
           ├─init.scope
           │ └─1 /usr/lib/systemd/systemd --switched-root --system --deserialize 17
           └─system.slice
             ├─systemd-udevd.service
             │ └─517 /usr/lib/systemd/systemd-udevd
             ├─system-serial\x2dgetty.slice
             │ └─serial-getty@ttyS0.service
             │   └─572 /sbin/agetty -o -p -- \u --keep-baud 115200,38400,9600 ttyS0 vt220
             ├─systemd-journald.service
             │ └─480 /usr/lib/systemd/systemd-journald
             ├─sshd.service
             │ ├─599 /usr/sbin/sshd -D -oCiphers=aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes256-cbc,aes128-gcm@openssh.com,aes128-ctr,aes128-cbc -oMACs=hmac-sha2-256-etm@openssh.com,hmac-sha1-etm@openssh.com,umac->
             │ ├─607 sshd: root [priv]
             │ ├─609 sshd: root@pts/0
             │ ├─610 -bash
             │ ├─636 systemctl status
             │ └─637 less
             ├─NetworkManager.service
             │ └─540 /usr/sbin/NetworkManager --no-daemon
             ├─dbus.service
             │ └─536 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
             └─system-getty.slice
               └─getty@tty1.service
                 └─573 /sbin/agetty -o -p -- \u --noclear tty1 linux
```

## build

```shell
make all DIR=centos/8
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_centos-8_v0.1.0
```