local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local widget = require('util.widgets')

-- widgets for the monitor bar
local ram = require("widgets.ram")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })
local volume = require("widgets.volume")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })
local brightness = require("widgets.brightness")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })
local battery = require("widgets.battery")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })

local cpu = require("widgets.cpu")({ mode = "dotsbar" })
local disk = require("widgets.disks")({ mode = "block" })
local network = require("widgets.network")({ mode = "block" })
local music_player = require("widgets.music-player")({ mode = "block" })

-- init tables
local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- bottom bar
  s.monitor_bar = awful.wibar({ position = "bottom", height = dpi(80), screen = s })
  s.monitor_bar.bg = beautiful.wibar_bg

  -- widget to decorate 
  local boxes = function(w, size)
    local s = size or 200
    return wibox.widget {
      { -- margin top, bottom
        { -- left
          widget.create_title("", beautiful.primary, 16), nil, nil, -- top
          layout = wibox.layout.align.vertical
        },
        { -- center
          nil,
          {
            w,
            left = 15, right = 15,
            forced_width = dpi(s),
            widget = wibox.container.margin
          },
          nil,
          expand = "none",
          layout = wibox.layout.align.vertical
        },
        { -- right
          widget.create_title("", beautiful.secondary, 16), nil, nil, -- top
          layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.align.horizontal
      },
      top = 1, bottom = 1,
      widget = wibox.container.margin
    }
  end

  local w1 = wibox.widget {
    ram,
    brightness,
    forced_height = 30,
    layout = wibox.layout.fixed.horizontal
  }

  local w2 = wibox.widget {
    volume,
    battery,
    forced_height = 30,
    layout = wibox.layout.fixed.horizontal
  }

  s.monitor_bar:setup {
    { -- Left widgets
      boxes(music_player),
      spacing = beautiful.widget_spacing,
      layout = wibox.layout.fixed.horizontal
    },
    {
      boxes(disk, 250),
      boxes(widget.box('vertical', { w1, w2 }), 300),
      boxes(network, 250),
      spacing = beautiful.widget_spacing,
      layout = wibox.layout.fixed.horizontal
    },
    { -- Right widgets
      boxes(cpu),
      layout = wibox.layout.fixed.horizontal
    },
    expand ="none",
    layout = wibox.layout.align.horizontal
  }
end

return mybar
