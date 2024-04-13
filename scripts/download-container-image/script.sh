#!/usr/bin/env bash

set -euox pipefail

skopeo copy docker://${IMAGE_REPO}/${IMAGE_NAME}:${IMAGE_TAG} oci:${IMAGE_NAME}-${IMAGE_TAG}
