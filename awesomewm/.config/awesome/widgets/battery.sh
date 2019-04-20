#!/bin/sh

# AC and BAT0 value can depend on your system :(
online=$(cat /sys/class/power_supply/AC/online)
bat=/sys/class/power_supply/BAT0/uevent

show_ac() {
  local capacity="$(cat $bat | grep POWER_SUPPLY_CAPACITY | head -n 1 | cut -f 2 -d '=')"
  echo "AC $capacity"
}

show_bat() {
  # status are Discharging, Charging, Full
  local status="$(cat $bat | grep POWER_SUPPLY_STATUS | cut -f 2 -d '=')"
  local capacity="$(cat $bat | grep POWER_SUPPLY_CAPACITY | head -n 1 | cut -f 2 -d '=')"
  echo "$status $capacity"
}

if [ $online -eq 1 ] ; then
  show_ac
elif [ $online -eq 0 ] ; then
  show_bat
else
  echo "AC no found at $online"
  exit 1
fi

exit 0
