local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local date_icon = beautiful.widget_date_icon
local fg = beautiful.widget_date_fg
local bg = beautiful.widget_date_bg
local l = beautiful.widget_date_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(icon)
local text_margin = widget.text(text)
date_widget = widget.box(l, icon_margin, text_margin)

local date_script = [[
  bash -c "
  date  +'%a %d %b'
  "]]

awful.widget.watch(date_script, 60, function(widget, stdout)
  local date = stdout:match('%a+%s?%d+%s?%a+')
  icon.markup = helpers.colorize_text(date_icon, fg)
  text.markup = helpers.colorize_text(date, fg)
end)
