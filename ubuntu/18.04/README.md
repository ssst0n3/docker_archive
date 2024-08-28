# docker v26.1.4

* dqd: 
	* ssst0n3/docker_archive:ubuntu-18.04 -> ssst0n3/docker_archive:ubuntu-18.04_v0.1.0
	* ssst0n3/docker_archive:ubuntu-18.04_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_ubuntu-18.04 -> ssst0n3/docker_archive:ctr_ubuntu-18.04_v0.1.0
	* ssst0n3/docker_archive:ctr_ubuntu-18.04_v0.1.0

## usage

```shell
cd ubuntu/18.04
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 18040 root@127.0.0.1
```

```shell
root@localhost:~# uname -a
Linux localhost.localdomain 4.15.0-213-generic #224-Ubuntu SMP Mon Jun 19 13:30:12 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="18.04.6 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.6 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
root@localhost:~# cat /proc/filesystems 
nodev	sysfs
nodev	rootfs
nodev	ramfs
nodev	bdev
nodev	proc
nodev	cpuset
nodev	cgroup
nodev	cgroup2
nodev	tmpfs
nodev	devtmpfs
nodev	configfs
nodev	debugfs
nodev	tracefs
nodev	securityfs
nodev	sockfs
nodev	dax
nodev	bpf
nodev	pipefs
nodev	hugetlbfs
nodev	devpts
	ext3
	ext2
	ext4
	squashfs
	vfat
nodev	ecryptfs
	fuseblk
nodev	fuse
nodev	fusectl
nodev	pstore
nodev	mqueue
nodev	autofs
nodev	aufs
```

## build

```shell
make all DIR=ubuntu/18.04
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-18.04_v0.1.0
```