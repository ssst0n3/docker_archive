# debian 11.0

* dqd: 
	* ssst0n3/docker_archive:debian-11.0 -> ssst0n3/docker_archive:debian-11.0_v0.1.0
	* ssst0n3/docker_archive:debian-11.0_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_debian-11.0 -> ssst0n3/docker_archive:ctr_debian-11.0_v0.1.0
	* ssst0n3/docker_archive:ctr_debian-11.0_v0.1.0

## usage

```shell
$ cd debian/11.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@debuerreotype:~# uname -a
Linux debuerreotype 5.10.0-35-amd64 #1 SMP Debian 5.10.237-1 (2025-05-19) x86_64 GNU/Linux
root@debuerreotype:~# cat /etc/os-release 
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@debuerreotype:~# systemctl status
● debuerreotype
    State: running
     Jobs: 0 queued
   Failed: 0 units
    Since: Mon 2025-06-23 12:56:05 UTC; 1min 52s ago
   CGroup: /
           ├─user.slice 
           │ └─user-0.slice 
           │   ├─user@0.service …
           │   │ └─init.scope 
           │   │   ├─486 /lib/systemd/systemd --user
           │   │   └─487 (sd-pam)
           │   └─session-5.scope 
           │     ├─501 sshd: root@pts/0
           │     ├─507 -bash
           │     ├─512 systemctl status
           │     └─513 pager
           ├─init.scope 
           │ └─1 /sbin/init
           └─system.slice 
             ├─systemd-networkd.service 
             │ └─366 /lib/systemd/systemd-networkd
             ├─systemd-udevd.service 
             │ └─358 /lib/systemd/systemd-udevd
             ├─system-serial\x2dgetty.slice 
             │ └─serial-getty@ttyS0.service 
             │   └─404 /sbin/agetty -o -p -- \u --keep-baud 115200,57600,38400,9600 ttyS0 vt220
             ├─networking.service 
             │ └─419 /sbin/dhclient -pf /run/dhclient.eth0.pid -lf /var/lib/dhcp/dhclient.eth0.leases eth0
             ├─systemd-journald.service 
             │ └─332 /lib/systemd/systemd-journald
             ├─systemd-resolved.service 
             │ └─390 /lib/systemd/systemd-resolved
             ├─dbus.service 
             │ └─384 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
             ├─systemd-timesyncd.service 
             │ └─359 /lib/systemd/systemd-timesyncd
             ├─system-getty.slice 
             │ └─getty@tty1.service 
             │   └─403 /sbin/agetty -o -p -- \u --noclear tty1 linux
             └─systemd-logind.service 
               └─387 /lib/systemd/systemd-logind
```

## build

```shell
make all DIR=debian/11.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_debian-11.0_v0.1.0
```
