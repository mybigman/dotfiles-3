#!/bin/sh

# Deps: youtube-dl

# Script to download musics on youtube
# Dep: youtube-dl
# Usage e.g: ydl.sh https://youtu.be/1dAazZxw83Y?list=PLYaK2zRLpEbvjyUIqjroO5sVxugCRTH7c

LINK_MUSIC="$1"
WORKDIR="$HOME/mps"
OLDPATH="$(pwd)"
agentsList=(
    "Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"
    "Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201"
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36"
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"
)
RANDOM=$$$(date +%s)
rand=$[$RANDOM % ${#agentsList[@]}]
agent="${agentsList[$rand]}"

cd $WORKDIR
echo "Downloading $LINK_MUSIC..."

youtube-dl \
  --proxy "socks5://${TOR_SOCKS_HOST}:${TOR_SOCKS_PORT}" \
  --user-agent "$agent" \
  --add-metadata \
  -o '%(title)s.%(ext)s' \
  -f 'bestaudio' \
  --no-playlist \
  -x --audio-format best \
  --audio-quality 0 "$LINK_MUSIC"

echo "$LINK_MUSIC success"
cd $OLDPATH

exit 0
