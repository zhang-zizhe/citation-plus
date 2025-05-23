#!/usr/bin/env bash
set -e


AUTHOR_ID="XXXXXXXXXX"           # Your Google Scholar ID
LOG="$HOME/citation_dsp/logs/citations.log"

mkdir -p "$(dirname "$LOG")"

TOTAL=$(python3 - <<'EOF'
import urllib.request, re, sys

url = f"https://scholar.google.com/citations?user={AUTHOR_ID}&hl=en"
html = urllib.request.urlopen(url).read().decode("utf-8")

m = re.search(r'<td[^>]*class="gsc_rsb_std"[^>]*>([\d,]+)</td>', html)
if not m:
    print(0)
else:
    print(m.group(1).replace(",", ""))
EOF
)

TODAY=$(date '+%Y-%m-%d')
echo "$TODAY $TOTAL" >> "$LOG"
echo "Appended $TODAY $TOTAL to $LOG"

