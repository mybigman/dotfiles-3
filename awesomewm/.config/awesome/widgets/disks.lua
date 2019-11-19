local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local env = require("env-config")

-- beautiful vars
local fg = beautiful.fg_primary

local function new(self, ...)
  local instance = setmetatable({}, { __index = self })
  return instance:init(...) or instance
end

local function class(base)
  return setmetatable({ new = new }, { __call = new, __index = base })
end

-- root
local disks_root = class()

function disks_root:init(args)
  -- options
  self.icon = widget.base_icon("", beautiful.primary)
  self.mode = args.mode or 'text' -- possible values: text, arcchart, block
  self.want_layout = args.want_layout or beautiful.widget_cpu_layout or 'horizontal' -- possible values: horizontal , vertical
  -- base widgets
  self.wicon = widget.base_icon()
  self.wtext = widget.base_text()
  self.wtitle = widget.create_title("Disks ", fg)
  self.wbars = {} -- store all bars (one by cpu/core)
  self.widget = self:make_widget()
end

function disks_root:make_widget()
  if self.mode == "arcchart" then
    return self:make_arcchart()
  elseif self.mode == "block" then
    return self:make_block()
  else
    return self:make_text()
  end
end

function disks_root:make_all_arcchart()
  for i=1, #env.disks do 
    if i >= 2 then -- trick to add circle in circle in circle
      self.wbars[i] = widget.make_arcchart(self.wbars[i-1])
    else
      self.wbars[i] = widget.make_arcchart()
    end
  end
end

function disks_root:make_arcchart()
  self:make_all_arcchart()
  local w = wibox.widget {
    widget.box('horizontal', { self.wbars[#env.disks] }),
    nil,
    {
      nil,
      self.wtitle,
      nil,
      layout = wibox.layout.align.vertical
    },
    layout = wibox.layout.align.horizontal
  }
  -- signal
  awesome.connect_signal("daemon::disks", function(fs_info)
    if fs_info ~= nil and fs_info[1] ~= nil then
      for i=1, #env.disks do
        self.wbars[i].value = fs_info[i].used_percent
      end
    end
  end)
  return w
end

function disks_root:make_block()
  for i = 1, #env.disks do
    self.wbars[i] = {}
    self.wbars[i]["title"] = wibox.widget.textbox(env.disks[i])
    self.wbars[i]["used_percent"] = widget.make_progressbar(_, 100)
    self.wbars[i]["size"] = wibox.widget.textbox()
  end

  local w = wibox.widget{ layout=wibox.layout.fixed.vertical, spacing = 1 }
  for i=1, #env.disks do
    local t = self.wbars[i].title -- box
    local u = self.wbars[i].used_percent -- box
    u.forced_height = 2
    local s = self.wbars[i].size -- title
    local m = widget.add_margin(u, { top = 4, bottom = 4 }) -- used to correct the height of the progressbar
    w:add(widget.box('horizontal', { self.icon, t, m, s }, 12))
  end

  awesome.connect_signal("daemon::disks", function(fs_info)
    if fs_info ~= nil and fs_info[1] ~= nil then
      for i=1, #env.disks do
        self.wbars[i].used_percent.value = fs_info[i].used_percent
        self.wbars[i].size.markup = helpers.colorize_text(fs_info[i].size, beautiful.primary_light)
      end
    end
  end)
  return wibox.widget {
    nil, w, nil, -- centered
    expand = "none",
    layout = wibox.layout.align.vertical
  }
end

-- herit
local disks_widget = class(disks_root)

function disks_widget:init(args)
  disks_root.init(self, args)
  return self.widget
end

return disks_widget
