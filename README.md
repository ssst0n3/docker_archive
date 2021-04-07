# docker archive

## usage

```
docker run -ti ssst0n3/docker_archive:linuxkit_docker-19.03.0-rc3
docker version
```

details
```
st0n3@yoga:~$ docker run -ti ssst0n3/docker_archive:linuxkit_docker-19.03.0-rc3
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

```