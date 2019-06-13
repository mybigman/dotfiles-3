local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local net_icon = beautiful.widget_network_icon
local fg = beautiful.widget_network_fg
local fg_error = beautiful.widget_network_fg_error
local bg = beautiful.widget_network_bg
local l = beautiful.widget_network_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(icon)
local text_margin = widget.text(text)
network_widget = widget.box(l, icon_margin, text_margin)

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/network.sh net", 60,
  function(widget, stdout, stderr, exitreason, exitcode)
    local network = stdout:match('%w+%s?%d+[.]+%d+[.]+%d+[.]+%d+')
    if (stdout == "1") then
      icon.markup = helpers.colorize_text(net_icon, fg_error)
      text.markup = helpers.colorize_text("No network found", fg)
    else
      text.markup = helpers.colorize_text(network, fg)
    end
  end
)
