# debug docker

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
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### 2.3 do the debug

Click the button `Debug 'docker'`

# debug runc