.PHONY: ctr vm dqd

env:
	$(eval include $(DIR)/.env)
	$(eval export $(shell sed 's/=.*//' $(DIR)/.env))
	$(eval CTR_TAG := ssst0n3/docker_archive:$@_$(IMAGE)_$(VERSION))
	$(eval DQD_TAG := ssst0n3/docker_archive:$(IMAGE)_$(VERSION))

ctr: env
	@echo "Building Docker image in directory $(DIR) with image name $(IMAGE) and version $(VERSION), TAG is $(CTR_TAG)"
	@cd $(DIR) && docker build -t $(CTR_TAG) .

D2VM := docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v $(PWD):/d2vm -w /d2vm linkacloud/d2vm:latest $*
vm: env
	$(D2VM) convert $(CTR_TAG) -o $(DIR)/vm.qcow2 -v
	cd $(DIR) && virt-sparsify --compress vm.qcow2 shrunk.qcow2 && mv shrunk.qcow2 vm.qcow2

dqd: env
	cp $(DIR)/vm.qcow2 dqd
	docker build -t $(DQD_TAG) dqd
	rm dqd/vm.qcow2

clean: env
	rm $(DIR)/vm.qcow2

all: env
	clean
	ctr
	vm
	dqd