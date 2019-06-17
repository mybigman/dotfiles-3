local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local volume_icon = beautiful.widget_volume_icon
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local l = beautiful.widget_volume_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(icon)
local text_margin = widget.text(text)
volume_widget = widget.box(l, icon_margin, text_margin)

local function update_widget(volume)
  icon.markup = helpers.colorize_text(volume_icon, fg)
  text.markup = helpers.colorize_text(volume, fg)
end

awful.widget.watch(
  -- you can change <Pro> with your card name if non detected
  os.getenv("HOME").."/.config/awesome/widgets/audio.sh volume Pro", 4,
  function(widget, stdout, stderr, exitreason, exitcode)
    local volume = stdout:match('%w+:%s?(%d+)')
    update_widget(volume.."%")
  end
)
