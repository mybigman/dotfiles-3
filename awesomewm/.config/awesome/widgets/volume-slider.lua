local aspawn = require("awful.spawn")
local beautiful = require("beautiful")
local widget = require("util.widgets")

-- beautiful vars
local fg = beautiful.widget_volume_fg or beautiful.fg_grey

-- widget creation
local volume = widget.make_a_slider(15)
local vol = widget.add_icon_to_slider(volume, beautiful.widget_volume_icon, fg, 'horizontal')

-- signal 
volume:connect_signal('property::value', function()
  aspawn.with_shell('pactl set-sink-mute @DEFAULT_SINK@ false ; pactl set-sink-volume @DEFAULT_SINK@ ' .. volume.value .. '%')
end)

-- get volume
awesome.connect_signal("daemon::volume", function(vol, is_muted)
  volume:set_value(vol)
end)

return vol
