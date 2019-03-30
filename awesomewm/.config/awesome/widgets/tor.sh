#!/bin/sh

check_tor() {
  local url
   url="https://check.torproject.org/"
  curl -s -m 10 -L "$url" | cat | tac | grep -q 'Congratulations'
  if [ $? -eq 0 ] ; then
    echo 0
  else
    echo 1
    exit 1
   fi

}

check_ip() {
  local ipa
  if ipa="$(curl -s -m 11 https://ipinfo.io)" ; then
    echo "$ipa"
  elif ext_ip="$(curl -s -m 10 https://ip-api.com)" ; then
    echo "$ext_ip"
  else
    echo "no found..."
    exit 1
  fi
}

case "$1" in
  check) check_tor ;;
  ip) check_ip ;;
  *) echo "unknown arg $1" ; exit 1 ;;
esac

exit 0
