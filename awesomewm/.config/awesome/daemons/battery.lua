local awidget = require("awful.widget")
local helpers = require("helpers")
local beautiful = require("beautiful")

local function battery_info()
  local path_power="/sys/class/power_supply/"
  local bat = env.battery or "BAT0"
  local fpath = path_power..bat

  local battery_state = {
    ["Full\n"]        = { beautiful.widget_battery_icon_full, beautiful.fg_grey },
    ["Unknown\n"]     = { "unknown", beautiful.alert_light },
    ["Charged\n"]     = { beautiful.widget_battery_icon_charging, beautiful.primary_light },
    ["Charging\n"]    = { beautiful.widget_battery_icon_charging, beautiful.secondary_light },
    ["Discharging\n"] = { beautiful.widget_battery_icon_discharging, beautiful.alert }
  }

  -- if battery is present
  local bat_present = helpers.ret_content(fpath.."/present")
  if bat_present ~= "1\n" then
    return awesome.emit_signal("daemon::battery", battery_state["Unknown\n"], 0)
  end

  -- state information
  local battery_status = helpers.ret_content(fpath.."/status")
  local state = battery_state[battery_status] or battery_state["Unknown\n"]

  -- charge now
  local remaining, capacity, capacity_design
  local charge_now = helpers.ret_content(fpath.."/charge_now")
  if charge_now then 
    capacity = helpers.ret_content(fpath.."/charge_full")
    remaining = charge_now
    capacity_design = helpers.ret_content(fpath.."/energy_full_design") or capacity
  else
    return awesome.emit_signal("daemon::battery", battery_state["Unknown\n"], 0)
  end

  local percent = math.min(math.floor(remaining / capacity * 100), 100)

  awesome.emit_signal("daemon::battery", state, percent)
end

awidget.watch('sh -c ":"', 10, function(widget, stdout)
  battery_info()
end)
