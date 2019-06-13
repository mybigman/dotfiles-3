local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local fg = beautiful.widget_wifi_str_fg
local bg = beautiful.widget_wifi_str_bg
local l = beautiful.widget_wifi_layout or 'horizontal'

-- widget creation
local text = widget.base_text()
local text_margin = widget.text(text)
wifi_str_widget = widget.box(l, text_margin)

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/network.sh wifi", 60,
  function(widget, stdout, stderr, exitreason, exitcode)
    local filter_wifi = stdout:match('%d+')
    local wifi_str = tonumber(filter_wifi) or 0
    if (wifi_str ~= "0") then
      text.markup = helpers.colorize_text(filter_wifi..'%', fg)
    end
  end
)
