local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local dpi = require('beautiful').xresources.apply_dpi

-- beautiful vars
local tor_icon = beautiful.widget_tor_icon
local fg_enable = beautiful.widget_tor_fg_enable
local fg_disable = beautiful.widget_tor_fg_disable
local bg = beautiful.widget_tor_bg
local padding = beautiful.widget_popup_padding or dpi(1)

-- images
local toron_img = beautiful.widget_tor_on
local toroff_img = beautiful.widget_tor_off
local torstart_img = beautiful.widget_tor_start
local torstop_img = beautiful.widget_tor_stop
local torrestart_img = beautiful.widget_tor_restart

-- material colors
local g_dark = beautiful.grey_dark or "#222222"
local g = beautiful.grey or "#333333"
local g_light = beautiful.grey_light or "#444444"

-- widget creation
local tor_widget = widget.for_one_icon(fg_enable, bg, tor_icon, "Iosevka Term 16")
local tor_run = false -- boolean
local sep = widget.base_text()
sep.markup = helpers.colorize_text("---", g_light)

-- popup
local popup_image = wibox.widget {
  resize = true,
  forced_height = 80,
  forced_width = 80,
  widget = wibox.widget.imagebox
}


-- button (to use the systemd service) (restart tor change your ip address)
local little_icon_size = 18

local button_start = widget.imagebox(torstart_img, little_icon_size) 
widget.add_left_click_action(button_start, "sudo systemctl start tor")

local button_stop = widget.imagebox(torstop_img, little_icon_size)
widget.add_left_click_action(button_stop, "sudo systemctl stop tor")

local button_restart = widget.imagebox(torrestart_img, little_icon_size)
widget.add_left_click_action(button_restart, "sudo systemctl restart tor")

-- To display informations about your ip
local popup_ip = widget.base_text()
local popup_region = widget.base_text()
local popup_country = widget.base_text()
local popup_hostname = widget.base_text()
local w = awful.popup {
  widget = {
    {
      {
        popup_image,
        layout = wibox.layout.align.horizontal
      },
      {
        {
          {
            {
              popup_ip,
              popup_region,
              popup_country,
              popup_hostname,
              layout = wibox.layout.fixed.vertical
            },
            margins = 10,
            widget = wibox.container.margin
          },
          bg = g,
          widget = wibox.container.background
        },
        {
          {
            button_start,
            sep,
            button_stop,
            sep,
            button_restart,
            layout = wibox.layout.fixed.vertical
          },
          top = 3,
          left = 6,
          right = 3,
          widget = wibox.container.margin
        },
        layout = wibox.layout.align.horizontal
      },
      layout = wibox.layout.align.horizontal
    },
    margins = 10,
    widget = wibox.container.margin
  },
  visible = false,
  ontop = true,
  hide_on_right_click = true,
  offset = { y = padding, x = padding },
  bg = g_dark
}

-- attach popup
w:bind_to_widget(tor_widget)

local tor_is_working_script = [[
  bash -c "
  ~/.config/awesome/widgets/tor.sh check
"]]

awful.widget.watch(tor_is_working_script, 20,
function(widget, stdout, stderr, exitreason, exitcode)
  local code = tonumber(stdout) or 1
  if (code == 0) then
    tor_run = true
    popup_image.image = toron_img
  else
    tor_run = false
    popup_image.image = toroff_img
  end
end)

local tor_infos_script = [[
  bash -c "
  ~/.config/awesome/widgets/tor.sh ip
"]]

local function update_popup() 
  awful.widget.watch(tor_infos_script, 180, function(widget, stdout)
    local ip, city, region, country, hostname = stdout:match('"(.*)"%s*"(.*)"%s*"(.*)"%s*"(.*)"%s*"(.*)"')
    local msg

    if tor_run == true then
      msg = 'Rate limit exceeded.'
    else
      msg = 'TOR is not running.'
    end

    ip = ip or msg
    city = city or msg
    country = country or msg
    hostname = hostname or msg

    popup_ip.markup = helpers.colorize_text("ip: "..ip, "#ff0000")
    popup_region.markup = helpers.colorize_text("city: "..city, "#f0f000")
    popup_country.markup = helpers.colorize_text("country: "..country, "#f000f0")
    popup_hostname.markup = helpers.colorize_text("hostname: "..hostname, "#00f000")
  end
  )
end

update_popup()

return tor_widget
