local aspawn = require("awful.spawn")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local naughty = require("naughty")

-- beautiful vars
local icon_prev = beautiful.widget_mpc_prev_icon
local icon_pause = beautiful.widget_mpc_pause_icon
local icon_play = beautiful.widget_mpc_play_icon
local icon_stop = beautiful.widget_mpc_stop_icon
local icon_next = beautiful.widget_mpc_next_icon
local fg = beautiful.widget_mpc_fg
local bg = beautiful.widget_mpc_bg
local l = beautiful.widget_mpc_layout or 'horizontal'
local spacing = beautiful.widget_spacing

-- widget creation
local icon_1 = widget.base_icon()
local icon_2 = widget.base_icon()
local icon_3 = widget.base_icon()
local mpc_widget = widget.box_with_margin(l, { icon, icon, icon }, spacing)

local status
local GET_MPD_CMD = "mpc status" 
local TOGGLE_MPD_CMD = "mpc toggle"
local NEXT_MPD_CMD = "mpc next"
local PREV_MPD_CMD = "mpc prev"

awesome.connect_signal("daemon::mpd", function(mpd)
  icon_1.markup = helpers.colorize_text(icon_prev, fg)
  if (mpd.status == "playing") then
    icon_2.markup = helpers.colorize_text(icon_pause, fg)
  elseif (mpd.status == "paused") then
    icon_2.markup = helpers.colorize_text(icon_play, fg)
  elseif (mpd.status == "void") then
    icon_2.markup = helpers.colorize_text(icon_play, fg)
  else
    icon_2.markup = helpers.colorize_text(icon_stop, fg)
  end
  icon_3.markup = helpers.colorize_text(icon_next, fg)
end)

local function show_mpc_warning()
  naughty.notify{
    icon_size=100,
    title = "No playlist",
    text = "Mpc has no playlist to read",
    timeout = 5, hover_timeout = 0.5,
    position = "bottom_right",
    bg = "#F06060",
    fg = "#EEE9EF",
    width = 300,
  }
end

icon_1:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then 
    if status == 'void' then
      show_mpc_warning()
    else
      aspawn(PREV_MPD_CMD, false) 
    end
  end -- left click
end)

icon_2:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then 
    if status == 'void' then
      show_mpc_warning()
    else
      aspawn(TOGGLE_MPD_CMD, false) 
    end
  end -- left click
end)

icon_3:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then 
    if status == 'void' then
      show_mpc_warning()
    else
      aspawn(NEXT_MPD_CMD, false) 
    end
  end -- left click
end)

return mpc_widget
