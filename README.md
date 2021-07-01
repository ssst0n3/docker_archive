# docker archive

## usage

```
docker run -ti ssst0n3/docker_archive:linuxkit_docker-20.10.2_slim
docker version
```

details
```
st0n3@yoga:~$ docker run -ti ssst0n3/docker_archive:linuxkit_docker-20.10.2_slim
// wait container startup
...

Welcome to LinuxKit

                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
          {                       /  ===-
           \______ O           __/
             \    \         __/
              \____\_______/

[   58.009167] IPVS: ftp: loaded support on port[0] = 21
[   61.279015] IPVS: ftp: loaded support on port[0] = 21
[   64.850298] IPVS: ftp: loaded support on port[0] = 21
[   67.705121] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   72.978379] random: crng init done
[   75.427699] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   75.434645] 8021q: adding VLAN 0 to HW filter on device eth0
[   75.435977] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   77.537104] ICMPv6: process `dhcpcd' is using deprecated sysctl (syscall) net.ipv6.neigh.eth0.retrans_time - use net.ipv6.neigh.eth0.retrans_time_ms instead
getty: starting getty for ttyS0

linuxkit-c2c0b18adffc login: root (automatic login)

Welcome to LinuxKit!

NOTE: This system is namespaced.
The namespace you are currently in may not be the root.
System services are namespaced; to access, use `ctr -n services.linuxkit ...`
(ns: getty) linuxkit-c2c0b18adffc:~# 
(ns: getty) linuxkit-c2c0b18adffc:~# 
(ns: getty) linuxkit-c2c0b18adffc:~# [   73.197837] bpfilter: Loaded bpfilter_umh pid 849
[   73.217395] Started bpfilter

(ns: getty) linuxkit-c2c0b18adffc:~# [   76.719276] IPVS: ftp: loaded support on port[0] = 21
[   77.437015] Initializing XFRM netlink socket

(ns: getty) linuxkit-c2c0b18adffc:~# 
(ns: getty) linuxkit-c2c0b18adffc:~# ctr --namespace services.linuxkit tasks exe
c --tty --exec-id sh docker /bin/ash -l
linuxkit-c2c0b18adffc:/# docker version
Client: Docker Engine - Community
 Version:           20.10.2
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        2291f61
 Built:             Mon Dec 28 16:11:26 2020
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.2
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       8891c58
  Built:            Mon Dec 28 16:15:23 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v1.4.3
  GitCommit:        269548fa27e0089a8b8278fc4fc781d7f65a939b
 runc:
  Version:          1.0.0-rc92
  GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```