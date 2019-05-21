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
local tor = require("widgets.tor")
--local text_taglist = require("widgets.mini_taglist")
local scrot = require("widgets.scrot")
local network = require("widgets.network")
local wifi_str = require("widgets.wifi_str")
local pad = separators.pad
local tagslist = require("widgets.icon_taglist")

-- {{{ Redefine widgets with a background

local volume = require("widgets.volume")
local volume_bg = beautiful.widget_volume_bg
local my_vol = widget.bg_rounded( volume_bg, "#0000aa", volume_widget )

local mail = require("widgets.mail")
local mail_bg = beautiful.widget_battery_bg
local my_mail = widget.bg_rounded( mail_bg, "#00aa00", email_widget )

local ram = require("widgets.ram")
local ram_bg = beautiful.widget_ram_bg
local my_ram = widget.bg_rounded( ram_bg, "#008800", ram_widget )

local battery = require("widgets.battery")
local bat_bg = beautiful.widget_battery_bg
local my_battery = widget.bg_rounded( bat_bg, "#00ff00", battery_widget )

local date = require("widgets.date")
local date_bg = beautiful.widget_date_bg
local my_date = widget.bg_rounded( date_bg, "#8a0000", date_widget )

local my_menu = require("menu")
local launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = my_menu }
)
local my_launcher = widget.bg_rounded( "#6a6a6a", "#a2a2a2", launcher, "button" )

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
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    widget_template = {
      {
        {
          {
            {
              id     = 'icon_role',
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget  = wibox.container.margin,
          },
        {
          id     = 'text_role',
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      left  = 10,
      right = 10,
      top = 6,
      bottom = 6,
      widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background,
  },
}

-- For look like a detached bar, we have to add a fake invisible bar...
s.useless_wibar = awful.wibar({ position = beautiful.wibar_position, screen = s, height = beautiful.screen_margin * 2, opacity = 0 })

-- Create the wibox with default options
s.mywibox = awful.wibar({ height = beautiful.wibar_height, bg = beautiful.wibar_bg, width = 1000 })
--position = "top", bg = beautiful.wibar_bg, height = beautiful.wibar_height, screen = s, border_width = 1, height = beautiful.wibar_height, shape = helpers.rrect(beautiful.wibar_border_radius) })

-- Add widgets to the wibox
s.mywibox:setup {
  layout = wibox.layout.align.horizontal,
  spacing = dpi(9),
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      my_launcher,
      pad(1),
      tagslist,
      --s.mypromptbox,
      pad(3),
      spacing = 12,
      --distrib_icon,
      network_widget,
      --wifi_str_widget,
      wibox.widget.systray(),
      --s.mylayoutbox,
    },
    { -- middle
      layout = wibox.layout.fixed.horizontal,
      s.mytasklist
    },
    { -- right
      layout = wibox.layout.fixed.horizontal,
      tor_widget,
      pad(1),
      my_vol,
      pad(1),
      my_mail,
      pad(1),
      my_ram,
      pad(1),
      my_battery,
      pad(1),
      my_date,
      pad(1),
      scrot_icon,
    },
  }
end)
