local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")

-- widget for the popup
local mpc = require("widgets.mpc")
local volume_bar = require("widgets.volume-bar")

-- beautiful vars
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local l = beautiful.widget_volume_layout or 'horizontal'

-- widget creation
local text = widget.for_one_icon(fg, bg, "  ", "Iosevka Term 16")
local button_only_mpc_widget = widget.box(l, text)
local popup_time = widget.base_text()

local function update_widget(volume)
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

local w_position -- the postion of the popup depend of the wibar
if beautiful.wibar_position == 'top' then
  w_position = 'bottom' 
else 
  w_position = 'top'
end

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
  preferred_positions = w_position,
  preferred_anchors = 'middle'
}

-- attach popup to mpd_time_widget
w:bind_to_widget(button_only_mpc_widget)

-- audio.sh arguments are: [music_details] [path of your music directory]
local mpc_details_script = [[
  bash -c "
  ~/.config/awesome/widgets/audio.sh music_details /opt/musics
"]]

local function update_popup()
  awful.widget.watch(mpc_details_script, 15 ,function(widget, stdout)
    local img, title, artist, percbar = stdout:match('img:%[(.*)%]%s?title:%[(.*)%]%s?artist:%[(.*)%]%s?percbar:%[(.*)%]*%]')

    -- default value
    img = img or ''
    title = title or ''
    artist = artist or ''
    percbar = percbar or '----------------------------' -- 28

    if img ~= '' then
      popup_image.image = img
    else
      popup_image.image = beautiful.widget_mpc_time_cover_album
    end

    if title ~= '' then
      popup_title.markup = helpers.colorize_text("Title: "..title, "#ff66ff")
    else
      popup_title.markup = helpers.colorize_text("Unknown", "#ff66ff")
    end

    if artist ~= '' then
      popup_artist.markup = helpers.colorize_text("Artist: "..artist, "#ffff66")
    else
      popup_artist.markup = helpers.colorize_text("Artist: Jane Doe", "#ffff66")
    end

    popup_percbar.markup = helpers.colorize_text(percbar, "#6f6fff")
  end)
end

update_popup()

return button_only_mpc_widget
