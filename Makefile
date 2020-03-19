SHELL:=/bin/bash

SOURCE_NAME ?= "my-00"

install:
	- kubectl create ns openshift-operator-lifecycle-manager
	helm install $(SOURCE_NAME) . --namespace openshift-operator-lifecycle-manager

update:
	helm upgrade $(SOURCE_NAME) . --namespace openshift-operator-lifecycle-manager

delete:
	helm delete $(SOURCE_NAME) --namespace openshift-operator-lifecycle-manager
