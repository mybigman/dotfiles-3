local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = require('beautiful').xresources.apply_dpi

local pad = helpers.pad

-- widgets load
local hostname = require("widgets.hostname")
local tor = require("widgets.tor")
local text_taglist = require("widgets.text_taglist")
local mail = require("widgets.mail")
local scrot = require("widgets.scrot")

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
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

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
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ height = dpi(30) })
  --position = "top", bg = beautiful.wibar_bg, height = beautiful.wibar_height, screen = s, border_width = 1, height = beautiful.wibar_height, shape = helpers.rrect(beautiful.wibar_border_radius) })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      --mylauncher,
      s.mypromptbox,
      distrib_icon,
      tor_icon,
    },
    text_taglist, -- Middle widget
    --s.mytaglist,
    { -- Right widgets
      --mykeyboardlayout,
      email_icon,
      pad(2),
      email_text,
      pad(1),
      scrot_icon,
      wibox.widget.systray(),
      --mytextclock,
      --s.mylayoutbox,
      layout = wibox.layout.fixed.horizontal,
    },
  }
end)
