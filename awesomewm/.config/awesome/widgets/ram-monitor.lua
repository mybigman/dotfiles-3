local wibox = require("wibox")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- beautiful vars
local fg = beautiful.fg_grey

local ram_title = widget.create_title("Ram: ", fg)
local ram_title_align = widget.box('horizontal', { ram_title })
local ram = widget.make_arcchart()

local ram_widget = widget.box('vertical', { ram_title_align, ram })

awesome.connect_signal("daemon::ram", function(mem)
  ram.max_value = mem.total
  ram.values = { mem.inuse, mem.swp.inuse }
end)

return ram_widget
