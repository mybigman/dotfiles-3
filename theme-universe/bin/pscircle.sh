#!/bin/bash

# Example are on:
# https://gitlab.com/mildlyparallel/pscircle/tree/master/examples

# Here is specific to my poor resolution 1366x766

set -e
output=${1:-}

# tree-radius-increment = diameter of the circle
pscircle --output=$output \
	--output-width=1366 \
	--output-height=768 \
  --max-children=60 \
  --tree-radius-increment=108 \
	--dot-radius=3 \
	--link-width=1.3 \
	--tree-font-face="Roboto Mono Regular" \
	--tree-font-size=11 \
	--toplists-font-size=11 \
	--toplists-bar-width=30 \
	--toplists-row-height=15 \
	--toplists-bar-height=3 \
  --tree-font-color=FEDDED \
  --background-color=00000055 \
  --link-color-min=0f3f58 \
  --dot-color-min=FFFFFF77 \
	--cpulist-center=400.0:-80.0 \
	--memlist-center=400.0:80.0

#if command -v feh >/dev/null; then
#	feh --bg-fill $output
#	#rm $output
#fi
