.PHONY: ctr vm dqd

env:
	$(eval include $(DIR)/.env)
	$(eval export $(shell sed 's/=.*//' $(DIR)/.env))
	$(eval CTR_TAG := ssst0n3/docker_archive:$@_$(IMAGE)_$(VERSION))

ctr: env
	@echo "Building Docker image in directory $(DIR) with image name $(IMAGE) and version $(VERSION), TAG is $(CTR_TAG)"
	@cd $(DIR) && docker build -t $(CTR_TAG) .

d2vm=docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v $(PWD):/d2vm -w /d2vm linkacloud/d2vm:latest $*
vm: env
	@cd $(DIR) && @$(d2vm) convert CTR_TAG -o vm.qcow2 . -v