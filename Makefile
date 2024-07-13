VERSION_NUMBER = 10.9.8
JELLYFIN_VERSION = v$(VERSION_NUMBER)
PYTHON = ~/venv/bin/python
REGISTRY_HOST =
JELLYFIN_SRC_PATH =

sync:
	@if [ -n "${JELLYFIN_SRC_PATH}" ]; then \
		cd $(JELLYFIN_SRC_PATH); \
		git fetch upstream; \
		git rebase $(JELLYFIN_VERSION); \
		echo "push manually"; \
	fi

pull:
	cd jellyfin-server
	git pull
	echo "reset head manually"

build:
	$(PYTHON) ./build.py $(VERSION_NUMBER) docker amd64 --local

reg:
	@if [ -n "${REGISTRY_HOST}" ]; then \
		docker image tag docker.io/jellyfin/jellyfin:$(VERSION_NUMBER)-amd64 $(REGISTRY_HOST)/jellyfin:$(VERSION_NUMBER); \
		docker image tag $(REGISTRY_HOST)/jellyfin:$(VERSION_NUMBER) $(REGISTRY_HOST)/jellyfin:latest; \
		docker push $(REGISTRY_HOST)/jellyfin:$(VERSION_NUMBER); \
		docker push $(REGISTRY_HOST)/jellyfin:latest; \
	fi