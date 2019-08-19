local awful = require("awful")
local gears = require("gears")
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

local mpc = require("widgets.mpc")
local my_mpc_widget = widget.bg( g1, mpc )

local volume = require("widgets.volume")
local my_volume = widget.bg( g2, volume_widget )

local change_theme = require("widgets.button_change_theme")
local my_change_theme = widget.bg( g1, change_theme )

local ram = require("widgets.ram")
local my_ram = widget.bg( g1, ram_widget )

local battery = require("widgets.battery")
local my_battery = widget.bg( g3, battery_widget )

local mail = require("widgets.mail")
local my_email = widget.bg( g2, mail )

local date = require("widgets.date")
local my_date = widget.bg( g1, date_widget )

-- }}} End widget

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

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, client_menu_toggle_fn()),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end))

-- Add the bar on each screen
awful.screen.connect_for_each_screen(function(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function () awful.layout.inc( 1) end),
    awful.button({}, 3, function () awful.layout.inc(-1) end),
    awful.button({}, 4, function () awful.layout.inc( 1) end),
    awful.button({}, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a tasklist widget
  --s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = top, height = beautiful.wibar_height, bg = beautiful.wibar_bg })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      --mylauncher,
      s.mypromptbox,
      distrib_icon,
      text_taglist,
    },
    { -- More or less Middle
      pad(5),
      arrow(g0, g1),
      my_tor,
      arrow(g1, g2),
      my_network,
      arrow(g2, g3),
      my_wifi_str,
      arrow(g3, g0),
      layout = wibox.layout.fixed.horizontal,
      pad(32),
      arrow(g0, g1),
      my_mpc_widget,
      arrow(g1, g2),
      my_volume,
      arrow(g2, g1),
      my_change_theme,
      arrow(g1, g0)
    },
    { -- Right widgets
      mykeyboardlayout,
      arrow(g0, g1),
      my_ram,
      arrow(g1, g3),
      my_battery,
      arrow(g3, g2),
      my_email,
      arrow(g2, g1),
      my_date,
      arrow(g1, g0),
      scrot,
      wibox.widget.systray(),
      --s.mylayoutbox,
      layout = wibox.layout.fixed.horizontal,
    },
  }
end)
