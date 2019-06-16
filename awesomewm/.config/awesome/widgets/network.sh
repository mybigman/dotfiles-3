#!/bin/sh

# some codes come from site: https://www.adminsehow.com/2010/03/shell-script-to-show-network-speed/

# Global variables
if wlan=$(ip a | grep wlp | grep UP | awk '{print $2}') ; then
  interface=$wlan
elif eth=$(ip a | grep enp | grep UP | awk '{print $2}') ; then
  interface=$eth
else
  exit 1
fi

received_bytes=""
old_received_bytes=""
transmitted_bytes=""
old_transmitted_bytes=""

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
function get_bytes {
  line=$(cat /proc/net/dev | grep $interface | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
  eval $line
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.
function get_velocity {
  value=$1    
  old_value=$2

  let vel=$value-$old_value
  let velKB=$vel/1000
  let velMB=$vel/1000000
  if [ $velMB != 0 ] ; then
    echo -n "$velMB MB/s"
  elif [ $velKB != 0 ] ; then
    echo -n "$velKB KB/s"
  else
    echo -n "$vel B/s"
  fi
}

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

function network_monitor {
  # Gets initial values.
  get_bytes
  old_received_bytes=$received_bytes
  old_transmitted_bytes=$transmitted_bytes
  sleep 1
  # Get new transmitted and received byte number values.
  get_bytes
  # Calculates speeds.
  vel_recv=$(get_velocity $received_bytes $old_received_bytes)
  vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes)
  # Shows results in the console.
  echo -e "$interface DOWN: $vel_recv UP: $vel_trans"
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
  monitor)
    network_monitor
    shift
    ;;
  *)
    exit 1
esac

exit 0
