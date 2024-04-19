#!/usr/bin/env bash

set -euox pipefail

DOCKER_IMAGE="ghcr.io/rsturla/eternal-linux/lumina:39"

# Generate list of flatpak dependencies
docker run --privileged --rm -v $(pwd)/scripts/flatpaks/_docker:/data -v $(pwd)/output:/output ${DOCKER_IMAGE} /data/generate-dependencies.sh
