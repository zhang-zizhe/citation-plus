#!/usr/bin/env bash
# ——— Print total citations + 30-day increase on terminal open ———
CITATION_LOG="$HOME/citation-plus/logs/citations.log"

if [[ -r $CITATION_LOG ]]; then
  total=$(tail -n1 "$CITATION_LOG" | awk '{print $2}')
  cutoff=$(date -v-30d '+%Y-%m-%d')
  past=$(grep -m1 "^$cutoff" -A0 "$CITATION_LOG" | awk '{print $2}')
  [[ -z $past ]] && past=$(head -n1 "$CITATION_LOG" | awk '{print $2}')
else
  total=0
  past=0
fi

recent=$(( total - past ))

echo "📖 Total citations: $total (last 30 days +$recent)"
echo "May your academic impact continue to grow! 💪"
