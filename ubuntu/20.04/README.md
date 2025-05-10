# docker v20.04

* dqd: 
	* ssst0n3/docker_archive:ubuntu-20.04 -> ssst0n3/docker_archive:ubuntu-20.04_v0.2.0
	* ssst0n3/docker_archive:ubuntu-20.04_v0.2.0
	* ssst0n3/docker_archive:ubuntu-20.04_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_ubuntu-20.04 -> ssst0n3/docker_archive:ctr_ubuntu-20.04_v0.2.0
	* ssst0n3/docker_archive:ctr_ubuntu-20.04_v0.2.0: install the built-in ssh key
	* ssst0n3/docker_archive:ctr_ubuntu-20.04_v0.1.0

## usage

```shell
$ cd ubuntu/20.04
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
root@localhost:~# uname -a
Linux localhost.localdomain 5.4.0-215-generic #235-Ubuntu SMP Fri Apr 11 21:55:32 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="20.04.6 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.6 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

## build

```shell
make all DIR=ubuntu/20.04
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-20.04_v0.2.0
```