# Makefile - infrastructure build abstraction
# vim:ft=make

PACKER_VERSION ?= "0.8.6"
TF_VERSION 		 ?= "0.6.6"
NOMAD_VERSION  ?= "0.1.2"
PACKER_DIST    ?= ../_bin/packer-$(PACKER_VERSION)
NOMAD_DIST     ?= ../_bin/nomad-$(NOMAD_VERSION)
TF_DIST        ?= ../_bin/terraform-$(TF_VERSION)

all: cluster

tools: $(PACKER_DIST) $(TF_DIST) $(NOMAD_DIST)
	./scripts/install.bintray.sh packer $(PACKER_VERSION) $(PACKER_DIST)
	./scripts/install.bintray.sh terraform $(TF_VERSION) $(TF_DIST)
	./scripts/install.bintray.sh nomad $(NOMAD_VERSION) $(NOMAD_DIST)

cluster: images
ifndef DIGITALOCEAN_TOKEN
	$(error DIGITALOCEAN_TOKEN is not set)
endif
	cd infrastructure/cluster && \
		terraform get && \
		terraform apply

.PHONY: image.nomad
image.nomad:
	package validate infrastructure/images/nomad/packer.json
	package build infrastructure/images/nomad/packer.json

.PHONY: images
images: tools image.nomad
	@echo "done building image!"

.PHONY: clean
clean:
	cd infrastructure/cluster && \
		terraform destroy -force
