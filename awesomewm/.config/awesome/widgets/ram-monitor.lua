local wibox = require("wibox")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- beautiful vars
local fg = beautiful.fg_grey

local ram_title = widget.create_title("Ram: ", fg)
local ram_title_align = widget.box('horizontal', { ram_title })
local ram = wibox.widget {
  thickness = dpi(3),
  start_angle = 4.71238898, -- 2pi*3/4
  forced_height = dpi(150),
  forced_width = dpi(150),
  bg = beautiful.primary,
  paddings = 4,
  colors = { beautiful.alert_light, beautiful.primary_light },
  border_color = beautiful.alert_dark,
  widget = wibox.container.arcchart,
  set_value = function(self, value)
    self.value = value
  end,
}

local ram_widget = widget.box('vertical', { ram_title_align, ram })

awesome.connect_signal("daemon::ram", function(mem)
  ram.max_value = mem.total
  ram.values = { mem.inuse, mem.swp.inuse }
end)

return ram_widget
