local awful = require("awful")
local gtable = require("gears.table")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local separators = require('util.separators')
local widget = require('util.widgets')

-- widgets load
local text_taglist = require("taglists.connected")
local pad = separators.pad
local mpc = require("widgets.button_only_mpc")
local change_theme = require("widgets.button_change_theme")
local layoutbox = require("widgets.layout")
local scrot = require("widgets.scrot")

local sidebar_arrow = widget.create_button("#daeda1", " >")
sidebar_arrow:buttons(gtable.join(
  awful.button({}, 1, function()
    sidebar.visible = not sidebar.visible
  end)
))
-- }}} End widget

-- {{{ Wibar

-- Add the bar on each screen
awful.screen.connect_for_each_screen(function(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a tasklist widget for each screen
  s.mytasklist = require("widgets.tasklist")(s)

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = beautiful.wibar_position, height = beautiful.wibar_size, bg = beautiful.wibar_bg })
  s.mywibox_tags = awful.wibar({ position = beautiful.wibar_position, height = dpi(5), bg = beautiful.wibar_bg })

  -- Add widgets to the wibox
  s.mywibox:setup {
    { -- Left widgets
      wibox.container.rotate(sidebar_arrow, "west"),
      layout = wibox.layout.align.horizontal
    },
    s.mytasklist, -- More or less Middle
    { -- Right widgets
      mpc,
      change_theme,
      layoutbox,
      scrot,
      wibox.widget.textbox(" "),
      spacing = beautiful.widget_spacing,
      layout = wibox.layout.fixed.horizontal
    },
    expand ="none",
    layout = wibox.layout.align.horizontal
  }

  s.mywibox_tags:setup {
    nil,
    text_taglist,
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
  }
end)
