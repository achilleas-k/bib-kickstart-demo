#!/usr/bin/bash
#
# Build an ISO with the given config from the base Fedora 40 bootc container.

set -euo pipefail
set -x

path="${1}"

sudo -v
sudo podman pull quay.io/achilleas/bootc-image-builder:demo
sudo podman pull quay.io/centos-bootc/centos-bootc:stream9

mkdir -vp "${path}/output" ./rpmmd ./store

sudo podman run --privileged -it --rm \
    --security-opt label=type:unconfined_t \
    -v "./${path}/output:/output" \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    -v "./${path}/config.toml:/config.toml" \
    -v ./rpmmd:/rpmmd \
    -v ./store:/store \
    quay.io/achilleas/bootc-image-builder:demo \
    --type iso \
    --local \
    quay.io/centos-bootc/centos-bootc:stream9
