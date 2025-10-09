# docker v28.3.2 with cron

* dqd:
  * ssst0n3/docker_archive:docker-v28.3.2-cron -> ssst0n3/docker_archive:docker-v28.3.2-cron_v0.1.0
  * ssst0n3/docker_archive:docker-v28.3.2-cron_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.3.2-cron -> ssst0n3/docker_archive:ctr_docker-v28.3.2-cron_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v28.3.2-cron_v0.1.0

## usage

```shell
$ cd docker/v28.3.2-cron
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@docker-28-3-2-cron:~# docker run -ti hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
e6590344b1a5: Pull complete 
Digest: sha256:ec153840d1e635ac434fab5e377081f17e0e15afab27beb3f726c3265039cfff
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
```

### env details

```shell
$ ./ssh
root@docker-28-3-2-cron:~# apt show cron
Package: cron
Version: 3.0pl1-184ubuntu2
Status: install ok installed
Priority: important
Section: admin
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Georges Khaznadar <georgesk@debian.org>
Installed-Size: 236 kB
Provides: cron-daemon
Pre-Depends: init-system-helpers (>= 1.54~), cron-daemon-common
Depends: libc6 (>= 2.34), libpam0g (>= 0.99.7.1), libselinux1 (>= 3.1~), sensible-utils, libpam-runtime
Suggests: anacron, logrotate, checksecurity, supercat, default-mta | mail-transport-agent
Conflicts: bcron, cronie, systemd-cron
Replaces: bcron, cronie, systemd-cron
Homepage: https://ftp.isc.org/isc/cron/
Download-Size: unknown
APT-Manual-Installed: yes
APT-Sources: /var/lib/dpkg/status
Description: process scheduling daemon
 The cron daemon is a background process that runs particular programs at
 particular times (for example, every minute, day, week, or month), as
 specified in a crontab. By default, users may also create crontabs of
 their own so that processes are run on their behalf.
 .
 Output from the commands is usually mailed to the system administrator
 (or to the user in question); you should probably install a mail system
 as well so that you can receive these messages.
 .
 This cron package does not provide any system maintenance tasks. Basic
 periodic maintenance tasks are provided by other packages, such
 as checksecurity.

root@docker-28-3-2-cron:~# systemctl status cron
● cron.service - Regular background program processing daemon
     Loaded: loaded (/usr/lib/systemd/system/cron.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-10-08 10:04:14 UTC; 1min 17s ago
       Docs: man:cron(8)
   Main PID: 405 (cron)
      Tasks: 1 (limit: 2330)
     Memory: 440.0K (peak: 688.0K)
        CPU: 6ms
     CGroup: /system.slice/cron.service
             └─405 /usr/sbin/cron -f -P

Oct 08 10:04:14 docker-28-3-2-cron systemd[1]: Started cron.service - Regular background program processing daemon.
Oct 08 10:04:14 docker-28-3-2-cron (cron)[405]: cron.service: Referenced but unset environment variable evaluates to an empty string: EXTRA_OPTS
Oct 08 10:04:14 docker-28-3-2-cron cron[405]: (CRON) INFO (pidfile fd = 3)
Oct 08 10:04:14 docker-28-3-2-cron cron[405]: (CRON) INFO (Running @reboot jobs)

root@docker-28-3-2-cron:~# docker version
Client: Docker Engine - Community
 Version:           28.3.2
 API version:       1.51
 Go version:        go1.24.5
 Git commit:        578ccf6
 Built:             Wed Jul  9 16:13:45 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.3.2
  API version:      1.51 (minimum version 1.24)
  Go version:       go1.24.5
  Git commit:       e77ff99
  Built:            Wed Jul  9 16:13:45 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.27
  GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
 runc:
  Version:          1.2.5
  GitCommit:        v1.2.5-0-g59923ef
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
root@docker-28-3-2-cron:~# containerd --version
containerd containerd.io 1.7.27 05044ec0a9a75232cad458027ca83437aae3f4da
root@docker-28-3-2-cron:~# cat /etc/os-release
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
root@docker-28-3-2-cron:~# uname -a
Linux docker-28-3-2-cron 6.8.0-85-generic #85-Ubuntu SMP PREEMPT_DYNAMIC Thu Sep 18 15:26:59 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=docker/v28.3.2-cron
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.3.2-cron_v0.1.0
```
