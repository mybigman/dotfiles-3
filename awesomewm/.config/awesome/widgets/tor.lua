local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local widget = require("util.widgets")

-- beautiful vars
local tor_icon = beautiful.widget_tor_icon
local fg_enable = beautiful.widget_tor_fg_enable
local fg_disable = beautiful.widget_tor_fg_disable
local bg = beautiful.widget_tor_bg
local l = beautiful.widget_tor_layout or 'horizontal'

-- local str
local tor_text_enable_icon = '<span foreground="'..fg_enable..'">'..tor_icon..'</span>'
local tor_text_disable_icon = '<span foreground="'..fg_disable..'">'..tor_icon..'</span>'

-- widget creation
local icon = widget.base_icon(bg, tor_icon)
local icon_margin = widget.icon(bg, icon)
tor_widget = widget.box(l, icon_margin)

awful.widget.watch(
os.getenv("HOME").."/.config/awesome/widgets/tor.sh check", 60, -- 1m
function(widget, stdout, stderr, exitreason, exitcode)
  local code = tonumber(stdout) or 1
  if (code == 0) then
    icon:set_markup_silently(tor_text_enable_icon)
  else
    icon:set_markup_silently(tor_text_disable_icon)
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
