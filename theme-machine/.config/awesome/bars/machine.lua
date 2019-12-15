local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local separators = require('util.separators')
local widget = require('util.widgets')

-- widgets load
local pad = separators.pad
local mpc = require("widgets.music-player")({})
local change_theme = require("widgets.button_change_theme")
local desktop_ctrl = require("widgets.desktop-control")
local scrot = require("widgets.scrot")
local layouts = require("widgets.layouts")

-- {{{ Wibar

local mybar = class()

-- Add the bar on each screen
function mybar:init(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a taglist for each screen
  s.mytaglist = require("widgets.taglist")(s, { mode = "text", want_layout = "vertical" })

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = beautiful.wibar_position, width = beautiful.wibar_size, bg = beautiful.wibar_bg, screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    { -- Left widgets
      layouts,
      layout = wibox.layout.fixed.vertical
    },
    { -- More or less Middle
      s.mytaglist,
      layout = wibox.layout.fixed.vertical  
    },
    { -- Right widgets
      mpc,
      widget.add_margin(change_theme, { left = 13 }),
      widget.add_margin(desktop_ctrl, { left = 13 }),
      scrot,
      spacing = beautiful.widget_spacing,
      layout = wibox.layout.fixed.vertical,
    },
    expand ="none",
    layout = wibox.layout.align.vertical
  }
end

return mybar
