local gtable = require("gears.table")
local abutton = require("awful.button")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")

local buttons = {}

function buttons.add_hover(w, text, color_up, color_down)
  w.markup = helpers.colorize_text(text, color_down)
  w:connect_signal("mouse::enter", function()
    w.markup = helpers.colorize_text(text, color_up)
  end)
  w:connect_signal("mouse::leave", function()
    w.markup = helpers.colorize_text(text, color_down)
  end)
end

function buttons.create(icon, color_up, color_down, cmd, fsize)
  local font = beautiful.myfont or "Iosevka Term"
  local font_size = fsize or "35"
  local w = widget.create_text(icon, color_down, font.." "..font_size)
  buttons.add_hover(w, icon, color_up, color_down)
  w:buttons(gtable.join(abutton({}, 1, function() cmd() end)))
  return w
end

return buttons
