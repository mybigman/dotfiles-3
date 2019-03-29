local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local widget_font = beautiful.widget_ncmpcpp_font or 'RobotoMono Nerd Font Mono 25'
local widget_ncmpcpp_prev = beautiful.widget_ncmpcpp_prev or '<span foreground="#334932"> &lt; </span>'
local widget_ncmpcpp_toggle = beautiful.widget_ncmpcpp_toggle or '<span foreground="#334932">  </span>'
local widget_ncmpcpp_next = beautiful.widget_ncmpcpp_next or '<span foreground="#334932"> &gt; </span>'

-- Prev
ncmpcpp_prev_icon = wibox.widget {
  markup = widget_ncmpcpp_prev,
  widget = wibox.widget.textbox,
  font = widget_font,
}

ncmpcpp_prev_icon:buttons(gears.table.join(
  awful.button({ }, 1, function ()
    awful.spawn.with_shell("mpc prev")
  end)
))

-- Toggle
ncmpcpp_toggle_icon = wibox.widget {
  markup = widget_ncmpcpp_toggle,
  widget = wibox.widget.textbox,
  font = widget_font,
}

ncmpcpp_toggle_icon:buttons(gears.table.join(
  awful.button({ }, 1, function ()
    awful.spawn.with_shell("mpc toggle")
  end)
))

-- Next
ncmpcpp_next_icon = wibox.widget {
  markup = widget_ncmpcpp_next,
  widget = wibox.widget.textbox,
  font = widget_font,
}

ncmpcpp_next_icon:buttons(gears.table.join(
  awful.button({ }, 1, function ()
    awful.spawn.with_shell("mpc next")
  end)
))
