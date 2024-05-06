.PHONY: ctr vm dqd

env:
	$(eval include $(DIR)/.env)
	$(eval export $(shell sed 's/=.*//' $(DIR)/.env))

ctr: env
	$(eval TAG := ssst0n3/docker_archive:$@_$(IMAGE)_$(VERSION))
	@echo "Building Docker image in directory $(DIR) with image name $(IMAGE) and version $(VERSION), TAG is $(TAG)"
	@cd $(DIR) && docker build -t $(TAG) .