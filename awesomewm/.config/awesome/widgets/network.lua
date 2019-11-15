local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local env = require("env-config")

-- beautiful vars
local net_icon = beautiful.widget_network_icon
local up_icon = "ﲗ"
local down_icon = "ﲐ"
local fg = beautiful.widget_network_fg
local spacing = beautiful.widget_spacing or 1

local function new(self, ...)
  local instance = setmetatable({}, { __index = self })
  return instance:init(...) or instance
end

local function class(base)
  return setmetatable({ new = new }, { __call = new, __index = base })
end

-- root
local network_root = class()

function network_root:init(args)
  -- options
  self.mode = args.mode or 'text' -- possible values: ip, text
  self.want_layout = args.layout or beautiful.widget_network_layout or 'horizontal' -- possible values: horizontal , vertical
  -- base widgets
  self.wicon_up = widget.base_icon(up_icon, beautiful.secondary)
  self.wicon_down = widget.base_icon(down_icon, beautiful.primary)
  self.wicon_net = widget.base_icon(net_icon, beautiful.alert)
  self.wtext_1 = widget.base_text()
  self.wtext_2 = widget.base_text()
  self.widget = self:make_widget()
end

function network_root:make_widget()
  if self.mode == "ip" then
    return self:make_ip()
  elseif self.mode == "block" then
    return self:make_block()
  else
    return self:make_text()
  end
end

function network_root:make_ip()
  local w = widget.box_with_margin(self.want_layout, { self.wicon_net, self.wtext_1 }, spacing)
  awesome.connect_signal("daemon::network", function(net)
    self.wtext_1.markup = helpers.colorize_text(net[env.net_device].name.." "..net[env.net_device].ip, fg)
  end)
  return w
end

function network_root:make_text()
  local w = widget.box_with_margin(self.want_layout, { self.wicon_up, self.wtext_1, self.wicon_down, self.wtext_2 }, spacing)
  awesome.connect_signal("daemon::network", function(net)
    self.wtext_1.markup = helpers.colorize_text(net[env.net_device].up, fg)
    self.wtext_2.markup = helpers.colorize_text(net[env.net_device].down, fg)
  end)
  return w
end

function network_root:make_block()
  local ip = widget.base_text()
  local rx = widget.base_text()
  local tx = widget.base_text()
  local w = wibox.widget {
    widget.box("horizontal", { self.wicon_net, ip }, 8),
    widget.box("horizontal", { self.wicon_up, self.wtext_1, tx }, 8), -- upload
    widget.box("horizontal", { self.wicon_down, self.wtext_2, rx }, 8), -- download
    spacing = -2,
    layout = wibox.layout.fixed.vertical
  }
  awesome.connect_signal("daemon::network", function(net)
    ip.markup = helpers.colorize_text(net[env.net_device].ip, fg)
    tx.markup = helpers.colorize_text(net[env.net_device].tx, fg)
    rx.markup = helpers.colorize_text(net[env.net_device].rx, fg)
    self.wtext_1.markup = helpers.colorize_text(net[env.net_device].up.." B/s", fg)
    self.wtext_2.markup = helpers.colorize_text(net[env.net_device].down.." B/s", fg)
  end)
  return w
end

-- TODO change this with a graph?
function network_root:make_progressbar()
  local p = widget.make_progressbar(_, 200)
  local w = wibox.widget {
    p,
    top = 10,
    bottom = 10,
    layout = wibox.container.margin
  }
  awesome.connect_signal("daemon::network", function(net)
    p.value = vol
  end)
  return widget.box_with_margin(self.want_layout, { self.wicon_net, w }, spacing)
end

-- herit
local network_widget = class(network_root)

function network_widget:init(args)
  network_root.init(self, args)
  return self.widget
end

return network_widget
