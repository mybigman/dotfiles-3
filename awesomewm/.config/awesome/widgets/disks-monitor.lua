local widget = require("util.widgets")
local helpers = require("helpers")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- beautiful vars
local fg = beautiful.fg_primary

local title = widget.create_title("Disks ", fg)
local total_space = {} -- store all bars

local function make_widget()
  for i=1, 3 do -- TODO 3 should match with myfs lenght
    if i >= 2 then -- trick to add circle in circle in circle
      total_space[i] = widget.make_arcchart(total_space[i-1])
    else
      total_space[i] = widget.make_arcchart()
    end
  end
  return widget.box('horizontal', { total_space[3] }) -- TODO 3 should match with myfs lenght
end

local disks = make_widget()
local disks_widget = wibox.widget {
  disks,
  nil,
  {
    nil,
    title,
    nil,
    layout = wibox.layout.align.vertical
  },
  layout = wibox.layout.align.horizontal
}

-- signal
awesome.connect_signal("daemon::disks", function(fs_info)
  if fs_info ~= nil and fs_info[1] ~= nil then
    --naughty.notify({ text = "call daemon::disks3 "..tostring(fs_info[3].mountpoint) })
    for i=1, 3 do -- TODO 3 should match with myfs lenght
      total_space[i].value = fs_info[i].used_percent
    end
  end
end)

return disks_widget
