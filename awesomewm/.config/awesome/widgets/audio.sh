#!/bin/sh

log_file="/tmp/audio.log"
log=true # true or false
time="$(date)"
mpc=$(which mpc 2>/dev/null 2>&1)

log() {
  if $log ; then
    echo "$time - $1" >> $log_file
  fi
}

die() {
  log "[DIE]: $1"
  exit 1
}

music_state() {
  local music_info
  [ -z $mpc ] && die "mpc no found"
  if music_info="$(mpc | grep  "playing\|paused\|stop" | awk '{print $3,$4}' | tr -d '()')" ; then
    echo "$music_info"
  fi
}

draw() {
  local v inc out size cur_lenght bar
  cur_lenght="$(mpc | awk 'NR == 2 {gsub(/[()%]/,""); print $4}')"
  size=28
  inc=$(( cur_lenght * size / 100 ))
  out=
  #bar=$(grep "^progressbar" ~/.ncmpcpp/config | awk '{print $3}' | tr -d '"')
  bar="■"
  for v in $(seq 0 $(( size - 1 )) ) ; do
    test "$v" -le "$inc" && \
      out="${out}${bar:--}" || \
      out="${out}┄"
  done
  echo $out
}

searchAlbumCover() {
  local MUSIC_DIR="$1"
  local file="$(mpc --format %file% current)"
  local album_dir="${file%/*}"
  local cover=""
  local src=""
  album_dir="$MUSIC_DIR/$album_dir"
  if [ -d "$album_dir" ] ; then
    covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\)" \; )"
    src="$(echo -n "$covers" | head -n1)"
    if [ -f "$src" ] ; then
      echo "$src"
    fi
  fi
}

call_mpc_details() {
  local img title album artist

  img=$(searchAlbumCover "$1")
  artist="$(mpc current -f %artist% | tr -d "%([]){}\1/")"
  #album="$(mpc current -f %album% | tr -d "%([]){}\1/")"
  title="$(mpc current -f %title% | tr -d "%([]){}\1/")"

  echo "img:[$img] title:[${title:0:30}] artist:[$artist] percbar:[$(draw)]"
}

music_details() {
  local mpd_is_playing="$(mpc | grep "playing\|paused")"
  if [[ ! -z $mpd_is_playing ]] ; then
    call_mpc_details "$1"
  else
    exit 1
  fi
}

case $1 in
  music)
    music_state
    shift
    ;;
  music_details)
    music_details "$2"
    shift
    shift
    ;;
  -q | --quiet)
    log=false
    shift
    ;;
  *)
    die "arg: $1 not recognized"
esac
