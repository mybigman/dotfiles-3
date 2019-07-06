local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")
--local separators = require("util.separators")

-- widget for the popup
local mpc = require("widgets.mpc")
local volume_bar = require("widgets.volume-bar")
--local pad = separators.pad

-- beautiful vars
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local l = beautiful.widget_volume_layout or 'horizontal'

-- widget creation
local text = widget.base_text()
local text_margin = widget.text(text)
local mpc_time_widget = widget.box(l, text_margin)
local popup_time = widget.base_text()

local function update_widget(volume)
  text.markup = helpers.colorize_text(volume, fg)
  popup_time.markup = helpers.colorize_text("Time: "..volume, "#66ffff")
end

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/audio.sh music", 2,
  function(widget, stdout, stderr, exitreason, exitcode)
    local info = stdout:match('(%d+:%d+.%d+:%d+%s?%d+%%)') or 0
    update_widget(info)
  end
)

local popup_image = wibox.widget {
  resize = true,
  forced_height = 80,
  forced_width = 83,
  widget = wibox.widget.imagebox
}

local popup_title = widget.base_text()
local popup_artist = widget.base_text()
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
          {
            mpc_widget,
            --pad(1),
            {
              volume_bar,
              left = 14,
              widget = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal
          },
          layout = wibox.layout.fixed.vertical
        },
        left = 10,
        right = 4,
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

-- audio.sh arguments are [music_details] [path of thr music directory]
-- pgrep -x audio.sh || ~/.config/awesome/widgets/audio.sh music_details /opt/musics
local mpc_details_script = [[
  bash -c "
  ~/.config/awesome/widgets/audio.sh music_details /opt/musics
"]]

local function update_popup()
  awful.widget.watch(mpc_details_script, 15 ,function(widget, stdout)
    local img, title, artist, percbar = stdout:match('img:%[([%w%s%p/.]*)%]%s?title:%[([%w%s%p.,-]*)%]%s?artist:%[([%w%s%p]*)%]%s?percbar:%[(.*)%]*%]')

    -- default value
    percbar = percbar or '-----------------------------' -- 29

    if img == '' then
      popup_image.image = beautiful.widget_mpc_time_cover_album
    else
      popup_image.image = img
    end

    if title == '' then
      popup_title.markup = helpers.colorize_text("Unknown", "#ff66ff")
    else
      popup_title.markup = helpers.colorize_text("Title: "..title, "#ff66ff")
    end

    if artist == '' then
      popup_artist.markup = helpers.colorize_text("Artist: Jane Doe", "#ffff66")
    else
      popup_artist.markup = helpers.colorize_text("Artist: "..artist, "#ffff66")
    end

    popup_percbar.markup = helpers.colorize_text(percbar, "#6f6fff")
  end)
end

update_popup()

return mpc_time_widget
