local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local fg = beautiful.widget_battery_fg
local spacing = beautiful.widget_spacing or 1

-- root
local battery_root = class()

function battery_root:init(args)
  -- options
  self.mode = args.mode or 'text' -- possible values: text, progressbar, slider
  self.want_layout = args.layout or beautiful.widget_battery_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 200
  -- base widgets
  self.wicon = widget.base_icon()
  self.wtext = widget.base_text()
  self.widget = self:make_widget()
end

function battery_root:make_widget()
  if self.mode == "progressbar" then
    return self:make_progressbar()
  else
    return self:make_text()
  end
end

function battery_root:make_text()
  local w = widget.box_with_margin(self.want_layout, { self.wicon, self.wtext }, spacing)
  awesome.connect_signal("daemon::battery", function(state, percent)
    self.wicon.markup = helpers.colorize_text(state[1], state[2])
    self.wtext.markup = helpers.colorize_text(percent..'%', fg)
  end)
  return w
end

function battery_root:make_progressbar()
  local p = widget.make_progressbar(_, self.bar_size)
  local w = wibox.widget {
    p,
    top = 10,
    bottom = 10,
    layout = wibox.container.margin
  }
  awesome.connect_signal("daemon::battery", function(state, percent)
    self.wicon.markup = helpers.colorize_text(state[1], state[2])
    p.value = percent
  end)
  return widget.box_with_margin(self.want_layout, { self.wicon, w }, 8)
end

-- herit
local battery_widget = class(battery_root)

function battery_widget:init(args)
  battery_root.init(self, args)
  return self.widget
end

return battery_widget
