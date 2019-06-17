#!/bin/sh

bat_state=""
bat_name=""
bat_status=""
ac_state=false
energy_dir="/sys/class/power_supply"

if AC=($(cat $energy_dir/AC/online) -eq 1) ; then
  ac_state=true
fi

save_energy() {
  local bat_path=$energy_dir/$1/uevent
  # status are Discharging, Charging, Full
  bat_status="$(cat $bat_path | grep POWER_SUPPLY_STATUS | cut -f 2 -d '=')"
  bat_state="$(cat $bat_path | grep POWER_SUPPLY_CAPACITY | head -n 1 | cut -f 2 -d '=')"
}

# check BAT1 or BAT0
if [ -d $energy_dir/BAT1 ] ; then
  bat_name="BAT1"
  save_energy "BAT1"
elif [ -d $energy_dir/BAT0 ] ; then
  bat_name="BAT0"
  save_energy "BAT0"
fi

# if no battery found
if [[ $ac_state == true ]] && [[ -z $bat_state ]] ; then
  echo "AC Full 100"
elif [[ $ac_state == true ]] && [[ ! -z $bat_state ]] ; then
  #echo " AC connected, reload $bat_name $bat_state"
  echo "$bat_name $bat_status $bat_state"
elif [[ $ac_state == false ]] && [[ ! -z $bat_state ]] ; then
  #echo " AC disconnect, $bat_name $bat_state"
  echo "$bat_name $bat_status $bat_state"
else
  #echo "Sense never show this !! plz post an issue at https://github.com/szorfein/dotfiles"
  echo "XXX XXX 911"
  exit 1
fi

exit 0
