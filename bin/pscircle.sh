#!/bin/bash
set -e
output=~/pscircle.png

pscircle --output=$output \
	--output-width=1366 \
	--output-height=768 \
  --max-children=55 \
  --tree-radius-increment=110 \
	--dot-radius=3 \
	--link-width=1.3 \
	--tree-font-face="Hack Regular" \
  --background-color=272427FF \
  --tree-font-color=94bfd1 \
	--tree-font-size=10 \
	--toplists-font-size=11 \
	--toplists-bar-width=30 \
	--toplists-row-height=15 \
	--toplists-bar-height=3 \
	--cpulist-center=400.0:-80.0 \
	--memlist-center=400.0:80.0

if command -v feh >/dev/null; then
	feh --bg-fill $output
	rm $output
fi
