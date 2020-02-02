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
  self.icon = args.icon or beautiful.widget_battery_icon or { "ba", beautiful.primary }
  self.mode = args.mode or 'text' -- possible values: text, progressbar, slider
  self.want_layout = args.layout or beautiful.widget_battery_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 200
  self.bar_colors = args.bar_colors or beautiful.bar_colors or { beautiful.primary, beautiful.alert }
  -- base widgets
  self.wicon = widget.base_icon(self.icon[1], self.icon[2])
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
  local p = widget.make_progressbar(_, self.bar_size, { self.bar_colors[1][1], self.bar_colors[2] })
  local w = widget.progressbar_layout(p, self.want_layout)
  local space = self.want_layout == "horizontal" and 8 or 2
  awesome.connect_signal("daemon::battery", function(state, percent)
    p.value = percent
  end)
  return widget.box_with_margin(self.want_layout, { self.wicon, w }, space)
end

-- herit
local battery_widget = class(battery_root)

function battery_widget:init(args)
  battery_root.init(self, args)
  return self.widget
end

return battery_widget
