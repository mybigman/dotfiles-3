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
local vol = require("widgets.volume")({ mode = "slider" })
local brightness = require("widgets.brightness")({ mode = "slider" })
local cpu = require("widgets.cpu")({ mode = "arcchart" })
local ram = require("widgets.ram")({ mode = "arcchart" })
local disks = require("widgets.disks")({ mode = "arcchart" })

local mybar = class()

function mybar:init(s)

  s.monitor_bar = awful.wibar({ stretch = false, visible = false, type = "dock", screen = s })
  s.monitor_bar.bg = beautiful.grey

  -- add an exit button
  local exit_icon = widget.for_one_icon(beautiful.fg_secondary, beautiful.alert_dark, "    LOGOUT    ", font)
  local exit = widget.box(l, { exit_icon })
  exit:buttons(gtable.join(
  awful.button({ }, 1, function ()
    exit_screen_show()
    s.monitor_bar.visible = false
  end)
  ))

  local wibar_pos = beautiful.wibar_position or "top"
  -- place the sidebar at the right position
  if wibar_pos == "left" then
    s.monitor_bar.x = beautiful.wibar_size
    s.monitor_bar.y = 0
    s.monitor_bar.position = "left"
  elseif wibar_pos == "right" then
    s.monitor_bar.position = "right"
  end

  s.monitor_bar.height = awful.screen.focused().geometry.height
  s.monitor_bar.width = dpi(230)

  local textclock = wibox.widget {
    format = '<span foreground="'..beautiful.fg_primary..'" font="22.5">%H:%M</span>',
    refresh = 60,
    widget = wibox.widget.textclock,
    forced_height = dpi(88),
    forced_width = dpi(90)
  }

  -- a middle click to hide the sidebar
  s.monitor_bar:buttons(gtable.join(
    awful.button({ }, 2, function() 
      s.monitor_bar.visible = false
    end)
  ))

  -- setup
  s.monitor_bar:setup {
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
end

return mybar
