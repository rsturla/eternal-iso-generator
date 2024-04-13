#!/usr/bin/env bash

set -euox pipefail

BASE_DIR="$(pwd)"
IMAGE_NAME=""
IMAGE_REPO=""
# _IMAGE_REPO_ESCAPED = $(subst /,\/,$(IMAGE_REPO))
# _IMAGE_REPO_DOUBLE_ESCAPED = $(subst \,\\\,$(_IMAGE_REPO_ESCAPED))
IMAGE_REPO_ESCAPED=$(echo ${IMAGE_REPO} | sed 's/\//\\\//g')
IMAGE_REPO_DOUBLE_ESCAPED=$(echo ${IMAGE_REPO_ESCAPED} | sed 's/\\/\\\\/g')

generate_lorax_templates() {
  mkdir -p ${BASE_DIR}/templates/gen/lorax
  sed 's/@IMAGE_NAME@/${IMAGE_NAME}/' ${BASE_DIR}/templates/lorax/*.tmpl.in > ${BASE_DIR}/templates/gen/lorax/*.tmpl
  > ${BASE_DIR}/templates/gen/lorax/$*.tmpl

}

generate_lorax_templates
