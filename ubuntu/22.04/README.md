# docker v22.04

* dqd: 
	* ssst0n3/docker_archive:ubuntu-22.04 -> ssst0n3/docker_archive:ubuntu-22.04_v0.3.0
	* ssst0n3/docker_archive:ubuntu-22.04_v0.3.0
	* ssst0n3/docker_archive:ubuntu-22.04_v0.2.0
	* ssst0n3/docker_archive:ubuntu-22.04_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_ubuntu-22.04 -> ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.3.0
	* ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.3.0: increase the size to 20G
	* ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.2.0: install built-in ssh key
	* ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.1.0

## usage

```shell
cd ubuntu/22.04
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 22040 root@127.0.0.1
```

```shell
root@localhost:~# uname -a
Linux localhost.localdomain 5.15.0-139-generic #149-Ubuntu SMP Fri Apr 11 22:06:13 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

## build

```shell
make all DIR=ubuntu/22.04
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.3.0
```