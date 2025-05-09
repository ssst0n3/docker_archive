# docker v24.04

* dqd: 
	* ssst0n3/docker_archive:ubuntu-24.04 -> ssst0n3/docker_archive:ubuntu-24.04_v0.3.0
	* ssst0n3/docker_archive:ubuntu-24.04_v0.3.0
	* ssst0n3/docker_archive:ubuntu-24.04_v0.2.0
	* ssst0n3/docker_archive:ubuntu-24.04_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_ubuntu-24.04 -> ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.3.0
	* ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.3.0: install built-in ssh key
	* ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.2.0: installed common packages; squash
	* ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.1.0

## usage

```shell
cd ubuntu/24.04
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@localhost:~# uname -a
Linux localhost.localdomain 6.8.0-59-generic #61-Ubuntu SMP PREEMPT_DYNAMIC Fri Apr 11 23:16:11 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release 
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
make all DIR=ubuntu/24.04
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.3.0
```