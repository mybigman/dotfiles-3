local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")

-- widget for the popup
local mpc = require("widgets.mpc")
local volume_bar = require("widgets.volume-slider")

-- beautiful vars
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local l = beautiful.widget_volume_layout or 'horizontal'

-- widget creation
local text = widget.base_text()
local text_margin = widget.text(text)
local mpc_time_widget = widget.box(l, text_margin)

local function update_widget(volume)
  text.markup = helpers.colorize_text(volume, fg)
end

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/audio.sh music", 2,
  function(widget, stdout, stderr, exitreason, exitcode)
    local info = stdout:match('(%d+:%d+.%d+:%d+%s?%d+%%)') or 0
    update_widget(info)
  end
)

return mpc_time_widget
