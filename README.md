# docker archive

## usage

```
docker run -ti ssst0n3/docker_archive:linuxkit_docker-20.10.0
docker version
```

details
```
st0n3@yoga:~$ docker run -ti ssst0n3/docker_archive:linuxkit_docker-20.10.0
// wait container startup
...
[   52.339419] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection

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

linuxkit-525400123456 login: root (automatic login)

Welcome to LinuxKit!

NOTE: This system is namespaced.
The namespace you are currently in may not be the root.
System services are namespaced; to access, use `ctr -n services.linuxkit ...`
(ns: getty) linuxkit-525400123456:~# [   98.489339] bpfilter: Loaded bpfilter_umh pid 829
[   98.525403] Started bpfilter
[  103.913882] Initializing XFRM netlink socket
[  104.024304] IPVS: ftp: loaded support on port[0] = 21

(ns: getty) linuxkit-525400123456:~# 

(ns: getty) linuxkit-525400123456:~# ctr --namespace services.linuxkit tasks exe
c --tty --exec-id sh docker /bin/ash -l
linuxkit-525400123456:/# 
linuxkit-525400123456:/# 
linuxkit-525400123456:/# docker version
Client: Docker Engine - Community
 Version:           20.10.0
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        7287ab3
 Built:             Tue Dec  8 18:54:00 2020
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.0
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       eeddea2
  Built:            Tue Dec  8 18:58:04 2020
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
linuxkit-525400123456:/# 
```