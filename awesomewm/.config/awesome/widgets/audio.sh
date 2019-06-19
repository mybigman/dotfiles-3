#!/bin/sh

audio_card=""
volume=""
AMIXER=$(which amixer)
MPC=$(which mpc)

die() {
  echo "Error: $1"
  exit 1
}

check_audio_card() {
  local card
  if card=$(cat /proc/asound/card*/id | grep -i "^$1$") ; then
    audio_card=$1
  fi
}

alsa_or_pulse() {
  local vol bin
  if bin=$(which pactl 2>/dev/null) && volume=$($bin list sinks | grep "^Volume" | grep -o -E "[[:digit]]+%" | head -n 1) ; then
    echo "pactlPulse$1: $volume"
    return 0
  elif volume=$($AMIXER -c $1 -M get Master | grep -o -E "[[:digit:]]+%" | head -n 1) ; then
    echo "amixerAlsa$1: $volume"
    return 0
  elif volume=$($AMIXER -c $1 -M -D pulse get Master | grep -o -E "[[:digit:]]+%" | head -n 1) ; then
    echo "amixerPulse$1: $volume"
    return 0
  fi
  return 1
}

# Check first a card given as argument else try card n2 or n1
show_volume() {
  [ -z $AMIXER ] && die "amixer no found"
  if [ ! -z $audio_card ] ; then
    alsa_or_pulse $audio_card
  elif alsa_or_pulse 2 ; then
    echo
  elif alsa_or_pulse 1 ; then
    echo
  elif alsa_or_pulse 0 ; then
    echo
  else
    die "volume no found with amixer"
  fi
}

music_state() {
  local music_info
  [ -z $MPC ] && die "mpc no found"
  if music_info=$($MPC | grep "\[" | awk '{print $3,$4}' | tr -d '()') ; then
    echo "$music_info"
  fi
}

case $1 in
  volume) 
    check_audio_card $2
    show_volume $2
    shift
    shift
    ;;
  music)
    music_state
    shift
    ;;
  *)
    die "arg: $1 not recognized"
esac

exit 0
