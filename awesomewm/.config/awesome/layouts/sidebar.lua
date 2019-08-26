local wibox = require("wibox")
local awful = require("awful")
local gtable = require("gears.table")
local widget = require("util.widgets")
local separator = require("util.separators")

-- beautiful var
local font = "sans 16"
local fg = "#ffffff"
local bg = "#651030"
local l = "horizontal"

local pad = separator.pad(1)

-- add title

-- add exit menu
local exit_icon = widget.for_one_icon(fg, bg, "    LOGOUT    ", font)
local exit = widget.box(l, exit_icon)
exit:buttons(gtable.join(
awful.button({ }, 1, function ()
  exit_screen_show()
  sidebar.visible = false
end)
))

-- sidebar creation
sidebar = wibox({ visible = false, ontop = true, type = "dock" })
sidebar.bg = "#00000022"
sidebar.width = 300
sidebar.height = awful.screen.focused().geometry.height - 120
awful.placement.right(sidebar)

-- a middle click to hide the sidebar
sidebar:buttons(gtable.join(
  awful.button({ }, 2, function() 
    sidebar.visible = false
  end)
))

-- setup
sidebar:setup {
  { -- top
    layout = wibox.layout.align.horizontal
  },
  { -- middle
    layout = wibox.layout.align.horizontal
  },
  { -- bottom
    {
      nil,
      {
        exit,
        layout = wibox.layout.align.horizontal,
      },
      nil,
      layout = wibox.layout.align.horizontal,
      expand = "none"
    },
    pad,
    layout = wibox.layout.align.vertical
  },
  layout = wibox.layout.align.vertical
}
