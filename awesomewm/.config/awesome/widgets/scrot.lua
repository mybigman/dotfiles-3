local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gtable = require("gears.table")
local widget = require('util.widgets')

-- beautiful vars
local fg = beautiful.widget_scrot_fg or '#c0ffee'
local icon = beautiful.widget_scrot_icon or '  '

-- widget creation
local scrot_icon = widget.create_button( fg , icon )

function take_scrot() 
  naughty.notify{
    title = "Taking screenshot in 3 sec...",
    timeout = 2
  }
  awful.spawn.with_shell("scrot -d 3 -q 100")
end

scrot_icon:buttons(gtable.join(
  -- Left click - Take screenshot
  awful.button({ }, 1, function()
    take_scrot() 
  end)
))

return scrot_icon
