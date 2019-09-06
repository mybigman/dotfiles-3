local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

-- widget for the popup
local mpc = require("widgets.mpc")
local volume_bar = require("widgets.volume-slider")
volume_bar.forced_width = dpi(40) -- set a max width

-- beautiful vars
local icon = beautiful.widget_mpc_button_icon or "  "
local fg = beautiful.widget_volume_fg
local bg = beautiful.widget_volume_bg
local font_button = beautiful.widget_icon_font_button or 'Iosevka Term 16'
local l = beautiful.widget_button_music_layout or 'horizontal'

-- for the popup
local fg_p = beautiful.fg_grey or "#aaaaaa"
local bg_p = beautiful.grey_dark or "#222222" -- same than the wibar
local padding = beautiful.widget_popup_padding or 1

-- widget creation
local button = widget.create_button(fg, icon)

local popup_time = widget.base_text()

local function update_widget(mpd)
  popup_time.markup = helpers.colorize_text(mpd.full_time, "#66ffff")
end

local popup_image = widget.imagebox(80)
local popup_title = widget.base_text()
local popup_artist = widget.base_text()

local w_position -- the postion of the popup depend of the wibar
w_position = widget.check_popup_position(beautiful.wibar_position)

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
          {
            {
              mpc,
              top = 4, -- have to have similar value than bellow
              widget = wibox.container.margin
            },
            {
              volume_bar,
              top = 4, -- same above
              left = 14,
              widget = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal
          },
          spacing = dpi(2),
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
  --preferred_anchors = 'middle',
  --current_position = 'bottom',
  offset = { y = padding, x = padding }, -- no pasted on the bar
  bg = bg_p,
}

-- attach popup to widget
w:bind_to_widget(button)

local function update_popup(mpd)
  local img, title, artist

    -- default value
    img = mpd.cover or ''
    title = mpd.title or ''
    artist = mpd.artist or ''

    if img ~= '' then
      popup_image.image = img
    else
      popup_image.image = beautiful.widget_mpc_time_cover_album
    end

    if title ~= '' then
      popup_title.markup = helpers.colorize_text(title, "#ff66ff")
    else
      popup_title.markup = helpers.colorize_text("Unknown", "#ff66ff")
    end

    if artist ~= '' then
      popup_artist.markup = helpers.colorize_text("By "..artist, "#ffff66")
    else
      popup_artist.markup = helpers.colorize_text("By Unknown", "#ffff66")
    end
end

-- signals
awesome.connect_signal("daemon::mpd", function(mpd)
  update_popup(mpd)
end)

awesome.connect_signal("daemon::mpd_time", function(mpd)
  update_widget(mpd)
end)

return button
