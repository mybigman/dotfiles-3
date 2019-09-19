local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local ram_icon = beautiful.widget_ram_icon
local fg = beautiful.widget_ram_fg
local bg = beautiful.widget_ram_bg
local l = beautiful.widget_ram_layout or 'horizontal'
local spacing = beautiful.widget_spacing or 1

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
ram_widget = widget.box_with_margin(l, { icon, text }, spacing)

-- connect to daemon::ram
awesome.connect_signal("daemon::ram", function(mem)
  icon.markup = helpers.colorize_text(ram_icon, fg)
  text.markup = helpers.colorize_text(mem.inuse_percent.."%", fg)
end)
