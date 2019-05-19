local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")

-- beautiful vars
local fg = beautiful.widget_wifi_str_fg
local bg = beautiful.widget_wifi_str_bg
local l = beautiful.widget_wifi_layout or 'horizontal'

-- widget creation
local text = widget.base_text(bg)
local text_margin = widget.text(bg, text)
wifi_str_widget = widget.box(l, text_margin)

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/network.sh wifi", 60,
  function(widget, stdout, stderr, exitreason, exitcode)
    local wifi_str = tonumber(stdout) or 0
    if (stdout == "1") then
      text:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'"></span>')
    else
      text:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..wifi_str..'%</span>')
    end
  end
)
