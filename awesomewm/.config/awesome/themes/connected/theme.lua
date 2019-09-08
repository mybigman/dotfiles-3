---------------------------
-- Connected awesome theme --
---------------------------

local theme_name = "connected"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layouts/"
local xrdb = xresources.get_current_theme()
local wibox = require("wibox")

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

--theme.font          = "sans 8"
theme.font          = "RobotoMono Nerd Font 8"

theme.bg_normal     = theme.xbackground
theme.bg_focus      = theme.xcolor0
--theme.bg_urgent     = theme.xbackground
--theme.bg_minimize   = "#444444"
--theme.bg_systray    = theme.xbackground

-- Material theme
theme.grey_dark = theme.xbackground
theme.grey = theme.xcolor0
theme.grey_light = theme.xcolor8

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
theme.fg_alert = theme.xcolor11

theme.fg_primary = theme.xcolor10
theme.fg_primary_focus = theme.xcolor7

theme.fg_secondary = theme.xcolor12
theme.fg_secondary_focus = theme.xcolor15
-- End Material theme

theme.fg_normal     = theme.fg_primary
theme.fg_focus      = theme.fg_primary_focus
theme.fg_urgent     = theme.fg_alert
theme.fg_minimize   = "#222222"

theme.border_width  = dpi(2)
theme.screen_margin = dpi(6)
theme.useless_gap   = dpi(0)
theme.border_normal = theme.grey
theme.border_focus  = theme.grey_light
theme.border_marked = theme.secondary

-- general padding
theme.general_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- rounded corners
theme.border_radius = dpi(4)

-- {{{ TITLEBAR 

theme.titlebar_fg_normal = theme.fg_grey
theme.titlebar_bg_normal = theme.grey
theme.titlebar_fg_focus = theme.fg_primary_focus
theme.titlebar_bg_focus = theme.grey
theme.titlebars_enabled = true 
theme.titlebar_title_enabled = true 
theme.titlebars_imitate_borders = false

-- }}} End TITLEBAR

-- Top bar
theme.wibar_height = dpi(22)
theme.wibar_bg = theme.grey_dark .. "ff"
theme.wibar_border_radius = dpi(0)
theme.wibar_position = "top"

-- Edge snap
theme.snap_bg = theme.bg_focus
if theme.border_width == 0 then
    theme.snap_border_width = dpi(8)
else
    theme.snap_border_width = dpi(theme.border_width * 2)
end

-- {{{ TAGLIST

-- mini_taglist
-- Nerd Font icon here
theme.tagnames = {" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 10 "}
theme.taglist_text_occupied = {"","","ﲵ","ﱘ","","","","","","ﮊ"}
theme.taglist_text_focused = {"","","ﲵ","ﱘ","","","","","","ﮊ"}
theme.taglist_text_urgent = {"","","ﲵ","ﱘ","","","","","","ﮊ"}
theme.taglist_text_empty = {".",".",".",".",".",".",".",".",".","."}

-- different color on each taglists
theme.taglist_text_color_empty = { theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8 }
theme.taglist_text_color_occupied = { theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4, theme.xcolor5, theme.xcolor6, theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4 }
theme.taglist_text_color_focused = { theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4, theme.xcolor5, theme.xcolor6, theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4 }
theme.taglist_text_color_urgent = { theme.xcolor9, theme.xcolor10, theme.xcolor11, theme.xcolor12, theme.xcolor13, theme.xcolor14, theme.xcolor9, theme.xcolor10, theme.xcolor11, theme.xcolor12 }

-- Text Taglist (default)
theme.taglist_font = "RobotoMono Nerd Font Mono 12"
theme.taglist_bg_normal = theme.grey
theme.taglist_fg_focus = "#565b5e"
theme.taglist_bg_focus = theme.grey_light
theme.taglist_bg_occupied = theme.grey
theme.taglist_fg_occupied = "#434e4a"
theme.taglist_bg_empty = theme.grey_dark
theme.taglist_fg_empty = "#192429"
theme.taglist_bg_urgent = theme.grey_light
theme.taglist_fg_urgent = "#3e3433"
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)
theme.taglist_item_roundness = dpi(5)
theme.taglist_layout = wibox.layout.fixed.horizontal

theme.taglist_squares = "false"

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

theme.wallpaper = os.getenv("HOME") .. "/images/"..theme_name..".jpg"

-- You can use your own layout icons like this:
--theme.layout_fairh = layout_icon_path.."fairhw.png"
--theme.layout_fairv = layout_icon_path.."fairvw.png"
--theme.layout_floating  = layout_icon_path.."floatingw.png"
--theme.layout_magnifier = layout_icon_path.."magnifierw.png"
--theme.layout_max = layout_icon_path.."max.png"
--theme.layout_fullscreen = layout_icon_path.."fullscreenw.png"
--theme.layout_tilebottom = layout_icon_path.."tilebottomw.png"
--theme.layout_tileleft   = layout_icon_path.."tileleftw.png"
--theme.layout_tile = layout_icon_path.."tilew.png"
--theme.layout_tiletop = layout_icon_path.."tiletopw.png"
--theme.layout_spiral  = layout_icon_path.."spiralw.png"
--theme.layout_dwindle = layout_icon_path.."dwindlew.png"
--theme.layout_cornernw = layout_icon_path.."cornernww.png"
--theme.layout_cornerne = layout_icon_path.."cornernew.png"
--theme.layout_cornersw = layout_icon_path.."cornersww.png"
--theme.layout_cornerse = layout_icon_path.."cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- {{{ WIDGET

-- popup 
theme.widget_popup_padding = dpi(3)

theme.widget_icon_font = "RobotoMono Nerd Font Mono 13"
theme.widget_text_font = "RobotoMono Nerd Font 8"

-- Hostname
theme.widget_hostname_text_icon = '<span foreground="'..theme.fg_primary..'">  </span>'

-- Tor
theme.widget_tor_icon = " 﨩 "
theme.widget_tor_fg_enable = theme.fg_primary
theme.widget_tor_fg_disable = theme.fg_alert
theme.widget_tor_bg = theme.grey

-- Mini ncmpcpp player
theme.widget_font = 'RobotoMono Nerd Font Mono 15'
theme.widget_ncmpcpp_prev = '<span foreground="'..theme.alert..'"> &lt; </span>'
theme.widget_ncmpcpp_toggle = '<span foreground="'..theme.alert..'">  </span>'
theme.widget_ncmpcpp_next = '<span foreground="'..theme.alert..'"> &gt; </span>'

-- Mails
theme.widget_email_read_icon = ""
theme.widget_email_unread_icon = ""
theme.widget_email_fg_read = theme.fg_grey
theme.widget_email_fg_unread = theme.fg_alert
theme.widget_email_bg = theme.grey_light

-- Network
theme.widget_network_icon = ""
theme.widget_network_fg = theme.fg_grey
theme.widget_network_fg_error = theme.fg_alert
theme.widget_network_bg = theme.grey_light

-- Wifi str
theme.widget_wifi_str_fg = theme.fg_primary
theme.widget_wifi_str_bg = theme.primary_dark

-- RAM
theme.widget_ram_icon = ""
theme.widget_ram_fg = theme.fg_grey
theme.widget_ram_bg = theme.grey

-- Battery
theme.widget_battery_icon_discharging = ""
theme.widget_battery_icon_charging = ""
theme.widget_battery_icon_full = ""
theme.widget_battery_icon_ac = "臘"
theme.widget_battery_fg = theme.fg_primary
theme.widget_battery_bg = theme.primary_dark

-- mpc
theme.widget_mpc_prev_icon = ""
theme.widget_mpc_pause_icon = ""
theme.widget_mpc_play_icon = ""
theme.widget_mpc_stop_icon = ""
theme.widget_mpc_next_icon = ""
theme.widget_mpc_fg = theme.primary
theme.widget_mpc_bg = theme.grey

-- volume
theme.widget_volume_icon = ""
theme.widget_volume_fg = theme.fg_grey
theme.widget_volume_bg = theme.grey_light

-- Date
theme.widget_date_icon = ""
theme.widget_date_fg = theme.fg_grey
theme.widget_date_bg = theme.grey

-- Screenshot
theme.widget_scrot_fg = theme.fg_grey
theme.widget_scrot_icon = '  '

-- change theme
theme.widget_change_theme_icon = " 嗀"
theme.widget_change_theme_icon_reload = " 勒 "
theme.widget_change_theme_fg = theme.fg_grey
theme.widget_change_theme_bg = theme.grey

-- }}} End WIDGET

return theme
