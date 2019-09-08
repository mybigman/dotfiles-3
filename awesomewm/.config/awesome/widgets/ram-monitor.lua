local wibox = require("wibox")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

-- beautiful vars
local fg = beautiful.fg_grey

local ram_title = widget.create_title("Ram ", fg)
local ram_total = widget.base_text()
local ram = widget.make_arcchart()
local ram_widget = wibox.widget {
  {
    nil,
    {
      nil,
      ram_title,
      ram_total,
      layout = wibox.layout.fixed.vertical
    },
    nil,
    layout = wibox.layout.align.vertical
  },
  nil,
  ram,
  layout = wibox.layout.align.horizontal
}

awesome.connect_signal("daemon::ram", function(mem)
  ram.max_value = mem.total
  ram.values = { mem.inuse, mem.swp.inuse }
  ram_total.markup = helpers.colorize_text(tostring(mem.inuse_percent).."%", beautiful.fg_primary)
end)

return ram_widget
