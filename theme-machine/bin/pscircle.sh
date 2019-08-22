#!/bin/bash

# Example are on:
# https://gitlab.com/mildlyparallel/pscircle/tree/master/examples

# Here is specific to my poor resolution 1366x766

set -e
output=${1:-}

# tree-radius-increment = diameter of the circle
pscircle --output=$output \
  --background-color=00000000 \
  --max-children=18 \
	--output-width=1366 \
	--output-height=768 \
  --tree-radius-increment=40 \
	--dot-radius=2.0 \
	--link-width=1.5 \
	--tree-font-face="Iosevka Term Regular" \
	--tree-font-size=12 \
  --tree-center=0:-20 \
	--toplists-font-size=11 \
	--toplists-bar-width=30 \
	--toplists-row-height=15 \
	--toplists-bar-height=3 \
  --tree-font-color=849a9a \
  --link-color-min=51606a \
  --dot-color-min=FFFFFF77 \
	--cpulist-center=335.0:-70.0 \
	--memlist-center=335.0:70.0

#if command -v feh >/dev/null; then
#	feh --bg-fill $output
#	#rm $output
#fi
