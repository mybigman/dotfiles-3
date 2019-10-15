---------------------------
-- Machine awesome theme --
---------------------------

local theme_name = "machine"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local gshape = require("gears.shape")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layouts/"
local xrdb = xresources.get_current_theme()
local wibox = require("wibox")
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"

local theme = {}

-- Get colors from .Xresources and set fallback colors
theme.xbackground = xrdb.background or "#282F37"
theme.xforeground = xrdb.foreground or "#F1FCF9"
theme.xcolor0     = xrdb.color0     or "#20262C"
theme.xcolor1     = xrdb.color1     or "#DB86BA"
theme.xcolor2     = xrdb.color2     or "#74DD91"
theme.xcolor3     = xrdb.color3     or "#E49186"
theme.xcolor4     = xrdb.color4     or "#75DBE1"
theme.xcolor5     = xrdb.color5     or "#B4A1DB"
theme.xcolor6     = xrdb.color6     or "#9EE9EA"
theme.xcolor7     = xrdb.color7     or "#F1FCF9"
theme.xcolor8     = xrdb.color8     or "#465463"
theme.xcolor9     = xrdb.color9     or "#D04E9D"
theme.xcolor10    = xrdb.color10    or "#4BC66D"
theme.xcolor11    = xrdb.color11    or "#DB695B"
theme.xcolor12    = xrdb.color12    or "#3DBAC2"
theme.xcolor13    = xrdb.color13    or "#825ECE"
theme.xcolor14    = xrdb.color14    or "#62CDCD"
theme.xcolor15    = xrdb.color15    or "#E0E5E5"

-- Regroup fonts
theme.myfont = "SpaceMono Nerd Font Mono"
theme.font = "SpaceMono Nerd Font Mono Regular 8"
theme.taglist_font = "SpaceMono Nerd Font Bold 10"
theme.widget_icon_font = "SpaceMono Nerd Font Mono 13"
theme.widget_text_font = "SpaceMono Nerd Font Regular 9"
theme.widget_font = 'SpaceMono Nerd Font Mono 15'
theme.widget_icon_font_button = "SpaceMono Nerd Font Mono 16"
theme.widget_title_font = "SpaceMono Nerd Font Bold 10"

theme.bg_normal     = theme.xbackground
theme.bg_focus      = theme.xcolor0
theme.bg_urgent     = theme.alert
--theme.bg_minimize   = "#444444"
--theme.bg_systray    = theme.xbackground

-- Material theme
theme.grey_dark = "#070c15"
theme.grey = theme.xbackground
theme.grey_light = theme.xcolor0

theme.primary_dark = theme.xcolor6 -- cyan D
theme.primary = theme.xcolor2 -- cyan
theme.primary_light = theme.xcolor14 -- cyan L

theme.secondary_dark = theme.xcolor5 -- magenta D
theme.secondary = theme.xcolor4 -- magenta
theme.secondary_light = theme.xcolor13 -- magenta L

theme.alert_dark = theme.xcolor1
theme.alert = theme.xcolor9
theme.alert_light = theme.xcolor3

theme.fg_grey = theme.xforeground
theme.fg_grey_light = theme.xforeground
theme.fg_primary = theme.xcolor10
theme.fg_primary_focus = theme.xcolor7
theme.fg_secondary = theme.xcolor12
theme.fg_secondary_focus = theme.xcolor15
theme.fg_alert = theme.xcolor11
-- End Material theme

theme.fg_normal     = theme.fg_primary
theme.fg_focus      = theme.fg_primary_focus
theme.fg_urgent     = theme.fg_alert
--theme.fg_minimize   = "#222222"

theme.border_width  = dpi(3)
theme.screen_margin = dpi(6)
theme.useless_gap   = dpi(5)
theme.border_normal = theme.grey_dark
theme.border_focus  = theme.grey_dark
theme.border_marked = theme.grey
theme.border_radius = dpi(11)

-- general padding
theme.general_padding = { left = dpi(15), right = dpi(15), top = dpi(15), bottom = dpi(15) }

-- smart border
theme.double_border = false
theme.double_border_normal = theme.primary
theme.double_border_focus = theme.alert_dark

-- {{{ TITLEBAR 

theme.titlebar_fg_normal = theme.fg_primary
theme.titlebar_bg_normal = theme.primary_dark
theme.titlebar_fg_focus = theme.fg_primary_focus
theme.titlebar_bg_focus = theme.alert_dark
theme.titlebars_enabled = true 
theme.titlebar_title_enabled = false
theme.titlebar_buttons_enabled = false
theme.titlebar_position = 'left'
theme.titlebars_imitate_borders = false
theme.titlebars_imitate_borders_size = 2
theme.titlebar_size = dpi(15)
-- }}} End TITLEBAR

-- Top bar
theme.wibar_size = dpi(42)
theme.wibar_bg = theme.grey_dark .. "ff"
theme.wibar_border_radius = dpi(0)
theme.wibar_position = "left"

-- Edge snap
theme.snap_bg = theme.bg_focus
if theme.border_width == 0 then
  theme.snap_border_width = dpi(1)
else
  theme.snap_border_width = dpi(theme.border_width * 1)
end

-- {{{ TAGLIST

-- Nerd Font icon here
theme.tagnames = {" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 10 "}
-- mini_taglist
theme.taglist_text_occupied = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}
theme.taglist_text_focused = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}
theme.taglist_text_urgent = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}
theme.taglist_text_empty = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}

theme.taglist_shape = gshape.circle
theme.taglist_shape_empty = gshape.circle
theme.taglist_shape_focus = gshape.circle
theme.taglist_shape_urgent = gshape.circle
theme.taglist_shape_volatile = gshape.circle
theme.taglist_shape_border_width = 1
theme.taglist_shape_border_color = "#8f1f2f"
theme.taglist_shape_border_width_empty = 0
theme.taglist_shape_border_color_empty = "#004444"
theme.taglist_shape_border_width_focus = 1
theme.taglist_shape_border_color_focus = "#af2f3f"
theme.taglist_shape_border_width_urgent = 1
theme.taglist_shape_border_color_urgent = "#F0F00F"
theme.taglist_shape_border_width_volatile = 1
theme.taglist_shape_border_color_volatile = "#00FF00"

-- icon_taglist
theme.ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, theme.ntags do
  theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
end

-- different color on each taglists
theme.taglist_text_color_empty = { theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark }

theme.taglist_text_color_occupied = { theme.xcolor0, theme.xcolor2, theme.xcolor4, theme.xcolor0, theme.xcolor2, theme.xcolor4, theme.xcolor0, theme.xcolor2, theme.xcolor4, theme.xcolor0 }

theme.taglist_text_color_focused = { theme.xcolor8, theme.xcolor14, theme.xcolor13, theme.xcolor8, theme.xcolor14, theme.xcolor13, theme.xcolor8, theme.xcolor14, theme.xcolor13, theme.xcolor8 }

theme.taglist_text_color_urgent = { theme.xcolor1, theme.xcolor9, theme.xcolor3, theme.xcolor1, theme.xcolor9, theme.xcolor3, theme.xcolor1, theme.xcolor9, theme.xcolor3, theme.xcolor1 }

theme.taglist_layout = wibox.layout.fixed.vertical -- horizontal or vertical

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, theme.fg_normal
)

-- }}} TAGLIST END

-- {{{ MENU

theme.menu_submenu_icon = themes_path.."theme_name../submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- }}} End MENU

--theme.wallpaper = os.getenv("HOME") .. "/images/"..theme_name..".jpg"
theme.wallpaper = os.getenv("HOME") .. "/images/" .. theme_name .. ".jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = nil

-- {{{ Tasklist

theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true 
theme.tasklist_shape = function(cr, width, height) gshape.transform(gshape.rounded_rect) : translate(0,40) (cr, width, -1, 4) end 
theme.tasklist_shape_border_width = 2
theme.tasklist_shape_border_color = theme.primary_dark
theme.tasklist_shape_border_color_focus = theme.secondary_dark
theme.tasklist_spacing = dpi(4)
theme.tasklist_align = "center"
theme.tasklist_fg_normal = theme.xforeground

-- }}} End Tasklist

-- {{{ WIDGETS

theme.widget_spacing = dpi(5) -- space between each widgets
-- popup (distance between the bar and the popup, 0 is pasted at the bar)
theme.widget_popup_padding = dpi(3)

-- Hostname
theme.widget_hostname_text_icon = '<span foreground="#948a77">  </span>'

-- Tor
theme.widget_tor_icon = "  﨩  "
theme.widget_tor_fg_enable = theme.fg_grey
theme.widget_tor_fg_disable = theme.fg_alert
theme.widget_tor_bg = "#272f3b"

-- Mini ncmpcpp player
theme.widget_ncmpcpp_prev = ' ≪ '
theme.widget_ncmpcpp_toggle = ' ⊡ '
theme.widget_ncmpcpp_next = ' ≫ '

-- Mails
theme.widget_email_read_icon = "  "
theme.widget_email_unread_icon = "  "
theme.widget_email_fg_read = theme.fg_grey
theme.widget_email_fg_unread = theme.fg_primary
theme.widget_email_bg = theme.grey
theme.widget_email_layout = 'horizontal' -- horizontal or vertical
theme.widget_email_type = 'button' -- button or text

-- Network
theme.widget_network_icon = ""
theme.widget_network_fg = theme.fg_primary
theme.widget_network_fg_error = theme.fg_alert
theme.widget_network_bg = theme.xbackground .. "00"
theme.widget_network_layout = 'horizontal' -- horizontal or vertical

-- Wifi str
theme.widget_wifi_str_fg = "#87aaaa"
theme.widget_wifi_str_bg = theme.xbackground .. "00"
theme.widget_wifi_layout = 'horizontal' -- horizontal or vertical

-- RAM
theme.widget_ram_icon = ""
theme.widget_ram_fg = theme.fg_alert
theme.widget_ram_bg = theme.xbackground .. "ff"
theme.widget_ram_layout = 'horizontal' -- horizontal or vertical

-- Battery
theme.widget_battery_icon_discharging = ""
theme.widget_battery_icon_charging = ""
theme.widget_battery_icon_full = ""
theme.widget_battery_icon_ac = "臘"
theme.widget_battery_fg = theme.fg_secondary
theme.widget_battery_bg = theme.xbackground .. "ff"
theme.widget_battery_layout = 'horizontal' -- horizontal or vertical

-- mpc
theme.widget_mpc_prev_icon = ""
theme.widget_mpc_pause_icon = ""
theme.widget_mpc_play_icon = ""
theme.widget_mpc_stop_icon = ""
theme.widget_mpc_next_icon = ""
theme.widget_mpc_fg = theme.fg_grey
theme.widget_mpc_bg = theme.xbackground .. "ff"
theme.widget_mpc_layout = 'horizontal' -- horizontal or vertical

-- volume
theme.widget_volume_icon = ""
theme.widget_volume_fg = theme.fg_grey
theme.widget_volume_bg = theme.grey_dark
theme.widget_volume_layout = 'horizontal' -- horizontal or vertical

-- Date
theme.widget_date_icon = ""
theme.widget_date_fg = theme.fg_grey
theme.widget_date_bg = theme.xbackground .. "ff"
theme.widget_date_layout = 'horizontal' -- horizontal or vertical

-- Screenshot
theme.widget_scrot_fg = theme.fg_grey
theme.widget_scrot_icon = '  '

-- button music
theme.widget_button_music_layout = 'horizontal'

-- Change theme
theme.widget_change_theme_bg = theme.grey_dark
theme.widget_change_theme_fg = theme.fg_grey
theme.widget_change_theme_layout = "vertical"

-- Button mpc
theme.widget_mpc_button_icon = "  "

-- }}} End WIDGET

return theme
