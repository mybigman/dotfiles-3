local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local tor_icon = beautiful.widget_tor_icon
local fg_enable = beautiful.widget_tor_fg_enable
local fg_disable = beautiful.widget_tor_fg_disable
local bg = beautiful.widget_tor_bg
local l = beautiful.widget_tor_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local icon_margin = widget.icon(icon)
tor_widget = widget.box(l, icon_margin)

awful.widget.watch(
os.getenv("HOME").."/.config/awesome/widgets/tor.sh check", 60, -- 1m
function(widget, stdout, stderr, exitreason, exitcode)
  local code = tonumber(stdout) or 1
  if (code == 0) then
    icon.markup = helper.colorize_text(tor_icon, fg_enable)
  else
    icon.markup = helper.colorize_text(tor_icon, fg_disable)
  end
end)

function show_tor() 
  awful.spawn.easy_async( os.getenv("HOME").."/.config/awesome/widgets/tor.sh ip",
  function(stdout, stderr, reason, exitcode)
    naughty.notify {
      text = stdout,
      title = "Tor Details: ",
      timeout = 5,
      hover_timeout = 2,
      width = 250,
      height = 140,
      position = "top_left",
    }
  end
  )
end

tor_widget:connect_signal("mouse::enter", function() show_tor() end)
