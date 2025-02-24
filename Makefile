.PHONY: ctr vm dqd

REPO ?= ssst0n3/docker_archive
# D2VM := docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v $(PWD):/d2vm -w /d2vm linkacloud/d2vm:latest $*
D2VM := docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v $(PWD):/d2vm -w /d2vm ssst0n3/d2vm:v0.2.2-dev $*
VIRT_SPARSIFY := docker run -it --rm -v ./:/data -w /data bkahlert/libguestfs:edge virt-sparsify

env:
	$(eval include $(DIR)/.env)
	$(eval export $(shell sed 's/=.*//' $(DIR)/.env))
	$(eval CTR_TAG := $(REPO):ctr_$(IMAGE)_$(VERSION))
	$(eval DQD_TAG := $(REPO):$(IMAGE)_$(VERSION))

# ctr: env
# 	@echo "Building Docker image in directory $(DIR) with image name $(IMAGE) and version $(VERSION), TAG is $(CTR_TAG)"
# 	@cd $(DIR) && docker build -t $(CTR_TAG) .

ctr: env
	@echo "Building Docker image in directory $(DIR) with image name $(IMAGE) and version $(VERSION), TAG is $(CTR_TAG)"
	@cd $(DIR) && { [ -f build.sh ] && ./build.sh $(CTR_TAG) || docker build -t $(CTR_TAG) . ; }

vm: env
	$(D2VM) convert $(CTR_TAG) -p root -o $(DIR)/vm.qcow2 -v
	cd $(DIR) && $(VIRT_SPARSIFY) --compress vm.qcow2 shrunk.qcow2 && mv -f shrunk.qcow2 vm.qcow2 && rm -f 1

dqd: env
	cp $(DIR)/vm.qcow2 dqd
	docker build -t $(DQD_TAG) dqd
	rm -f dqd/vm.qcow2

clean: env
	rm -f $(DIR)/vm.qcow2

all: env clean ctr vm dqd

dbg: clean ctr
	$(D2VM) convert $(CTR_TAG) --append-to-cmdline nokaslr -p root -o $(DIR)/vm.qcow2 -v
	cd $(DIR) && $(VIRT_SPARSIFY) --compress vm.qcow2 shrunk.qcow2 && mv -f shrunk.qcow2 vm.qcow2 && rm -f 1
	cd $(DIR) && docker build -t $(DQD_TAG) -f Dockerfile.dbg .
