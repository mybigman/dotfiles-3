local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")

-- beautiful vars
local fg = beautiful.widget_wifi_str_fg
local bg = beautiful.widget_wifi_str_bg

-- widget creation
local text = widget.base_text(bg)
local text_margin = widget.text(bg, text)
volume_widget = widget.box(text_margin)

--local VOM_CMD = "amixer -c Pro | grep 'Front Left:' | cut -d ' ' -f 6"
--local VOM_CMD = "amixer -c Pro"
local volume_script = [[
    bash -c "amixer -c Pro | grep 'Front Left:'"
  ]]

awful.widget.watch(
  volume_script, 4,
  function(widget, stdout, stderr, exitreason, exitcode)
    local vol = stdout:match('%[(.*)%]')
    vol = string.gsub(status, '^%s*(.-)%s*$', '%1')
    --stdout = stdout.match('Front Left')
    text:set_markup_silently('<span foreground="'..fg..'" background="'..bg..'">'..vol..'</span>')
  end
)
