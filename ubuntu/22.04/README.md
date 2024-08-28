# docker v22.04

* dqd: 
	* ssst0n3/docker_archive:ubuntu-22.04 -> ssst0n3/docker_archive:ubuntu-22.04_v0.1.0
	* ssst0n3/docker_archive:ubuntu-22.04_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_ubuntu-22.04 -> ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.1.0
	* ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.1.0

## usage

```shell
cd ubuntu/22.04
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 22040 root@127.0.0.1
```

```shell
root@localhost:~# uname -a
Linux localhost.localdomain 5.15.0-117-generic #127-Ubuntu SMP Fri Jul 5 20:13:28 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.4 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.4 LTS (Jammy Jellyfish)"
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
FROM ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.1.0
```