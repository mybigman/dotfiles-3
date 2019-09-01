local awful = require("awful")
local gtable = require("gears.table")
local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local ncmpcpp_bar = require("widgets.ncmpcpp")
local pad = wibox.widget.textbox(" ")

local titlebars = {}

-- Disable popup tooltip on titlebar button hover
awful.titlebar.enable_tooltip = false

-- buttons for the titlebar
titlebars.buttons = gtable.join(
  awful.button({ }, 1, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    c:raise()
    awful.mouse.client.move(c)
  end),
  awful.button({ }, 3, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    c:raise()
    awful.mouse.client.resize(c)
  end)
)

local function status_text(client)
  local text = ""

  if client.floating then
    text = text .. "f"
  end
  if client.maximized then
    text = text .. "x"
  end

  if text ~= "" then
    text = "[" .. text .. "]"
  end

  return text
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

  local buttons = titlebars.buttons

  local status_textbox = wibox.widget.textbox(status_text(c))
  awful.titlebar(c, { size = 16, position = "left" }) : setup {
    buttons = buttons,
    layout = wibox.layout.align.horizontal
  }

  -- Signal
  local function upd_status_text(c)
    status_textbox.text = status_text(c)
  end

  c:connect_signal("property::floating", upd_status_text)
  c:connect_signal("property::maximized", upd_status_text)

end)

return titlebars
