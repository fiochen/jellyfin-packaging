VERSION_NUMBER = 10.11.10
JELLYFIN_VERSION = v$(VERSION_NUMBER)
MOD_BRANCH = release-$(VERSION_NUMBER)-mod
PYTHON = ~/venv/bin/python
REGISTRY_HOST =
JELLYFIN_SRC_PATH =

pull:
	cd jellyfin-server
	git pull origin $(MOD_BRANCH)

build:
	$(PYTHON) ./build.py $(VERSION_NUMBER) docker amd64 --local

reg:
	@if [ -n "${REGISTRY_HOST}" ]; then \
		docker image tag docker.io/jellyfin/jellyfin:$(VERSION_NUMBER)-amd64 $(REGISTRY_HOST)/jellyfin:$(VERSION_NUMBER); \
		docker image tag docker.io/jellyfin/jellyfin:$(VERSION_NUMBER)-amd64 $(REGISTRY_HOST)/jellyfin:latest; \
		docker push $(REGISTRY_HOST)/jellyfin:$(VERSION_NUMBER); \
		docker push $(REGISTRY_HOST)/jellyfin:latest; \
	fi

# init-py:
# 	python3 -m venv .venv
# 	source .venv/bin/activate
# 	python -m pip install --upgrade pip
# 	pip install -r requirements.txt 
