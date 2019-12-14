local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local aspawn = require("awful.spawn")

-- beautiful vars
local icon = beautiful.widget_brightness_icon  or ""
local fg = beautiful.widget_brightness_fg or beautiful.fg_grey
local spacing = beautiful.widget_spacing or 1

-- root
local brightness_root = class()

function brightness_root:init(args)
  -- options
  self.mode = args.mode or 'text' -- possible values: text, progressbar, slider
  self.want_layout = args.layout or beautiful.widget_brightness_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 200
  -- base widgets
  self.wicon = widget.base_icon()
  self.wtext = widget.base_text()
  self.widget = self:make_widget()
end

function brightness_root:make_widget()
  if self.mode == "slider" then
    return self:make_slider()
  elseif self.mode == "progressbar" then
    return self:make_progressbar()
  else
    return self:make_text()
  end
end

function brightness_root:make_text()
  local w = widget.box_with_margin(self.want_layout, { self.wicon, self.wtext }, spacing)
  awesome.connect_signal("daemon::brightness", function(brightness)
    self.wicon.markup = helpers.colorize_text(icon, fg)
    self.wtext.markup = helpers.colorize_text(brightness, fg)
  end)
  return w
end

function brightness_root:make_slider()
  local slider = widget.make_a_slider(1)
  local w = widget.add_icon_to_slider(slider, icon, fg, self.want_layout)
  -- set level
  slider:connect_signal('property::value', function()
    aspawn.with_shell('light -S ' .. slider.value)
  end)
  -- get current level
  awesome.connect_signal("daemon::brightness", function(brightness)
    slider.minimum = 1
    slider:set_value(brightness)
  end)
  return w
end

function brightness_root:make_progressbar()
  local p = widget.make_progressbar(_, self.bar_size)
  local w = wibox.widget {
    p,
    top = 10,
    bottom = 10,
    layout = wibox.container.margin
  }
  awesome.connect_signal("daemon::brightness", function(brightness)
    self.wicon.markup = helpers.colorize_text(icon, fg)
    p.value = brightness
  end)
  return widget.box_with_margin(self.want_layout, { self.wicon, w }, 8)
end

-- herit
local brightness_widget = class(brightness_root)

function brightness_widget:init(args)
  brightness_root.init(self, args)
  return self.widget
end

return brightness_widget
