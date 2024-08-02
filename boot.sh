#!/usr/bin/bash
#
# Create an empty disk and boot it with the ISO from the given configuration
# directory for installation.

set -euo pipefail
set -x

path="${1}"

qemu-img create -f qcow2 "${path}/disk.qcow2" 20G

qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -m 8G \
    -bios /usr/share/edk2-ovmf/x64/OVMF.fd \
    -cdrom "${path}/output/bootiso/install.iso" \
    -drive file="${path}/disk.qcow2"
