#!/bin/bash
# Download a Quran translation from Tanzil.net
#
# Usage: ./download_translation.sh <identifier>
# Example: ./download_translation.sh en.sahih
#
# The identifier format is: language_code.translator_id
# Full list available at: https://tanzil.net/trans/
# See also: translations-index.json in the repository root
#
# Downloads are saved to:
#   by-language/<lang>/<identifier>.txt   (Tanzil pipe-delimited format)
#   formats/json/<identifier>.json        (structured JSON, if python3 available)
#
# Tanzil text format: each data line is surah|ayah|text
# Lines starting with # are metadata comments.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -z "$1" ]; then
    echo "Usage: $0 <translation-identifier>"
    echo ""
    echo "Example:"
    echo "  $0 en.sahih"
    echo ""
    echo "Phase 1 priority translations:"
    echo "  en.sahih       - Sahih International (English)"
    echo "  en.yusufali    - Abdullah Yusuf Ali (English)"
    echo "  en.pickthall   - Pickthall (English)"
    echo "  ur.jalandhry   - Fateh Muhammad Jalandhry (Urdu)"
    echo "  fr.hamidullah  - Muhammad Hamidullah (French)"
    echo "  tr.diyanet     - Diyanet Isleri (Turkish)"
    echo ""
    echo "Download all priority translations:"
    echo "  $0 --all-priority"
    echo ""
    echo "Full list of 140+ available identifiers:"
    echo "  https://tanzil.net/trans/"
    echo "  Or see: translations-index.json"
    exit 1
fi

# Handle --all-priority flag
if [ "$1" = "--all-priority" ]; then
    echo "=== Downloading all Phase 1 priority translations ==="
    echo ""
    for tid in en.sahih en.yusufali en.pickthall ur.jalandhry fr.hamidullah tr.diyanet; do
        bash "$0" "$tid"
        echo ""
        sleep 1
    done
    echo "=== All priority translations downloaded ==="
    exit 0
fi

TRANS_ID="$1"
LANG_CODE="${TRANS_ID%%.*}"

if [ -z "$LANG_CODE" ]; then
    echo "Error: Could not extract language code from identifier '$TRANS_ID'"
    echo "Expected format: language_code.translator_id (e.g., en.sahih)"
    exit 1
fi

LANG_DIR="$REPO_DIR/by-language/$LANG_CODE"
OUTPUT_FILE="$LANG_DIR/$TRANS_ID.txt"

mkdir -p "$LANG_DIR"

# Tanzil download endpoint (POST request required)
TANZIL_ENDPOINT="https://tanzil.net/pub/download/download.php"

echo "Downloading translation: $TRANS_ID"
echo "  Language: $LANG_CODE"
echo "  Output:   $OUTPUT_FILE"
echo ""

# Try POST method first (required by Tanzil's download form)
curl -sL "$TANZIL_ENDPOINT" \
    -X POST \
    -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
    -H "Referer: https://tanzil.net/trans/" \
    -d "transID=${TRANS_ID}&outType=txt&agree=true" \
    -o "$OUTPUT_FILE"

# Verify the download contains actual translation data (not HTML error page)
if [ ! -s "$OUTPUT_FILE" ]; then
    echo "Error: Download failed or file is empty."
    rm -f "$OUTPUT_FILE"
    exit 1
fi

# Check if we got HTML instead of text data (indicates download form error)
if head -5 "$OUTPUT_FILE" | grep -qi "<html\|<!DOCTYPE"; then
    echo "Error: Received HTML instead of translation data."
    echo "  The Tanzil download endpoint may have changed."
    echo "  Try downloading manually from: https://tanzil.net/trans/"
    rm -f "$OUTPUT_FILE"
    exit 1
fi

LINE_COUNT=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')
AYAH_COUNT=$(grep -c "^[0-9]" "$OUTPUT_FILE" 2>/dev/null || echo "0")

echo "Download complete!"
echo "  File:        $OUTPUT_FILE"
echo "  Total lines: $LINE_COUNT"
echo "  Ayah lines:  $AYAH_COUNT"

if [ "$AYAH_COUNT" -lt 6000 ]; then
    echo "  Warning: Expected ~6236 ayahs but found $AYAH_COUNT. The download may be incomplete."
fi

# Convert to JSON if python3 is available
if command -v python3 &> /dev/null; then
    JSON_DIR="$REPO_DIR/formats/json"
    mkdir -p "$JSON_DIR"
    JSON_FILE="$JSON_DIR/$TRANS_ID.json"
    INDEX_FILE="$REPO_DIR/translations-index.json"

    python3 << PYEOF
import json, os

trans_id = "$TRANS_ID"
lang_code = "$LANG_CODE"
output_file = "$OUTPUT_FILE"
json_file = "$JSON_FILE"
index_file = "$INDEX_FILE"

# Look up translator name from index
translator_name = trans_id
if os.path.exists(index_file):
    with open(index_file, "r", encoding="utf-8") as f:
        index = json.load(f)
    for entry in index.get("translations", []):
        if entry["identifier"] == trans_id:
            translator_name = entry["translator"]
            break

# Parse Tanzil text format
ayahs = []
with open(output_file, "r", encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        parts = line.split("|", 2)
        if len(parts) == 3:
            try:
                ayahs.append({
                    "surah": int(parts[0]),
                    "ayah": int(parts[1]),
                    "text": parts[2]
                })
            except ValueError:
                pass

# Write JSON
data = {
    "identifier": trans_id,
    "language": lang_code,
    "translator": translator_name,
    "source": "tanzil.net",
    "ayahs": ayahs,
}
with open(json_file, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print(f"  JSON:        {json_file} ({len(ayahs)} ayahs)")

# Update translations-index.json availability
if os.path.exists(index_file):
    with open(index_file, "r", encoding="utf-8") as f:
        index = json.load(f)
    updated = False
    for entry in index.get("translations", []):
        if entry["identifier"] == trans_id:
            entry["available"] = True
            updated = True
            break
    if not updated:
        index.setdefault("translations", []).append({
            "identifier": trans_id,
            "language": lang_code,
            "language_name": lang_code,
            "translator": translator_name,
            "available": True
        })
    with open(index_file, "w", encoding="utf-8") as f:
        json.dump(index, f, ensure_ascii=False, indent=2)
    print(f"  Index:       {trans_id} marked as available")
PYEOF
else
    echo "  Note: python3 not found. Skipping JSON conversion."
fi
