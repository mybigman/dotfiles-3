local wibox = require("wibox")
local gtable = require("gears.table")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local naughty = require("naughty")

local function boxes(w)
  local boxed_widget = wibox.widget {
    {
      w,
      bg = beautiful.grey_dark,
      widget = wibox.container.background
    },
    margins = 10,
    color = "#00000000",
    widget = wibox.container.margin
  }
  return boxed_widget
end

local treatpost = widget.base_text()
local poe = widget.base_text()

local function start_screen_hide()
  start_screen.visible = false
end

start_screen = wibox({ visible = false, ontop = true, type = "dock" })
start_screen.bg = beautiful.grey .. "00"
awful.placement.maximize(start_screen)

start_screen:buttons(gtable.join(
  awful.button({}, 1, function()
    start_screen_hide()
  end)
))

start_screen:setup {
  nil,
  {
    nil,
    {
      boxes(treatpost),
      boxes(poe),
      layout = wibox.layout.fixed.vertical
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.vertical
}

-- signal rss
awesome.connect_signal("daemon::rss", function(rss) 
  if rss.treatpost then
    treatpost.markup = table.concat(rss.treatpost.title, "\n")
  end
  if rss.poe then
    poe.markup = table.concat(rss.poe.title, "\n")
  end
end)
