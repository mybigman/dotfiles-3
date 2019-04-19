local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")

-- beautiful vars
local date_icon = beautiful.widget_date_icon
local fg = beautiful.widget_date_fg
local bg = beautiful.widget_date_bg

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(bg, icon)
local text_margin = widget.text(bg, text)
date_widget = widget.box(icon_margin, text_margin)

local date_script = [[
  bash -c "
  date  +'%a %d %b'
  "]]

awful.widget.watch(date_script, 60, function(widget, stdout)
  icon:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..date_icon..'</span>')
  text:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..stdout..'</span>')
end)
