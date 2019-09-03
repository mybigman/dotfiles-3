local wibox = require("wibox")
local awful = require("awful")
local gtable = require("gears.table")
local gshape = require("gears.shape")
local widget = require("util.widgets")
local separator = require("util.separators")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")

-- beautiful var
local font = "sans 16"
local fg = "#ffffff"
local bg = "#651030"
local l = "horizontal"

local pad = separator.pad(2)

-- Settings title
local settings_title = widget.create_title('Settings', beautiful.fg_grey)

-- volume slider
local vol = require("widgets.volume-slider")

-- brightness slider
local brightness = require("widgets.brightness-slider")

-- add exit menu
local exit_icon = widget.for_one_icon(fg, bg, "    LOGOUT    ", font)
local exit = widget.box(l, { exit_icon })
exit:buttons(gtable.join(
awful.button({ }, 1, function ()
  exit_screen_show()
  sidebar.visible = false
end)
))

-- sidebar creation
sidebar = wibox({ visible = false, ontop = true, type = "dock" })
sidebar.bg = beautiful.grey
sidebar.width = dpi(250)
sidebar.height = awful.screen.focused().geometry.height
sidebar.x = beautiful.wibar_size
--awful.placement.left(sidebar)

-- a middle click to hide the sidebar
sidebar:buttons(gtable.join(
  awful.button({ }, 2, function() 
    sidebar.visible = false
  end)
))

-- setup
sidebar:setup {
  {
    layout = wibox.layout.fixed.vertical
  },
  { -- center
    { 
      align = "left",
      { 
        pad,
        settings_title,
        layout = wibox.layout.align.horizontal
      },
      layout = wibox.layout.align.horizontal
    },
    {
      {
        pad,
        vol,
        pad,
        layout = wibox.layout.align.horizontal
      },
      {
        pad,
        brightness,
        pad,
        layout = wibox.layout.align.horizontal
      },
      --expand = "none",
      layout = wibox.layout.align.vertical
    },
    layout = wibox.layout.fixed.vertical
  },
  { -- bottom
    {
      nil,
      exit,
      nil,
      layout = wibox.layout.align.horizontal,
      expand = "none"
    },
    pad,
    layout = wibox.layout.fixed.vertical
  },
  expand = "none",
  layout = wibox.layout.align.vertical
}
