local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local ram_icon = beautiful.widget_ram_icon
local fg = beautiful.widget_ram_fg
local bg = beautiful.widget_ram_bg
local l = beautiful.widget_ram_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(icon)
local text_margin = widget.text(text)
ram_widget = widget.box(l, { icon_margin, text_margin })

local function update_widget(used_ram_percentage)
  icon.markup = helpers.colorize_text(ram_icon, fg)
  text.markup = helpers.colorize_text(used_ram_percentage, fg)
end

local used_ram_script = [[
  bash -c "
  free | grep -z 'Mem.*Swap.*'
  "]]

awful.widget.watch(used_ram_script, 20, function(widget, stdout)
  local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
  stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

  local used_ram_percentage = math.floor((total - available) / (total) * 100 + 0.5)

  update_widget(used_ram_percentage)
end)
