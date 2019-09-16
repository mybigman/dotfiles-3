local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = require('beautiful').xresources.apply_dpi
local separators = require('util.separators')
local widget = require('util.widgets')

-- colors
local primary_dark = beautiful.primary_dark
local fg_primary = beautiful.fg_primary_focus

-- widgets load
--local hostname = require("widgets.hostname")
local tor = require("widgets.button_tor")
local scrot = require("widgets.scrot")
local scrot_circle = widget.circle(scrot, beautiful.grey, beautiful.primary)

--local network = require("widgets.network")
--local wifi_str = require("widgets.wifi_str")
local pad = separators.pad

-- {{{ Redefine widgets with a background

local mpc = require("widgets.button_only_mpc")

local mail = require("widgets.mail")
local mail_bg = beautiful.widget_battery_bg
local my_mail = widget.bg(mail_bg, mail)

local change_theme = require("widgets.button_change_theme")

--local ram = require("widgets.ram")
--local ram_bg = beautiful.widget_ram_bg
--local my_ram = ram_widget

--local battery = require("widgets.battery")
--local bat_bg = beautiful.widget_battery_bg
--local my_battery = battery_widget

--local date = require("widgets.date")
--local date_bg = beautiful.widget_date_bg
--local my_date = date_widget

local my_menu = require("menu")
local launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = my_menu }
)

--local network_monitor = require("widgets.network_monitor")
--local my_network_monitor = network_monitor_widget

-- {{{ Define music block
--local network_icon = widget.for_one_icon(fg_primary, primary_dark," 旅 ","Iosevka Term 16")

--  my_network_monitor,
--  network_icon,
--  my_mail,
--  my_ram,
--  my_battery,
--  my_date,
--  spacing = dpi(9),
-- }}} End Define other block

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
  s.mytaglist = require("widgets.taglist")(s, { mode = "shape", want_layout = "grid" })

-- Create the wibox with default options
s.mywibox = awful.wibar({ position = beautiful.wibar_position, height = beautiful.wibar_size, bg = beautiful.wibar_bg })

-- Add widgets to the wibox
s.mywibox:setup {
  {
    mpc,
    tor,
    my_mail,
    change_theme,
    layout = wibox.layout.fixed.horizontal
  },
  {
    {
      s.mytaglist,
      top = 2,
      bottom = 5,
      widget = wibox.container.margin
    },
    layout = wibox.layout.fixed.horizontal
  },
  {
    scrot_circle,
    layout = wibox.layout.fixed.horizontal
  },
  expand = "none",
  layout = wibox.layout.align.horizontal
}
end)
