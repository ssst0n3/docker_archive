# debug docker

https://github.com/user-attachments/assets/39033a93-8e94-4844-b948-2349024a285b

## 1. open source code id IDE

### 1.1 clone the repo

```shell
$ DIR=~/research_target/moby/docker-v28.0.4/src/github.com/docker
$ mkdir -p $DIR
$ git clone --depth 1 --branch v28.0.4 https://github.com/moby/moby.git ${DIR}/docker
```

### 1.2 open in goland

```shell
$ goland ${DIR}/docker
```

### 1.3 disable Go Modules integration

* File->Settings->Go->Go Modules
* Uncheck the checkbox 'Enable Go modules integration'

### 1.4 setup project GOPATH

* File->Settings->Go->GoPATH->Project GPATH->+(Add)
* ~/researcher_target/moby/docker-v28.0.4

## 2. debug

### 2.1 Setup Debug Configuration

* Run->Edit Configurations->+(Add New Configuration)->Go Remote
* Setup the configuration as:
    * Name: docker
    * Host: localhost
    * Port: 28045

### 2.2 start the env

```shell
$ git clone https://github.com/ssst0n3/docker_archive
$ cd docker_archive/docker/v28.0.4-debug/
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### 2.3 do the debug

Click the button `Debug 'docker'`

# debug runc

https://github.com/user-attachments/assets/4350a29e-08a9-468c-a95f-cb881e9a96c3

## 1. open source code id IDE

### 1.1 clone the repo

```shell
$ mkdir -p ~/research_target/runc
$ git clone --depth 1 --branch v1.2.5 https://github.com/opencontainers/runc.git ~/research_target/runc/runc-v1.2.5
$ cp docker_archive/v28.0.4-debug/debug-flag.go ~/research_target/runc/runc-v1.2.5/
```

### 1.2 open in goland

```shell
$ goland ~/research_target/runc/runc-v1.2.5
```

### 1.3 disable Go Modules integration

* File->Settings->Go->Go Modules
* Uncheck the checkbox 'Enable Go modules integration'

## 2. debug

### 2.1 Setup Debug Configuration

* Run->Edit Configurations->+(Add New Configuration)->Go Remote
* Setup the configuration1 as:
    * Name: main
    * Host: localhost
    * Port: 28046
* Setup the configuration1 as:
    * Name: init
    * Host: localhost
    * Port: 28047

### 2.2 replace the runc with runc.debug

```shell
rm -f /usr/bin/runc
ln -s /root/runc.debug /usr/bin/runc
```

### 2.3 do the debug

1. setup the breakpoint at the line `if flag {` of debug-flag.go
2. start a container

```shell
docker run -ti ubuntu id
```

3. click the button `Debug 'main'`
4. attach to the runc init

```shell
root@localhost:~# ps -ef 
...
root         680     667  0 09:47 pts/0    00:00:00 docker run -ti ubuntu bash
root         706       1  0 09:47 ?        00:00:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 677027b51db7ee702d95ebe5414ae394d2d2a713c2fc8d66de41670e53a4852c -address /run/containerd/containerd.sock
root         717     706  0 09:47 ?        00:00:00 dlv --listen=:2346 --headless=true --api-version=2 --accept-multiclient exec /root/runc-debug-flag -- --root /var/run/docker/runtime-runc/moby --log /run/containerd/io.containerd.runtime
root         723     717  0 09:47 ?        00:00:00 /root/runc-debug-flag --root /var/run/docker/runtime-runc/moby --log /run/containerd/io.containerd.runtime.v2.task/moby/677027b51db7ee702d95ebe5414ae394d2d2a713c2fc8d66de41670e53a4852c/l
root         727     417  0 09:47 ?        00:00:00 sshd: root@pts/1
root         738     727  0 09:47 pts/1    00:00:00 -bash
root         759     723  0 09:48 ?        00:00:00 /root/runc-debug-flag init
root         765     738  0 09:48 pts/1    00:00:00 ps -ef
root@localhost:~# attach.sh 759
API server listening at: [::]:2347
2025-04-30T09:48:14Z warn layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
```

5. click the button `Debug 'init'`
6. modify the flag to be `true` in the debugger
