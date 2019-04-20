local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")

-- beautiful vars
local icon_discharging = beautiful.widget_battery_icon_discharging
local icon_charging = beautiful.widget_battery_icon_charging
local icon_full = beautiful.widget_battery_icon_full
local icon_ac = beautiful.widget_battery_icon_ac
local fg = beautiful.widget_battery_fg
local bg = beautiful.widget_battery_bg

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(bg, icon)
local text_margin = widget.text(bg, text)
battery_widget = widget.box(icon_margin, text_margin)

local function update_widget(state, value)
  if (state == "AC") then
    icon:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..icon_ac..'</span>')
  elseif (state == "Discharging") then
    icon:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..icon_discharging..'</span>')
  elseif (state == "Charging") then
    icon:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..icon_charging..'</span>')
  elseif (state == "Full") then
    icon:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..icon_full..'</span>')
  end
  text:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..value..'%</span>')
end

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/battery.sh", 10, 
  function(widget, stdout)
    local state, value = stdout:match('(%a*) (%d+)')
    update_widget(state, value)
end)
