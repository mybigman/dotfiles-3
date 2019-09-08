#!/bin/sh

distro="gentoo"
theme='machine'
font='space mono nerd font 13'
wm='awesome'
res="$(xwininfo -root | grep geometry | awk '{print $2}' | cut -d + -f1)"

printf "\t" # align the colors
#█▓▒░ colors
i=0
while [ $i -le 6 ]
do
  printf "\e[$((i+41))m\e[$((i+30))m█▓▒░"
  i=$(($i+1))
done
printf "\e[37m█\e[0m▒░\n\n"

# Few colors
d=$'\e[1m' # bold
t=$'\e[0m' # end
red=$'\e[1;91m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
green=$'\e[1;92m'
dgreen=$'\e[1;32m'

# colors for the display
logo=$green
title=$red
info=$dgreen

cat << EOF
     $logo.-"|"-.$t   $title os    $info$distro$t
    $logo/ _   _ \\$t  $title theme $info$theme$t
    $logo](~  \`~)[$t  $title font  $info$font$t
    $logo\`-. 0 ,-'$t  $title wm    $info$wm$t
    $logo  |...|$t    $title res   $info$res$t

 $title music >$t$info MASTER BOOT RECORD - Direct Memory Access
EOF
