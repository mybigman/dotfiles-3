local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local icon_discharging = beautiful.widget_battery_icon_discharging
local icon_charging = beautiful.widget_battery_icon_charging
local icon_full = beautiful.widget_battery_icon_full
local icon_ac = beautiful.widget_battery_icon_ac
local fg = beautiful.widget_battery_fg
local bg_widget = beautiful.widget_battery_bg
local l = beautiful.widget_battery_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(icon)
local text_margin = widget.text(text)
battery_widget = widget.box(l, { icon_margin, text_margin })

local function update_widget(name, state, value)
  if (name == "AC") then
    icon.markup = helpers.colorize_text(icon_ac, fg)
  elseif (state == "Discharging") then
    icon.markup = helpers.colorize_text(icon_discharging, fg)
  elseif (state == "Charging") then
    icon.markup = helpers.colorize_text(icon_charging, fg)
  elseif (state == "Full") then
    icon.markup = helpers.colorize_text(icon_full, fg)
  end
  text.markup = helpers.colorize_text(value..'%', fg)
end

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/battery.sh", 10, 
  function(widget, stdout)
    local name, state, value = stdout:match('(%w+)%s?(%a*)%s?(%d+)')
    update_widget(name, state, value)
end)
