#!/usr/bin/env bash
set -e

AUTHOR_ID="YOUR_GOOGLE_SCHOLAR_ID"           # Your Google Scholar ID
LOG="$HOME/display-citation-in-terminal/logs/citations.log"

mkdir -p "$(dirname "$LOG")"

TOTAL=$(python3 - <<EOF
import urllib.request, re

# Bash will have already substituted ${AUTHOR_ID} here
url = "https://scholar.google.com/citations?user=${AUTHOR_ID}&hl=en"
html = urllib.request.urlopen(url).read().decode("utf-8")

m = re.search(r'<td[^>]*class="gsc_rsb_std"[^>]*>([\d,]+)</td>', html)
print(m.group(1).replace(",", "") if m else "0")
EOF
)

TODAY=$(date '+%Y-%m-%d')

echo "[$TODAY] total citations: $TOTAL" >> "$LOG"

