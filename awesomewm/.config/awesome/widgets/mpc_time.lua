local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")

-- widget for the popup
local mpc = require("widgets.mpc")

-- beautiful vars
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local l = beautiful.widget_volume_layout or 'horizontal'

-- widget creation
local text = widget.base_text()
local text_margin = widget.text(text)
local mpc_time_widget = widget.box(l, text_margin)

local function update_widget(volume)
  text.markup = helpers.colorize_text(volume, fg)
end

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/audio.sh music", 1,
  function(widget, stdout, stderr, exitreason, exitcode)
    local info = stdout:match('(%d+:%d+.%d+:%d+%s?%d+%%)') or 0
    update_widget(info)
  end
)

local popup_image = wibox.widget {
  resize = true,
  forced_height = 80,
  forced_width = 128,
  widget = wibox.widget.imagebox
}

local popup_title = widget.base_text()
local popup_artist = widget.base_text()
local popup_time = widget.base_text()
local popup_percbar = widget.base_text()

local w = awful.popup {
  widget = {
    {
      {
        popup_image,
        layout = wibox.layout.align.horizontal
      },
      {
        {
          popup_title,
          popup_artist,
          popup_time,
          popup_percbar,
          mpc_widget,
          layout = wibox.layout.fixed.vertical
        },
        left = 10,
        widget = wibox.container.margin
      },
      layout = wibox.layout.align.horizontal
    },
    margins = 10,
    widget = wibox.container.margin
  },
  visible = false, -- do not show at start
  ontop = true,
  hide_on_right_click = true,
  preferred_positions = 'top', -- depend of the bar
  preferred_anchors = 'middle'
  --placement = awful.placement.top
}

-- attach popup to mpd_time_widget
w:bind_to_widget(mpc_time_widget)

function update_popup()
  awful.widget.watch(os.getenv("HOME").."/.config/awesome/widgets/audio.sh music_details", 1 ,function(widget, stdout)
    local img, title, artist, time, percbar = stdout:match('img:%[([%a/.]+)%]%s?title:%[([%w%s%p.,-]*)%]%s?artist:%[([%w%s%p]*)%]%s?time:%[(%d+:%d+.%d+:%d+%s?%(%d+%%%))%]%s?percbar:%[(.*)%]*%]')

    local title_nv = title or '' -- avoid error if nil
    local artist_nv = artist or '' -- avoid error if nil

    popup_image.image = img
    popup_title.markup = helpers.colorize_text("Title: "..title_nv, "#ff66ff")
    popup_artist.markup = helpers.colorize_text("Artist: "..artist_nv, "#ffff66")
    popup_time.markup = helpers.colorize_text("Time: "..time, "#66ffff")
    popup_percbar.markup = helpers.colorize_text(percbar, "#6f6fff")
  end)
end

mpc_time_widget:connect_signal("mouse::enter", function() 
  update_popup()
end)

return mpc_time_widget
