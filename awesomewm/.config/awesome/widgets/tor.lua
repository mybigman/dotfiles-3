local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

local font_icon = beautiful.widget_icon_font or 'RobotoMono Nerd Font Mono 18'
local tor_text_enable_icon = beautiful.widget_tor_text_enable_icon or '<span foreground="#434e4a"> 﨩</span>'
local tor_text_disable_icon = beautiful.widget_tor_text_disable_icon or '<span foreground="#aa4e4a"> 﨩</span>'

tor_icon = wibox.widget {
  widget = wibox.widget.textbox,
  font = font_icon,
}

awful.widget.watch(
os.getenv("HOME").."/.config/awesome/widgets/tor.sh check", 60, -- 1m
function(widget, stdout, stderr, exitreason, exitcode)
  local code = tonumber(stdout) or 1
  if (code == 0) then
    tor_icon:set_markup_silently (tor_text_enable_icon)
  else
    tor_icon:set_markup_silently (tor_text_disable_icon)
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

tor_icon:connect_signal("mouse::enter", function() show_tor() end)
