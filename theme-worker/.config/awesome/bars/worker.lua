local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local separators = require('util.separators')
local widget = require('util.widgets')

-- widgets load
local pad = separators.pad
local desktop_ctrl = require("widgets.desktop-control")
local music = require("widgets.music-player")({ mode = "song" })
local layouts = require("widgets.layouts")({ mode = "menu" })
local textclock = wibox.widget {
  format = '<span foreground="'..beautiful.fg_grey..'">%H:%M</span>',
  widget = wibox.widget.textclock
}

-- init tables
local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a tasklist widget for each screen
  --s.mytasklist = require("widgets.tasklist")(s)

  -- Create a taglist widget for each screen
  s.mytaglist = require("widgets.taglist")(s, { mode = "icon" })

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = beautiful.wibar_position, height = beautiful.wibar_size, bg = beautiful.wibar_bg, screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    --widget.box('horizontal', { pad(2), layouts, s.mytasklist }), -- left
    widget.box('horizontal', { pad(2), music }), -- left
    { -- middle
      s.mytaglist,
      layout = wibox.layout.fixed.horizontal
    },
    { -- right
      widget.box('horizontal', { layouts, desktop_ctrl, textclock }, 20),
      pad(2),
      layout = wibox.layout.fixed.horizontal
    },
    expand ="none",
    layout = wibox.layout.align.horizontal
  }
end

return mybar
