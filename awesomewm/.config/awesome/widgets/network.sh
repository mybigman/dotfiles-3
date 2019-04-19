#!/bin/sh

show_ip() {
  local ipaddr=$(ip a | grep $1 | grep inet | awk '{print $2}' | sed "s:/.[0-9]*::")
  echo "$1 $ipaddr"
}

if net=$(ip a | grep wlp | grep UP |  awk '{print $2}') ; then
  show_ip "${net:0:-1}"
elif net=$(ip a | grep enp | grep UP | awk '{print $2}') ; then
  show_ip "${net:0:-1}"
else
  echo "1"
  exit 1
fi

exit 0
