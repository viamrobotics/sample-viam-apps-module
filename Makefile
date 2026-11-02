.PHONY: create update upload build lint

VERSION := 1.0.0
MODULE_NAME := sample-apps-module
ORG_PUBLIC_NAMESPACE := nicolas-viam

create:
	viam module create --name=${MODULE_NAME} --public-namespace=${ORG_PUBLIC_NAMESPACE}

update:
	viam module update --module=meta.json

upload: build
	viam module upload --version=${VERSION} --platform=any --public-namespace=${ORG_PUBLIC_NAMESPACE} module

build:
	cd src/blue && npm install && npm run build
	cd src/red && npm install && npm run build
	tar czf module.tar.gz module meta.json

# Fixes formatting in place; CI runs the same check without --write.
lint:
	npx --yes prettier@3.9.10 --write src
