#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; V="${1:-6.18.55}"
K="$ROOT/kernel/$V/artifacts/bzImage"; [[ -f "$K" ]] || { echo "[!] missing $K"; exit 1; }
exec qemu-system-x86_64 -machine pc -m 4096 -smp 4 -kernel "$K" -append 'console=ttyS0 nokaslr' -nographic -no-reboot -monitor none -gdb tcp::1234 -S
