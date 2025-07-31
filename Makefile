.PHONY: ctr vm dqd

REPO ?= ssst0n3/docker_archive
# D2VM := docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v $(PWD):/d2vm -w /d2vm linkacloud/d2vm:latest $*
D2VM := docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v $(PWD):/d2vm -w /d2vm ssst0n3/d2vm:v0.3.2 $*
VIRT_SPARSIFY := docker run -it --rm -v $(PWD)/$(DIR):/data -w /data --env PUID=$(shell id -u) --env PGID=$(shell id -u) bkahlert/libguestfs:edge virt-sparsify

env:
	$(eval include $(DIR)/.env)
	$(eval export $(shell sed 's/=.*//' $(DIR)/.env))
	$(eval CTR_TAG := $(REPO):ctr_$(IMAGE))
	$(eval CTR_TAG_VERSION := $(CTR_TAG)_$(VERSION))
	$(eval DQD_TAG := $(REPO):$(IMAGE))
	$(eval DQD_TAG_VERSION := $(DQD_TAG)_$(VERSION))
	$(eval SIZE ?= 10G )

ctr: env
	@echo "Building Docker image in directory $(DIR) with image name $(IMAGE) and version $(VERSION), TAG is $(CTR_TAG), SIZE is $(SIZE)"
	@cd $(DIR) && { [ -f build.sh ] && ./build.sh $(CTR_TAG_VERSION) || docker build -t $(CTR_TAG_VERSION) . ; }

vm: env
	# add -v to show verbose info
	$(D2VM) convert $(CTR_TAG_VERSION) -s $(SIZE) -p root -o $(DIR)/vm.qcow2
	cd $(DIR) && $(VIRT_SPARSIFY) --compress vm.qcow2 shrunk.qcow2 && mv -f shrunk.qcow2 vm.qcow2 && rm -f 1

dqd: env
	@TMP_DIR=$$(mktemp -d -t dqd-build-XXXXXX); \
	trap 'rm -rf "$$TMP_DIR"' EXIT; \
	cp -r dqd/workspace/* $$TMP_DIR; \
	cp $(DIR)/vm.qcow2 $$TMP_DIR; \
	docker build -t $(DQD_TAG_VERSION) $$TMP_DIR

push: env
	docker tag $(CTR_TAG_VERSION) $(CTR_TAG)
	docker push $(CTR_TAG_VERSION)
	docker push $(CTR_TAG)
	docker tag $(DQD_TAG_VERSION) $(DQD_TAG)
	docker push $(DQD_TAG_VERSION)
	docker push $(DQD_TAG)

clean: env
	rm -f $(DIR)/vm.qcow2

all: env clean ctr vm dqd

dbg: clean ctr
	$(D2VM) convert $(CTR_TAG_VERSION) --append-to-cmdline nokaslr -p root -o $(DIR)/vm.qcow2
	cd $(DIR) && $(VIRT_SPARSIFY) --compress vm.qcow2 shrunk.qcow2 && mv -f shrunk.qcow2 vm.qcow2 && rm -f 1
	cd $(DIR) && docker build -t $(DQD_TAG_VERSION) -f Dockerfile.dbg .
