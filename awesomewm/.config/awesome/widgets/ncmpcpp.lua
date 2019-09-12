local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gtable = require("gears.table")

local widget_font = beautiful.widget_ncmpcpp_font or 'RobotoMono Nerd Font Mono 25'
local widget_ncmpcpp_prev = beautiful.widget_ncmpcpp_prev or '<span foreground="#334932"> &lt; </span>'
local widget_ncmpcpp_toggle = beautiful.widget_ncmpcpp_toggle or '<span foreground="#334932">  </span>'
local widget_ncmpcpp_next = beautiful.widget_ncmpcpp_next or '<span foreground="#334932"> &gt; </span>'

local pad = wibox.widget.textbox(" ")

-- Prev
local ncmpcpp_prev_icon = wibox.widget {
  markup = widget_ncmpcpp_prev,
  widget = wibox.widget.textbox,
  font = widget_font,
}

ncmpcpp_prev_icon:buttons(gtable.join(
  awful.button({ }, 1, function ()
    awful.spawn.with_shell("mpc prev")
  end)
))

-- Toggle
local ncmpcpp_toggle_icon = wibox.widget {
  markup = widget_ncmpcpp_toggle,
  widget = wibox.widget.textbox,
  font = widget_font,
}

ncmpcpp_toggle_icon:buttons(gtable.join(
  awful.button({ }, 1, function ()
    awful.spawn.with_shell("mpc toggle")
  end)
))

-- Next
local ncmpcpp_next_icon = wibox.widget {
  markup = widget_ncmpcpp_next,
  widget = wibox.widget.textbox,
  font = widget_font,
}

ncmpcpp_next_icon:buttons(gtable.join(
  awful.button({ }, 1, function ()
    awful.spawn.with_shell("mpc next")
  end)
))

local ncmpcpp_widget = wibox.widget {
  nil,
  {
    nil,
    { -- music player
      ncmpcpp_prev_icon,
      pad,
      ncmpcpp_toggle_icon,
      pad,
      ncmpcpp_next_icon,
      layout  = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal
} 

return ncmpcpp_widget
