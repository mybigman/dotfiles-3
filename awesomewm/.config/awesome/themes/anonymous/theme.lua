---------------------------
-- Anonymous awesome theme --
---------------------------

local theme_name = "anonymous"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local gears = require("gears")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layouts/"
local xrdb = xresources.get_current_theme()
local wibox = require("wibox")
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"

-- screen size
local ascreen = require("awful.screen")
local screen_width = ascreen.focused().geometry.width
local screen_height = ascreen.focused().geometry.height

local theme = {}

-- Get colors from .Xresources
-- bg
theme.grey_dark = "#202a34"
theme.grey = xrdb.background
theme.grey_light = xrdb.color0

theme.primary_dark = xrdb.color6
theme.primary = xrdb.color2
theme.primary_light = xrdb.color14

theme.secondary_dark = xrdb.color5
theme.secondary = xrdb.color4
theme.secondary_light = xrdb.color13

theme.alert_dark = xrdb.color1
theme.alert = xrdb.color9
theme.alert_light = xrdb.color3

-- fg
theme.fg_grey = xrdb.color8
theme.fg_grey_light = xrdb.foreground
theme.fg_primary = xrdb.color10
theme.fg_primary_focus = xrdb.color7
theme.fg_secondary = xrdb.color12
theme.fg_secondary_focus = xrdb.color15
theme.fg_alert = xrdb.color11

theme.font          = "RobotoMono Nerd Font 8"

theme.bg_normal     = theme.grey
theme.bg_focus      = theme.grey_light
--theme.bg_urgent     = theme.xbackground
--theme.bg_minimize   = "#444444"
--theme.bg_systray    = theme.xbackground

theme.fg_normal     = theme.fg_primary
theme.fg_focus      = theme.fg_primary_focus
theme.fg_urgent     = theme.fg_alert
theme.fg_minimize   = theme.fg_primary

theme.border_width  = dpi(5)
theme.screen_margin = dpi(6)
theme.useless_gap   = dpi(5)
theme.border_normal = theme.grey_dark
theme.border_focus  = theme.grey_light
theme.border_marked = theme.grey

-- general padding
theme.general_padding = { left = dpi(6), right = dpi(6), top = dpi(6), bottom = dpi(6) }

-- rounded corners
theme.border_radius = dpi(8)
theme.wibar_position = "top"

-- {{{ TITLEBAR 

theme.titlebar_fg_normal = theme.fg_primary
theme.titlebar_bg_normal = theme.grey_dark
theme.titlebar_fg_focus = theme.fg_primary_focus
theme.titlebar_bg_focus = theme.grey_dark
theme.titlebars_enabled = true 
theme.titlebar_title_enabled = true 
theme.titlebars_imitate_borders = false

-- }}} End TITLEBAR

-- Top bar
theme.wibar_size = dpi(42)
theme.wibar_width = screen_width - dpi(126)

theme.wibar_bg = theme.grey .. "00"
theme.wibar_border_radius = dpi(0)

-- Edge snap
theme.snap_bg = theme.bg_focus
if theme.border_width == 0 then
    theme.snap_border_width = dpi(8)
else
    theme.snap_border_width = dpi(theme.border_width * 2)
end

-- {{{ TAGLIST

-- Nerd Font icon here
theme.tagnames = {" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 10 "}
-- mini_taglist
--theme.taglist_text_occupied = {"","","ﲵ","ﱘ","","","","","","ﮊ"}
--theme.taglist_text_focused = {"","","ﲵ","ﱘ","","","","","","ﮊ"}
--theme.taglist_text_urgent = {"","","ﲵ","ﱘ","","","","","","ﮊ"}
--theme.taglist_text_empty = {"","","","","","","","","",""}

-- icon_taglist
local ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, ntags do
  theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
end

-- Text Taglist (default)
theme.taglist_font = "RobotoMono Nerd Font Mono 16"
theme.taglist_layout = wibox.layout.fixed.horizontal -- horizontal or vertical

-- }}} TAGLIST END

-- {{{ MENU

theme.menu_submenu_icon = themes_path.."theme_name../submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- }}} End MENU

theme.wallpaper = os.getenv("HOME") .. "/images/"..theme_name..".jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.grey_light, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = nil

-- {{{ Tasklist

theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
theme.tasklist_width = dpi(90)
theme.tasklist_shape = function(cr, width, height) gears.shape.transform(gears.shape.rounded_rect) : translate(0,40) (cr, width, -1, 4) end 
theme.tasklist_shape_border_width = 2
theme.tasklist_shape_border_color = "#8a0050"
theme.tasklist_shape_border_color_focus = "#af0366"
theme.tasklist_spacing = dpi(4)
theme.tasklist_align = "center"

-- }}} End Tasklist

-- {{{ WIDGET

theme.myfont = "RobotoMono Nerd Font"
theme.widget_icon_font = "RobotoMono Nerd Font Mono 13"
theme.widget_text_font = "RobotoMono Nerd Font 8"

-- popup
theme.widget_popup_padding = dpi(3)

-- Hostname
theme.widget_hostname_text_icon = '<span foreground="#948a77">  </span>'

-- Tor
theme.widget_tor_icon = "﨩"
theme.widget_tor_fg_enable = theme.fg_grey
theme.widget_tor_fg_disable = theme.fg_alert
theme.widget_tor_bg = theme.grey .. "00"
theme.widget_tor_layout = 'horizontal' -- horizontal or vertical

-- Mini ncmpcpp player
--
theme.widget_font = 'RobotoMono Nerd Font Mono 15'
theme.widget_ncmpcpp_prev = '<span foreground="'..theme.alert_dark..'"> ≪ </span>'
theme.widget_ncmpcpp_toggle = '<span foreground="'..theme.alert..'"> ⊡ </span>'
theme.widget_ncmpcpp_next = '<span foreground="'..theme.alert_dark..'"> ≫ </span>'

-- Mails
theme.widget_email_read_icon = ""
theme.widget_email_unread_icon = ""
theme.widget_email_fg_read = theme.fg_grey
theme.widget_email_fg_unread = theme.fg_grey_light
theme.widget_email_bg = theme.grey .. "ff"
theme.widget_email_layout = 'vertical' -- horizontal or vertical

-- Network
theme.widget_network_icon = ""
theme.widget_network_fg = theme.fg_grey
theme.widget_network_fg_error = theme.fg_alert
theme.widget_network_bg = theme.grey .. "00"
theme.widget_network_layout = 'horizontal' -- horizontal or vertical

-- Wifi str
theme.widget_wifi_str_fg = "#87aaaa"
theme.widget_wifi_str_bg = theme.grey .. "00"
theme.widget_wifi_layout = 'vertical' -- horizontal or vertical

-- RAM
theme.widget_ram_icon = ""
theme.widget_ram_fg = theme.fg_alert
theme.widget_ram_bg = theme.grey .. "ff"
theme.widget_ram_layout = 'vertical' -- horizontal or vertical

-- Battery
theme.widget_battery_icon_discharging = ""
theme.widget_battery_icon_charging = ""
theme.widget_battery_icon_full = ""
theme.widget_battery_icon_ac = "臘"
theme.widget_battery_fg = theme.fg_secondary
theme.widget_battery_bg = theme.grey .. "ff"
theme.widget_battery_layout = 'vertical' -- horizontal or vertical

-- mpc
theme.widget_mpc_prev_icon = ""
theme.widget_mpc_pause_icon = ""
theme.widget_mpc_play_icon = ""
theme.widget_mpc_stop_icon = ""
theme.widget_mpc_next_icon = ""
theme.widget_mpc_fg = theme.primary
theme.widget_mpc_bg = theme.grey .. "00"
theme.widget_mpc_layout = 'horizontal' -- horizontal or vertical

-- volume
theme.widget_volume_icon = ""
theme.widget_volume_fg = theme.fg_grey
theme.widget_volume_bg = theme.grey .. "00"
theme.widget_volume_layout = 'vertical' -- horizontal or vertical

-- Date
theme.widget_date_icon = ""
theme.widget_date_fg = theme.fg_grey
theme.widget_date_bg = theme.grey .. "00"
theme.widget_date_layout = 'vertical' -- horizontal or vertical

-- Screenshot
theme.widget_scrot_fg = theme.fg_grey
theme.widget_scrot_icon = '  '

-- Change theme
theme.widget_change_theme_bg = theme.grey_dark .. "00"
theme.widget_change_theme_fg = theme.fg_grey
theme.widget_change_theme_icon = ' 嗀'
theme.widget_change_theme_icon_reload = ' 勒'
theme.widget_change_theme_layout = 'vertical' -- horizontal or vertical

-- }}} End WIDGET

return theme
