local wibox = require("wibox")
local awful = require("awful")
local shape = require("gears.shape")
local beautiful = require("beautiful")

-- Colors
local primary = beautiful.primary or '#ff66ff'
local secondary = beautiful.grey_light or '#6f6fff'

local bar = wibox.widget {
  max_value = 100,
  value = 0,
  forced_height = 3,
  forced_width = 100,
  shape = shape.rounded_bar,
  color = primary,
  background_color = secondary,
  widget = wibox.widget.progressbar
}

awesome.connect_signal("daemon::volume", function(volume, is_muted)
  bar.value = volume
end)

return bar
