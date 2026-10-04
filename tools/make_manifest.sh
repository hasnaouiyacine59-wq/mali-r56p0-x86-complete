#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; OUT="$ROOT/artifacts/manifest.txt"; mkdir -p "$ROOT/artifacts"; { date -u; uname -a; echo '[patches]'; sha256sum "$ROOT"/patches/*.patch; echo '[r56p0]'; sha256sum "$ROOT"/driver/AX504X08X-SW-99002-r56p0-18eac0.tar.gz; echo '[artifacts]'; find "$ROOT/driver/artifacts" -type f -print0 2>/dev/null | xargs -0 -r sha256sum; } > "$OUT"; cat "$OUT"
