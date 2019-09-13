local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = require('beautiful').xresources.apply_dpi
local separators = require('util.separators')
local widget = require('util.widgets')

local primary_dark = beautiful.primary_dark
local fg_primary = beautiful.fg_primary_focus

-- widgets load
local tor = require("widgets.button_tor")
local scrot = require("widgets.scrot")
local pad = separators.pad

-- {{{ Redefine widgets with a background

local mpc = require("widgets.mpc")
local mpc_bg = beautiful.widget_mpc_bg
local my_mpc = mpc_widget

local volume = require("widgets.volume")
local volume_bg = beautiful.widget_volume_bg
local my_vol = volume_widget

local mail = require("widgets.mail")
local mail_bg = beautiful.widget_battery_bg
local my_mail = mail

local ram = require("widgets.ram")
local ram_bg = beautiful.widget_ram_bg
local my_ram = ram_widget

local battery = require("widgets.battery")
local bat_bg = beautiful.widget_battery_bg
local my_battery = battery_widget

local date = require("widgets.date")
local date_bg = beautiful.widget_date_bg
local my_date = date_widget

local my_menu = require("menu")
local launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = my_menu }
)

local network_monitor = require("widgets.network_monitor")
local my_network_monitor = network_monitor_widget

local change_theme = require("widgets.button_change_theme")

-- {{{ Define music block
local other_icon = widget.for_one_icon(fg_primary, primary_dark," ﲵ ","Iosevka Term 16")
local network_icon = widget.for_one_icon(fg_primary, primary_dark," 旅 ","Iosevka Term 16")
local other_block = wibox.widget {
  my_network_monitor,
  network_icon,
  my_mail,
  other_icon,
  my_ram,
  my_battery,
  my_date,
  spacing = dpi(9),
  --forced_width = dpi(200),
  layout = wibox.layout.fixed.horizontal
}
local other_block_margin = widget.border_bottom(other_block, primary_dark)

-- }}} End Define other block

-- {{{ Define music block
local music_icon = require("widgets.button_only_mpc")

-- Group multiple widgets
local music_block = wibox.widget {
  mpc_widget,
  volume_widget,
  music_icon,
  spacing = dpi(9),
  --forced_width = dpi(200),
  layout = wibox.layout.fixed.horizontal
}

-- Draw a border bottom line
local music_block_margin = widget.border_bottom(music_block, primary_dark)
--- }}} End Define music block

-- Remove space between taglist icon
local tagslist = require("taglists.battleship")
local my_tagslist = tagslist

-- widget redefined }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
  local instance = nil

  return function() 
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end
-- }}}

-- {{{ Wibar

-- Add the bar on each screen
awful.screen.connect_for_each_screen(function(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a tasklist widget for each screen
  s.mytasklist = require("widgets.tasklist")(s)

-- For look like a detached bar, we have to add a fake invisible bar...
s.useless_wibar = awful.wibar({ position = beautiful.wibar_position, screen = s, height = beautiful.screen_margin * 2, opacity = 0 })

-- Create the wibox with default options
s.mywibox = awful.wibar({ position = beautiful.wibar_position, height = beautiful.wibar_size, bg = beautiful.wibar_bg, width = dpi(1164) })

-- Add widgets to the wibox
s.mywibox:setup {
    { -- Left widgets
      { -- middle
        --tor_widget,
        --pad(1),
        --scrot_icon,
        layout = wibox.layout.fixed.horizontal
      },
      music_block_margin,
      change_theme,
      spacing = dpi(6),
      s.mytasklist,
      layout = wibox.layout.fixed.horizontal
    },
    my_tagslist,
    other_block_margin,
    expand = "none",
    layout = wibox.layout.align.horizontal
  }
end)
