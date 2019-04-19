local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = require('beautiful').xresources.apply_dpi
local separators = require('util.separators')

-- widgets load
local hostname = require("widgets.hostname")
local tor = require("widgets.tor")
local text_taglist = require("widgets.mini_taglist")
local mail = require("widgets.mail")
local scrot = require("widgets.scrot")
local network = require("widgets.network")
local ram = require("widgets.ram")
local date = require("widgets.date")
local pad = separators.pad
local arrow = separators.arrow_left

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
      arrow(beautiful.xbackground, "#222222"),
      tor_widget,
      arrow("#222222", "#333333"),
      network_widget,
      arrow("#333333", beautiful.xbackground),
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Right widgets
      mykeyboardlayout,
      arrow(beautiful.xbackground, "#222222"),
      ram_widget,
      arrow("#222222", "#333333"),
      email_widget,
      arrow("#333333", "#222222"),
      date_widget,
      arrow("#222222", beautiful.xbackground),
      scrot_icon,
      wibox.widget.systray(),
      --s.mylayoutbox,
      layout = wibox.layout.fixed.horizontal,
    },
  }
end)
