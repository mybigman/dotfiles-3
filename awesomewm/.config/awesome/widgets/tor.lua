local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

local font_icon = beautiful.widget_icon_font or 'RobotoMono Nerd Font Mono 18'

local markup_icon = beautiful.widget_tor_text_icon or '<span foreground="#434e4a"> 﨩</span>'

tor_icon = wibox.widget {
  markup = markup_icon,
  widget = wibox.widget.textbox,
  font = font_icon,
}

function show_tor() 
  awful.spawn.easy_async( os.getenv("HOME").."/.config/awesome/widgets/tor.sh",
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
