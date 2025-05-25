#!/usr/bin/env bash
set -e

SCHOLAR_ID="YOUR_GOOGLE_SCHOLAR_ID"           # Your Google Scholar ID
LOG="$HOME/citation-plus/logs/citations.log"

mkdir -p "$(dirname "$LOG")"

TOTAL=$(python3 - <<EOF
import urllib.request, re

# Bash will have already substituted ${SCHOLAR_ID} here
url = "https://scholar.google.com/citations?user=${SCHOLAR_ID}&hl=en"
html = urllib.request.urlopen(url).read().decode("utf-8", errors="replace")

m = re.search(r'<td[^>]*class="gsc_rsb_std"[^>]*>([\d,]+)</td>', html)
print(m.group(1).replace(",", "") if m else "0")
EOF
)

TODAY=$(date '+%Y-%m-%d')

echo "[$TODAY] total citations: $TOTAL" >> "$LOG"

