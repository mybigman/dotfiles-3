local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

local font_icon = beautiful.widget_icon_font or 'RobotoMono Nerd Font Mono 18'
local font_text = beautiful.widget_text_font or 'RobotoMono Nerd Font Mono 10'

local email_text_read_icon = beautiful.widget_email_text_read_icon or '<span foreground="#565b5e"></span>'
local email_text_unread_icon = beautiful.widget_email_text_unread_icon or '<span foreground="#434e4a"></span>'

email_icon = wibox.widget {
  widget = wibox.widget.textbox,
  font = font_icon
}

email_text = wibox.widget {
  widget = wibox.widget.textbox,
  valign = "center",
  font = font_text
}

-- watch() require full path of the script
awful.widget.watch(
  "bash /home/brakk/.config/awesome/widgets/email.sh get", 300, -- 5m
  function(widget, stdout, stderr, exitreason, exitcode)
    local unread_email_num = tonumber(stdout) or 0
    if (unread_email_num > 0) then
      email_icon:set_markup_silently (email_text_read_icon)
      email_text:set_text (stdout)
    elseif (unread_email_num == 0) then
      email_icon:set_markup_silently (email_text_unread_icon)
    end
  end
)

function show_emails()
  awful.spawn.easy_async([[bash -c '~/.config/awesome/widgets/email.sh show']],
  function(stdout, stderr, reason, exit_code)
    naughty.notify {
      text = stdout,
      title = "Unread mails from: ",
      timeout = 5, hover_timeout = 0.5,
      width = 200,
    }
  end)
end

email_icon:connect_signal("mouse::enter", function() show_emails() end)
