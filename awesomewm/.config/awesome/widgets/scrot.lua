local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")

local font_icon = beautiful.widget_icon_font or 'RobotoMono Nerd Font Mono 18'
local markup_icon = beautiful.widget_scrot_text_icon or '<span foreground="#4c534d">  </span>'

scrot_icon = wibox.widget {
  markup = markup_icon,
  --align = 'left',
  --valign = 'top',
  widget = wibox.widget.textbox,
  font = font_icon
}

function take_scrot() 
  awful.spawn.easy_async("scrot -d 3 -q 100", 
  function() 
    naughty.notify{
      text = "SHOT!",
      title = "Taking screenshot in 3 sec...",
      timeout = 2,
      position = "top_right",
    }
  end
  )
end

scrot_icon:buttons(gears.table.join(
  -- Left click - Take screenshot
  awful.button({ }, 1, function ()
    take_scrot() 
  end)
))
