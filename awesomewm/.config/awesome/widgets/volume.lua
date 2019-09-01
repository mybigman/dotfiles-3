local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local volume_icon = beautiful.widget_volume_icon
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local fg_err = beautiful.fg_alert or '#882233'
local l = beautiful.widget_volume_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(icon)
local text_margin = widget.text(text)
volume_widget = widget.box(l, { icon_margin, text_margin })

local function print_volume(volume, fg)
  icon.markup = helpers.colorize_text(volume_icon, fg)
  text.markup = helpers.colorize_text(volume..'%', fg)
end

awesome.connect_signal("daemon::volume", function(volume, is_muted)
  if is_muted then
    print_volume(volume, fg_err)
  else
    print_volume(volume, fg)
  end
end)
