local awful = require("awful")
local gtable = require("gears.table")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = require('beautiful').xresources.apply_dpi
local separators = require('util.separators')
local widget = require('util.widgets')

-- widgets load
local hostname = require("widgets.hostname")
local text_taglist = require("taglists.connected")
local scrot = require("widgets.scrot")
local pad = separators.pad
local arrow = separators.arrow_left

-- gradient colors (dark to light)
local g0 = beautiful.grey_dark
local g1 = beautiful.grey
local g2 = beautiful.primary_dark
local g3 = beautiful.secondary_dark

-- {{{ Add a background to the widgets
local tor = require("widgets.button_tor")
local my_tor = widget.bg( g1, tor )

local network = require("widgets.network")
local my_network = widget.bg( g2, network_widget )

local wifi_str = require("widgets.wifi_str")
local my_wifi_str = widget.bg( g3, wifi_str_widget )

local mpc = require("widgets.button_only_mpc")

local volume = require("widgets.volume")
local my_volume = widget.bg( g2, volume_widget )

local change_theme = require("widgets.button_change_theme")

local ram = require("widgets.ram")
local my_ram = widget.bg( g1, ram_widget )

local battery = require("widgets.battery")
local my_battery = widget.bg( g3, battery_widget )

local mail = require("widgets.mail")
local my_email = widget.bg( g2, mail )

local date = require("widgets.date")
local my_date = widget.bg( g1, date_widget )

local layoutbox = require("widgets.layout")
-- }}} End widget

-- {{{ Wibar

-- Add the bar on each screen
awful.screen.connect_for_each_screen(function(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = beautiful.wibar_position, width = beautiful.wibar_size, bg = beautiful.wibar_bg })

  -- Add widgets to the wibox
  s.mywibox:setup {
    { -- Left widgets
      text_taglist,
      layout = wibox.layout.fixed.vertical
    },
    { -- More or less Middle
      layout = wibox.layout.fixed.vertical  
    },
    { -- Right widgets
      mpc,
      change_theme,
      layoutbox,
      scrot,
      layout = wibox.layout.fixed.vertical
    },
    --expand = "none",
    layout = wibox.layout.align.vertical
  }
end)
