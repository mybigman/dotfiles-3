local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")

-- beautiful vars
local fg = beautiful.widget_network_fg
local spacing = beautiful.widget_spacing or 1

-- root
local network_root = class()

function network_root:init(args)
  -- options
  self.icon_up = args.icon_up or beautiful.widget_network_icon_up or { "ﲗ", beautiful.primary }
  self.icon_down = args.icon_down or beautiful.widget_network_icon_down or { "ﲐ", beautiful.primary }
  self.icon_ip = args.icon_ip or beautiful.widget_network_icon_ip or { "", beautiful.fg_grey }
  self.mode = args.mode or 'text' -- possible values: ip, text
  self.want_layout = args.layout or beautiful.widget_network_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 100
  self.bar_colors = args.bar_colors or beautiful.bar_colors or { beautiful.primary, beautiful.alert }
  -- base widgets
  self.wicon_up = widget.base_icon(self.icon_up[1], self.icon_up[2])
  self.wicon_down = widget.base_icon(self.icon_down[1], self.icon_down[2])
  self.wicon_net = widget.base_icon(self.icon_ip[1], self.icon_ip[2])
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
  local pu = widget.make_progressbar(_, self.bar_size, { self.bar_colors[1][1], self.bar_colors[2] })
  pu.max_value = 80000
  local pd = widget.make_progressbar(_, self.bar_size, { self.bar_colors[1][2], self.bar_colors[2] })
  pd.max_value = 80000
  local w
  local ip = widget.base_text()
  if self.want_layout == 'horizontal' then
    pu.forced_height = 1
    pd.forced_height = 1
    local rx = widget.base_text()
    local tx = widget.base_text()
    local m1 = widget.add_margin(pu, { top = 4, bottom = 4 }) -- margin
    local m2 = widget.add_margin(pd, { top = 4, bottom = 4 }) -- margin
    w = wibox.widget {
      widget.box("horizontal", { self.wicon_net, ip }, 8),
      widget.box("horizontal", { self.wicon_up, m1, self.wtext_1 }, 8), -- upload
      widget.box("horizontal", { self.wicon_down, m2, self.wtext_2 }, 8), -- download
      layout = wibox.layout.fixed.vertical
    }
  elseif self.want_layout == 'vertical' then
    local p_up = widget.progressbar_layout(pu, self.want_layout)
    local p_down = widget.progressbar_layout(pd, self.want_layout)
    w = wibox.widget {
      widget.box("vertical", { self.wicon_up, p_up }, 2), -- upload
      widget.box("vertical", { self.wicon_down, p_down }, 2), -- download
      spacing = 2,
      layout = wibox.layout.fixed.horizontal
    }
  end
  awesome.connect_signal("daemon::network", function(net)
    if net == nil or net[env.net_device] == nil then return end
    local up = net[env.net_device].up
    local down = net[env.net_device].down
    pu.value = up
    pd.value = down
    ip.markup = helpers.colorize_text(net[env.net_device].ip, fg)
    self.wtext_1.markup = helpers.colorize_text(up.." B/s", fg)
    self.wtext_2.markup = helpers.colorize_text(down.." B/s", fg)
  end)
  if self.want_layout == 'horizontal' then
    return wibox.widget {
      nil, w, nil,
      expand = "none",
      layout = wibox.layout.align.vertical
    }
  else
    return wibox.widget {
      nil, w, nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    }
  end
end

-- herit
local network_widget = class(network_root)

function network_widget:init(args)
  network_root.init(self, args)
  return self.widget
end

return network_widget
