#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; O="$ROOT/rootfs/initramfs"; rm -rf "$O"; mkdir -p "$O"/{bin,proc,sys,dev,tmp,etc,root}
cp "$(command -v busybox)" "$O/bin/busybox"; for a in sh mount umount cat echo ls mkdir mknod insmod rmmod dmesg uname sleep; do ln -sf /bin/busybox "$O/bin/$a"; done
cat > "$O/init" <<'INIT'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev 2>/dev/null || true
uname -a
cat /proc/cmdline
exec /bin/sh
INIT
chmod +x "$O/init"; (cd "$O" && find . -print0 | cpio --null -ov --format=newc) | gzip -9 > "$ROOT/rootfs/initramfs.cpio.gz"
echo "[+] $ROOT/rootfs/initramfs.cpio.gz"
