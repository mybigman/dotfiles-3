#!/bin/sh

XRESOURCES=~/.Xresources
TERMITE=~/.config/termite/config
DEST=$1
_COLORS=(
    "color0"
    "color1"
    "color2"
    "color3"
    "color4"
    "color5"
    "color6"
    "color7"
    "color8"
    "color9"
    "color10"
    "color11"
    "color12"
    "color13"
    "color14"
    "color15"
    "background"
    "foreground"
)

function writeToDest() {
    echo "*$1: $2" >> "${DEST}"
}

function retrieve() {
    local cc=$(grep "^$1=" $TERMITE) # search color= #xxxxxx
    [[ -z $cc ]] && local cc=$(grep "^$1 =" $TERMITE) # search color = #xxxxxx

    c=$(echo $cc | grep -oE '#[a-zA-Z0-9]{6}' | cut -c 1-)
    echo "$1 - $c"
    writeToDest $1 $c
}

function rofiConf() {
    local bg=$(grep background ${DEST} | awk '{print $2}')
    local fg=$(grep color3 ${DEST} | awk '{print $2}')
    local bgSelect=$(grep color0 ${DEST} | awk '{print $2}')
    local fgSelect=$(grep color11 ${DEST} | awk '{print $2}')
    echo "rofi.color-normal: argb:00000000, ${fg}, argb:00000000, ${bgSelect}, ${fgSelect}" >> "${DEST}"
    echo "rofi.color-window: ${bg}, #000000, #832757" >> "${DEST}"
}

if [ ! -f "${DEST}" ] && [ ! -z "${1}" ]; then
    for co in "${_COLORS[@]}"; do retrieve $co; done
    rofiConf
    xrdb -merge ${XRESOURCES}
    echo "You can include this file to $XRESOURCES with a line like: #include '$DEST'"
else
    echo "Destination exist alrealy or not defined as arg"
    echo "Usage: $0 /tmp/newfile" && exit 1
fi
