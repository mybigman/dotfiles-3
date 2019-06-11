local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")

-- beautiful vars
local volume_icon = beautiful.widget_volume_icon
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local l = beautiful.widget_volume_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(bg, icon)
local text_margin = widget.text(bg, text)
volume_widget = widget.box(l, icon_margin, text_margin)

local function update_widget(volume)
  icon:set_markup_silently('<span foreground="'..fg..'">'..volume_icon..'</span>')
  text:set_markup_silently('<span foreground="'..fg..'">'..volume..'</span>')
end

-- Change 'Pro' with your audio card, to find audio card name: aplay -l
local volume_script = [[
    bash -c "amixer -c Pro | grep 'Front Left:' | awk '{print $4}'| tr -d '[]'"
  ]]

awful.widget.watch(
  volume_script, 4,
  function(widget, stdout, stderr, exitreason, exitcode)
    update_widget(stdout)
  end
)
