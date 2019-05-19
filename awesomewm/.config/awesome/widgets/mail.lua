local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")

-- beautiful vars
local fg_read = beautiful.widget_email_fg_read
local fg_unread = beautiful.widget_email_fg_unread
local read_icon = beautiful.widget_email_read_icon
local unread_icon = beautiful.widget_email_unread_icon
local bg = beautiful.widget_email_bg
local l = beautiful.widget_email_layout or 'horizontal'

-- local str
local email_text_read_icon = '<span foreground="'..fg_read..'">'..read_icon..'</span>'
local email_text_unread_icon = '<span foreground="'..fg_unread..'">'..unread_icon..'</span>'

-- widget creation
local icon = widget.base_icon(bg, unread_icon)
local text = widget.base_text(bg, ' ')
local icon_margin = widget.icon(bg, icon)
local text_margin = widget.text(bg, text)
email_widget = widget.box(l, icon_margin, text_margin)

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/email.sh get", 300, -- 5m
  function(widget, stdout, stderr, exitreason, exitcode)
    local unread_email_num = tonumber(stdout) or 0
    if (unread_email_num > 0) then
      icon:set_markup_silently(email_text_read_icon)
      text:set_markup_silently('<span>'..stdout..'</span>')
    elseif (unread_email_num == 0) then
      icon:set_markup_silently(email_text_unread_icon)
    end
  end
)

function show_emails()
  awful.spawn.easy_async(os.getenv("HOME").."/.config/awesome/widgets/email.sh show",
  function(stdout, stderr, reason, exit_code)
    naughty.notify {
      text = stdout,
      title = "Unread mails from: ",
      timeout = 5, hover_timeout = 0.5,
      width = 200,
    }
  end)
end

email_widget:connect_signal("mouse::enter", function() show_emails() end)
