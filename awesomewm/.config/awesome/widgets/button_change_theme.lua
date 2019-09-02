local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")
local dpi = require('beautiful').xresources.apply_dpi
local gtable = require('gears.table')

-- beautiful vars
local icon = beautiful.widget_change_theme_icon or ' 嗀'
local icon_reload = beautiful.widget_change_theme_icon_reload or ' 勒'
local fg = beautiful.widget_change_theme_fg or '#a9a9a9'
local bg = beautiful.widget_change_theme_bg or '#232323'
local l = beautiful.widget_change_theme_layout or 'horizontal'

-- for the popup
local fg_p = beautiful.fg_grey or "#aaaaaa"
local bg_p = beautiful.grey_dark or "#222222" -- same than the wibar
local padding = beautiful.widget_popup_padding or 1

-- widget creation
local text = widget.create_button(fg, icon)
local rld = widget.create_button(fg, icon_reload)
local wi = widget.box(l, { text, rld })

local popup_title = widget.create_text("Change theme", fg, beautiful.widget_text_font)

local popup_anonymous = widget.image_popup()
popup_anonymous.image = beautiful.widget_change_theme_anonymous

local popup_connected = widget.image_popup()
popup_connected.image = beautiful.widget_change_theme_connected

local popup_battleship = widget.image_popup()
popup_battleship.image = beautiful.widget_change_theme_battleship

local popup_tower = widget.image_popup()
popup_tower.image = beautiful.widget_change_theme_tower

local w_position -- the position of the popup depend of the wibar
w_position = widget.check_popup_position(beautiful.wibar_position)

local w = awful.popup {
  widget = {
      nil,
      {
        {
          {
            popup_title,
            layout = wibox.layout.align.vertical
          },
          {
            popup_anonymous,
            popup_connected,
            popup_battleship,
            popup_tower,
            forced_num_rows = 2,
            forced_num_cols = 2,
            layout = wibox.layout.grid,
          },
          layout = wibox.layout.align.vertical
        },
        margins = 5,
        widget = wibox.container.margin
      },
      layout = wibox.layout.fixed.horizontal
  },
  visible = false, -- do not show at start
  ontop = true,
  hide_on_right_click = true,
  preferred_positions = w_position,
  offset = { y = padding, x = padding }, -- no pasted on the bar
  bg = bg_p,
}

-- attach popup to widget
w:bind_to_widget(text)

-- audio.sh arguments are: [music_details] [path of your music directory]
local tower_change_script = [[
  bash -c "~/.config/awesome/widgets/change-theme.sh --change tower" ]]
widget.add_left_click_action(popup_tower, tower_change_script, 'shell')

local connected_change_script = [[
  bash -c "~/.config/awesome/widgets/change-theme.sh --change connected" ]]
widget.add_left_click_action(popup_connected, connected_change_script, 'shell')

local battleship_change_script = [[
  bash -c "~/.config/awesome/widgets/change-theme.sh --change battleship" ]]
widget.add_left_click_action(popup_battleship, battleship_change_script, 'shell')

local anonymous_change_script = [[
  bash -c "~/.config/awesome/widgets/change-theme.sh --change anonymous" ]]
widget.add_left_click_action(popup_anonymous, anonymous_change_script, 'shell')

rld:buttons(gtable.join(
  awful.button({ }, 1, function()
    awesome.restart()
  end)
))

return wi
