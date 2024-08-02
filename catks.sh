#!/usr/bin/bash
#
# Mount an ISO from a config directory and print the contents of the kickstart
# files.

set -euo pipefail

path="${1}"
iso="${path}/output/bootiso/install.iso"

mntdir="$(mktemp -d)"
sudo mount -o ro "${iso}" "${mntdir}"

cleanup() {
    sudo umount "${mntdir}"
    rmdir "${mntdir}"
}

trap cleanup EXIT

pushd "${mntdir}"
bat "osbuild.ks"
bat "osbuild-base.ks"
popd
