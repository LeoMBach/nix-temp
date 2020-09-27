#! /usr/bin/env bash

VM_MEMORY="4096"
VM_CORES="4"

export QEMU_OPTS="-m $VM_MEMORY -smp $VM_CORES"
export QEMU_NET_OPTS="hostfwd=tcp::2221-:22"

"$(dirname "$(readlink -f "$0")")"/../result/bin/run-*-vm
