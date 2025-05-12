# debian 12.0

* dqd: 
	* ssst0n3/docker_archive:debian-12.0 -> ssst0n3/docker_archive:debian-12.0_v0.2.0
	* ssst0n3/docker_archive:debian-12.0_v0.2.0
	* ssst0n3/docker_archive:debian-12.0_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_debian-12.0 -> ssst0n3/docker_archive:ctr_debian-12.0_v0.2.0
	* ssst0n3/docker_archive:ctr_debian-12.0_v0.2.0: install the built-in ssh key
	* ssst0n3/docker_archive:ctr_debian-12.0_v0.1.0

## usage

```shell
$ cd debian/12.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@debuerreotype:~# uname -a
Linux debuerreotype 6.1.0-34-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.135-1 (2025-04-25) x86_64 GNU/Linux
root@debuerreotype:~# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@debuerreotype:~# systemctl status
● debuerreotype
    State: running
    Units: 210 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Mon 2025-05-12 09:07:28 UTC; 1min 2s ago
  systemd: 252.36-1~deb12u1
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─dbus.service
           │ │ └─422 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
           │ ├─networking.service
           │ │ └─449 /sbin/dhclient -pf /run/dhclient.eth0.pid -lf /var/lib/dhcp/dhclient.eth0.leases eth0
           │ ├─ssh.service
           │ │ └─437 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─435 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─436 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-journald.service
           │ │ └─356 /lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─424 /lib/systemd/systemd-logind
           │ ├─systemd-networkd.service
           │ │ └─397 /lib/systemd/systemd-networkd
           │ ├─systemd-timesyncd.service
           │ │ └─388 /lib/systemd/systemd-timesyncd
           │ └─systemd-udevd.service
           │   └─udev
           │     └─386 /lib/systemd/systemd-udevd
           └─user.slice
             └─user-0.slice
               ├─session-1.scope
               │ ├─492 "sshd: root@pts/0"
               │ ├─506 -bash
               │ ├─516 systemctl status
               │ └─517 pager
               └─user@0.service
                 └─init.scope
                   ├─495 /lib/systemd/systemd --user
                   └─496 "(sd-pam)"
```

## build

```shell
make all DIR=debian/12.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_debian-12.0_v0.2.0
```