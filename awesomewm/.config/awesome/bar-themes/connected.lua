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
local text_taglist = require("widgets.mini_taglist")
local scrot = require("widgets.scrot")
local mpc = require("widgets.mpc")
local pad = separators.pad
local arrow = separators.arrow_left

-- {{{ Redefine widgets with a background

local tor = require("widgets.button_tor")
local tor_bg = beautiful.widget_tor_bg
local my_tor = widget.bg( tor_bg, tor )

local network = require("widgets.network")
local network_bg = beautiful.widget_network_bg
local my_network = widget.bg( network_bg, network_widget )

local wifi_str = require("widgets.wifi_str")
local wifi_bg = beautiful.widget_wifi_str_bg
local my_wifi_str = widget.bg( wifi_bg, wifi_str_widget )

local volume = require("widgets.volume")
local volume_bg = beautiful.widget_volume_bg
local my_volume = widget.bg( volume_bg, volume_widget )

local ram = require("widgets.ram")
local ram_bg = beautiful.widget_ram_bg
local my_ram = widget.bg( ram_bg, ram_widget )

local battery = require("widgets.battery")
local battery_bg = beautiful.widget_battery_bg
local my_battery = widget.bg( battery_bg, battery_widget )

local mail = require("widgets.mail")
local email_bg = beautiful.widget_email_bg
local my_email = widget.bg( email_bg, email_widget )

local date = require("widgets.date")
local date_bg = beautiful.widget_date_bg
local my_date = widget.bg( date_bg, date_widget )

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
  --position = "top", bg = beautiful.wibar_bg, height = beautiful.wibar_height, screen = s, border_width = 1, height = beautiful.wibar_height, shape = helpers.rrect(beautiful.wibar_border_radius) })

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
      arrow(beautiful.xbackground, "#202724"),
      my_tor,
      arrow("#202724", "#29322e"),
      my_network,
      arrow("#29322e", "#202724"),
      my_wifi_str,
      arrow("#202724", beautiful.xbackground),
      layout = wibox.layout.fixed.horizontal,
      pad(32),
      arrow(beautiful.xbackground, "#29322e"),
      mpc_widget,
      arrow("#29322e", "#202724"),
      my_volume,
      arrow("#202724", beautiful.xbackground),
    },
    { -- Right widgets
      mykeyboardlayout,
      arrow(beautiful.xbackground, "#202724"),
      my_ram,
      arrow("#202724", "#29322e"),
      my_battery,
      arrow("#29322e", "#323d38"),
      my_email,
      arrow("#323d38", "#202724"),
      my_date,
      arrow("#202724", beautiful.xbackground),
      scrot,
      wibox.widget.systray(),
      --s.mylayoutbox,
      layout = wibox.layout.fixed.horizontal,
    },
  }
end)
