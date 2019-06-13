local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local fg_read = beautiful.widget_email_fg_read
local fg_unread = beautiful.widget_email_fg_unread
local read_icon = beautiful.widget_email_read_icon
local unread_icon = beautiful.widget_email_unread_icon
local bg = beautiful.widget_email_bg
local l = beautiful.widget_email_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon()
local text = widget.base_text()
local icon_margin = widget.icon(icon)
local text_margin = widget.text(text)
email_widget = widget.box(l, icon_margin, text_margin)

icon.markup = helpers.colorize_text(unread_icon, fg_unread)

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/email.sh get", 300, -- 5m
  function(widget, stdout, stderr, exitreason, exitcode)
    local filter_mail = stdout:match('%d+')
    local mail_num = tonumber(filter_mail) or 0
    if (mail_num > 0) then
      icon.markup = helpers.colorize_text(read_icon, fg_read)
      text.markup = helpers.colorize_text(filter_mail, fg_read)
    else
      icon.markup = helpers.colorize_text(unread_icon, fg_unread)
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
