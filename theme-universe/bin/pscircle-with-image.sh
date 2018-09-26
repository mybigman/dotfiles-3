#!/bin/sh

set -e 

MY_NAME="${0##*/}"
WORKDIR="/tmp/$MY_NAME"
background="${1:?}"
#foreground="${2:?}"
dimension=$(xdpyinfo | grep dimension | awk '{print $2}')
oldpath="$(pwd)"

# Create the work directory
if [ ! -d $WORKDIR ] ; then 
  mkdir $WORKDIR
fi

cd $WORKDIR

# check size
# identify -format '%wx%h' $1

# resize an image avec \! to avoid scalling
convert "$oldpath/$background" -resize $dimension\! bg.png

# Call pscircle.sh to generate fg.png
sh "$oldpath/bin/pscircle.sh" fg.png

# Superpose both image
convert -size $dimension -composite bg.png fg.png -geometry $dimension+0+0 final.png

# set wallpaper
feh --bg-fill final.png
[ $? -eq 0 ] && echo "wall success"

exit 0
