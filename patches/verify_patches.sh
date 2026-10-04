#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
P="$ROOT/patches"
for f in "$P"/*.patch; do test -f "$f" || { echo '[FAIL] no patches'; exit 1; }; done
count=$(find "$P" -maxdepth 1 -name '*.patch' | wc -l)
[[ "$count" -eq 6 ]] || { echo "[FAIL] expected 6 patches, found $count"; exit 1; }
echo '[+] Six VP patches present:'
find "$P" -maxdepth 1 -name '*.patch' -printf '  %f\n' | sort
sha256sum "$P"/*.patch "$ROOT/driver/AX504X08X-SW-99002-r56p0-18eac0.tar.gz"
echo '[!] Applicability is checked by build_driver.sh; patches are not assumed compatible with r56p0.'
