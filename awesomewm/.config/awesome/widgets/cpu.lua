local awidget = require("awful.widget")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")

local title = widget.create_title("CPU: ", beautiful.fg_grey)
local cpu = widget.base_text()
local cpu_widget = widget.box('horizontal', { title, cpu })

awesome.connect_signal("daemon::cpu", function(cpus)
  local cpu_list = table.concat(cpus, " ")
  cpu.markup = helpers.colorize_text(cpu_list, beautiful.fg_primary)
end)

return cpu_widget
