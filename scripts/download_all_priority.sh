#!/bin/bash
# Download all Phase 1 priority translations from Tanzil.net
# Creates both txt and json formats for each translation.

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Downloading Phase 1 Priority Translations ==="
echo ""

for tid in en.sahih en.yusufali en.pickthall ur.jalandhry fr.hamidullah tr.diyanet; do
    bash "$SCRIPT_DIR/download_translation.sh" "$tid"
    echo ""
    sleep 2
done

echo "=== All priority translations downloaded ==="
