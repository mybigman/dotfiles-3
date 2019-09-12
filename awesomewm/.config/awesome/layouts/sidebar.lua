local wibox = require("wibox")
local awful = require("awful")
local gtable = require("gears.table")
local widget = require("util.widgets")
local separator = require("util.separators")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

-- beautiful var
local font = "sans 16"
local fg = "#ffffff"
local bg = "#651030"
local l = "horizontal"

local pad = separator.pad(3)

-- Setting titles
local settings_title = widget.create_title('Settings', beautiful.fg_grey)
local monitors_title = widget.create_title('Monitors', beautiful.fg_grey)

-- import widgets
local vol = require("widgets.volume-slider")
local brightness = require("widgets.brightness-slider")
local cpu = require("widgets.cpu-monitor")
local ram = require("widgets.ram-monitor")
local disks = require("widgets.disks-monitor")

-- add an exit button
local exit_icon = widget.for_one_icon(beautiful.fg_secondary, beautiful.alert_dark, "    LOGOUT    ", font)
local exit = widget.box(l, { exit_icon })
exit:buttons(gtable.join(
awful.button({ }, 1, function ()
  exit_screen_show()
  sidebar.visible = false
end)
))

-- sidebar creation TODO: adapt for each awesome theme
sidebar = wibox({ visible = false, ontop = true, type = "dock" })
sidebar.bg = beautiful.grey

local wibar_pos = beautiful.wibar_position or "top"
-- place the sidebar at the right position
if wibar_pos == "top" or wibar_pos == "bottom" then
  sidebar.height = awful.screen.focused().geometry.height - beautiful.wibar_size
  sidebar.x = 0 
  sidebar.y = beautiful.wibar_size
elseif wibar_pos == "left" or wibar_pos == "right" then
  sidebar.height = awful.screen.focused().geometry.height
  sidebar.x = beautiful.wibar_size
end

sidebar.width = dpi(250)
--awful.placement.left(sidebar)

local textclock = wibox.widget {
  format = '<span foreground="'..beautiful.fg_primary..'" font="22.5">%H:%M</span>',
  refresh = 60,
  timezone = "Europe/Paris",
  widget = wibox.widget.textclock,
  forced_height = dpi(88),
  forced_width = dpi(90)
}

-- a middle click to hide the sidebar
sidebar:buttons(gtable.join(
  awful.button({ }, 2, function() 
    sidebar.visible = false
  end)
))

-- setup
sidebar:setup {
  { -- top
    pad,
    textclock,
    pad,
    expand = "none",
    layout = wibox.layout.align.horizontal
  },
  { -- center
    widget.box('horizontal', { pad, monitors_title }), 
    {
      pad,
      cpu,
      pad,
      layout = wibox.layout.align.horizontal
    },
    {
      pad,
      ram,
      pad,
      layout = wibox.layout.align.horizontal
    },
    {
      pad,
      disks,
      pad,
      layout = wibox.layout.align.horizontal
    },
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
  },
  { -- bottom
    pad,
    widget.box('horizontal', { pad, settings_title }),
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
    pad,
    pad,
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
  layout = wibox.layout.align.vertical
}
