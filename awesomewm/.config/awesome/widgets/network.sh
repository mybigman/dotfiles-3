#!/bin/sh

wlan=$(ip a | grep wlp | grep UP | awk '{print $2}')
eth=$(ip a | grep enp | grep UP | awk '{print $2}')

show_ip() {
  local ipaddr=$(ip a | grep $1 | grep inet | awk '{print $2}' | sed "s:/.[0-9]*::")
  echo "$1 $ipaddr"
}

show_net_ip() {
  if [[ ! -z $wlan ]] ; then
    show_ip "${wlan:0:-1}"
  elif [[ ! -z $eth ]] ; then
    show_ip "${eth:0:-1}"
  else
    echo "1"
    exit 1
  fi
}

wifi_strenght() {
  if [[ ! -z wlan ]] ; then
    cat /proc/net/wireless | grep wlp | awk '{print $3}' | cut -d"." -f1
  else
    echo "1"
  fi
}

case "$1" in 
  net)
    show_net_ip
    shift
    ;;
  wifi)
    wifi_strenght
    shift
    ;;
  *)
    exit 1
esac

exit 0
