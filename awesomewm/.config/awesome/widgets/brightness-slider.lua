local aspawn = require("awful.spawn")
local beautiful = require("beautiful")
local widget = require("util.widgets")

-- beautiful vars
local icon = beautiful.widget_brightness_icon or ""
local fg = beautiful.widget_brightness_fg or beautiful.fg_grey

-- widget creation
local slider = widget.make_a_slider(1)
local slider_widget = widget.add_icon_to_slider(slider, icon, fg, 'horizontal')

slider:connect_signal('property::value', function()
  aspawn.with_shell('light -S ' .. slider.value)
end)

-- get current level
awesome.connect_signal("daemon::brightness", function(brightness)
  slider:set_value(brightness)
end)

return slider_widget
