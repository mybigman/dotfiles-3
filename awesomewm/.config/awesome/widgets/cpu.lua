local awidget = require("awful.widget")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local naughty = require("naughty")
local wibox = require("wibox")
local gshape = require("gears.shape")

local pbars = {} -- store all progressbars (one by cpu core)

local function make_progressbar() 
  return wibox.widget {
    max_value     = 100,
    value         = 10,
    forced_height = dpi(6),
    forced_width  = dpi(10),
    paddings      = 1,
    border_width  = 0,
    bar_shape     = gshape.rounded_bar,
    shape         = gshape.rounded_bar,
    background_color = beautiful.primary,
    color         = beautiful.alert,
    widget        = wibox.widget.progressbar
  }
end

local function make_all_progressbar(nb_cpu)
  for i = 1, nb_cpu do
    if pbars[i] == nil then
      pbars[i] = make_progressbar()
    end
  end
  return widget.box('vertical', pbars)
end

-- widgets creation
local title = widget.create_title("CPU: ", beautiful.fg_grey)
local cpu = widget.base_text()

local cpu_widget = widget.box('horizontal', { title, cpu })
local allpbars = make_all_progressbar(2) -- set your number of cpu here
local full_widget = widget.box('vertical', { cpu_widget, allpbars })

-- connect to daemon::cpu
awesome.connect_signal("daemon::cpu", function(cpus)
  cpu.markup = helpers.colorize_text(cpus[1].."%", beautiful.fg_primary)
  table.remove(cpus, 1) -- the first entry do not count as a core
  local nb_cpu = #cpus
  --naughty.notify({ text = tostring(nb_cpu) })
  for i = 1, nb_cpu do 
    pbars[i].value = tostring(cpus[i])
  end
end)

return full_widget
