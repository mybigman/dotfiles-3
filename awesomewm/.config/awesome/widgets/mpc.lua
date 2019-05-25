local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")

-- beautiful vars
local icon_prev = beautiful.widget_mpc_prev_icon
local icon_pause = beautiful.widget_mpc_pause_icon
local icon_play = beautiful.widget_mpc_play_icon
local icon_stop = beautiful.widget_mpc_stop_icon
local icon_next = beautiful.widget_mpc_next_icon
local fg = beautiful.widget_mpc_fg
local bg = beautiful.widget_mpc_bg
local l = beautiful.widget_mpc_layout or 'horizontal'

-- widget creation
local icon_1 = widget.base_icon(bg, icon_prev)
local icon_2 = widget.base_icon(bg)
local icon_3 = widget.base_icon(bg, icon_next)
local icon_margin_1 = widget.icon(bg, icon_1)
local icon_margin_2 = widget.icon(bg, icon_2) 
local icon_margin_3 = widget.icon(bg, icon_3)
mpc_widget = widget.box(l, icon_margin_1, icon_margin_2, icon_margin_3)

local GET_MPD_CMD = "mpc status" 
local TOGGLE_MPD_CMD = "mpc toggle"
local NEXT_MPD_CMD = "mpc next"
local PREV_MPD_CMD = "mpc prev"

awful.widget.watch(GET_MPD_CMD, 3, function(widget, stdout, exitreason, exitcode)
  stdout = string.gsub(stdout, "\n", "")
  local status = stdout:match('%[(.*)%]')
  status = string.gsub(status, '^%s*(.-)%s*$', '%1')
  icon_1.markup = '<span foreground="'..fg..'">'..icon_prev..'</span>'
  if (status == "playing") then
    icon_2.markup = '<span foreground="'..fg..'">'..icon_pause..'</span>'
  elseif (status == "paused") then
    icon_2.markup = '<span foreground="'..fg..'">'..icon_play..'</span>'
  else
    icon_2.markup = '<span foreground="'..fg..'">'..icon_stop..'</span>'
  end
  icon_3.markup = '<span foreground="'..fg..'">'..icon_next..'</span>'
end)

icon_1:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then awful.spawn(PREV_MPD_CMD, false) end -- left click
end)

icon_2:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then awful.spawn(TOGGLE_MPD_CMD, false) end -- left click
end)

icon_3:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then awful.spawn(NEXT_MPD_CMD, false) end -- left click
end)
