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
