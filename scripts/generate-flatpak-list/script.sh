#!/usr/bin/env bash

set -euox pipefail

FLATPAK_REMOTE_NAME="flathub"
FLATPAK_REMOTE_URL="https://flathub.org/repo/flathub.flatpakrepo"
FLATPAK_REMOTE_REFS=("app/org.videolan.VLC/x86_64/stable") #  "app/org.videolan.VLC/x86_64/stable" "app/org.gnome.Calculator/x86_64/stable"
export FLATPAK_SYSTEM_DIR="/flatpak/flatpak"

mkdir -p ${FLATPAK_SYSTEM_DIR} /flatpak/triggers
mkdir /var/tmp
chmod -R 1777 /var/tmp

# Setup Flathub
flatpak config --system --set languages "*"
flatpak remote-add --system --if-not-exists ${FLATPAK_REMOTE_NAME} ${FLATPAK_REMOTE_URL}

# Install Flathub apps
flatpak install --system -y ${FLATPAK_REMOTE_REFS[@]}
ostree init --repo=/flatpak_dir/repo --mode=archive-z2

for i in $(ostree refs --repo=${FLATPAK_SYSTEM_DIR}/repo | grep '^deploy/' | sed 's/^deploy\///g'); do
  echo "Copying $i..."
  ostree --repo=/flatpak_dir/repo pull-local ${FLATPAK_SYSTEM_DIR}/repo $(ostree --repo=${FLATPAK_SYSTEM_DIR}/repo rev-parse ${FLATPAK_REMOTE_NAME}/$i)
  mkdir -p $(dirname /flatpak_dir/repo/refs/heads/$i)
  ostree --repo=${FLATPAK_SYSTEM_DIR}/repo rev-parse ${FLATPAK_REMOTE_NAME}/$i > /flatpak_dir/repo/refs/head/$i
done

flatpak build-update-repo /flatpak_dir/repo
ostree refs --repo=/flatpak_dir/repo | tee /flatpak_dir/list.txt
