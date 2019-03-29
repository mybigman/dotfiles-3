#!/bin/sh

check_tor() {
  local url
   url="https://check.torproject.org/"
  curl -s -m 10 -L "$url" | cat | tac | grep -q 'Congratulations'
  if [ $? -eq 0 ] ; then
    echo "[+] Tor is working properly"
  else
    echo "[-] Unfortunately, Tor is no working"
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

check_tor
check_ip

exit 0
