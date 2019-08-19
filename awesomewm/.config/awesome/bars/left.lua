local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Widgets
local tagslist = require("widgets.icon_taglist")

awful.screen.connect_for_each_screen(function(s)
  s.mwibox = awful.wibar({ position = "left", width = 30, x = 30, w = 100 })
  s.mwibox:setup {
    { 
      {
        --top
        layout = wibox.layout.fixed.vertical,
      },
      --spacing = dpi(14),
      layout = wibox.layout.fixed.vertical
    },
    tagslist,
    expand = "none",
    layout = wibox.layout.align.vertical
  }
end)
