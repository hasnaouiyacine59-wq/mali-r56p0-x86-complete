#!/usr/bin/env bash
set -Eeuo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ $EUID -eq 0 ]]; then SUDO=""; else SUDO="sudo"; fi
command -v apt-get >/dev/null 2>&1 || { echo '[!] apt-based Debian/Kali/Ubuntu required'; exit 1; }
$SUDO apt-get update
$SUDO apt-get install -y build-essential bc bison flex gcc g++ make git wget curl ca-certificates xz-utils zstd cpio rsync kmod fakeroot pkg-config libssl-dev libelf-dev libdw-dev libncurses-dev dwarves python3 python3-pip gdb gdb-multiarch qemu-system-x86 qemu-utils busybox-static file unzip zip patch xxd binutils
mkdir -p "$ROOT_DIR"/{kernel/.downloads,driver/src,driver/build,driver/logs,driver/artifacts,patches,qemu,rootfs,logs,tools,artifacts}
chmod +x "$ROOT_DIR"/kernel/build_kernel.sh "$ROOT_DIR"/driver/*.sh "$ROOT_DIR"/patches/*.sh "$ROOT_DIR"/qemu/*.sh "$ROOT_DIR"/rootfs/*.sh "$ROOT_DIR"/tools/*.sh 2>/dev/null || true
echo "[+] Ready: $ROOT_DIR"
echo "[+] source $ROOT_DIR/workspace.env"
