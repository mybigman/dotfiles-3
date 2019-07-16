local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")

-- beautiful vars
local fg_read = beautiful.widget_email_fg_read
local fg_unread = beautiful.widget_email_fg_unread
local bg = beautiful.widget_email_bg
local l = beautiful.widget_email_layout or 'horizontal'
local w_type = beautiful.widget_email_type or 'text'
local padding = beautiful.widget_popup_padding or 1

local read_icon = w_type == 'button' and " "..beautiful.widget_email_read_icon.." "
  or beautiful.widget_email_read_icon
local unread_icon = w_type == 'button' and " "..beautiful.widget_email_unread_icon.." "  or beautiful.widget_email_unread_icon

-- colour
local d_grey = beautiful.grey_dark or "#222222"
local fg_grey = beautiful.fg_grey or "#a9a9a9"

-- widget creation
local icon
if w_type == 'button' then
  icon = widget.create_text(unread_icon, fg_unread, "Iosevka Term 16")
else
  icon = widget.base_icon()
  icon.markup = helpers.colorize_text(unread_icon, fg_unread)
end

local icon_margin = widget.icon(icon)
local text = widget.base_text()
local text_margin = widget.text(text)

local email_widget = w_type == 'button' and icon 
  or widget.box(l, icon_margin, text_margin)

local popup_msg = widget.base_text()
local w = awful.popup {
  widget = {
    {
      layout = wibox.layout.align.horizontal
    },
    {
      {
        popup_msg,
        layout = wibox.layout.align.horizontal
      },
      margins = 10,
      widget = wibox.container.margin
    },
    {
      layout = wibox.layout.align.horizontal
    },
    layout = wibox.layout.fixed.horizontal
  },
  visible = false,
  ontop = true,
  hide_on_right_click = true,
  offset = { y = padding, x = padding },
  bg = d_grey
}

w:bind_to_widget(email_widget)

-- tooltip if beautiful.widget_email_type = 'button' is used
local tt
if w_type == 'button' then
  tt = awful.tooltip {
    markup = 0,
    visible = false,
    objects = { email_widget }
  }
end

local grab_emails_script = [[
  bash -c "
  ~/.config/awesome/widgets/email.sh get ~/.mails
"]]

awful.widget.watch(grab_emails_script, 300, -- 5m
  function(widget, stdout, stderr, exitreason, exitcode)
    local filter_mail = stdout:match('%d+')
    local mail_num = tonumber(filter_mail) or 0
    if (mail_num > 0) then
      icon.markup = helpers.colorize_text(read_icon, fg_read)
      text.markup = helpers.colorize_text(filter_mail, fg_read)
      tt.markup = helpers.colorize_text("You got "..filter_mail.." messages", fg_read)
    else
      icon.markup = helpers.colorize_text(unread_icon, fg_unread)
      text.markup = helpers.colorize_text(0, fg_read)
      tt.markup = helpers.colorize_text("No new messages", fg_read)
    end
  end
)

local show_emails_script = [[
  bash -c "
  ~/.config/awesome/widgets/email.sh show ~/.mails
"]]

local function update_popup()
  awful.widget.watch(show_emails_script, 150, function(widget, stdout)
    local message = stdout:match('From[:]+%s*([%w%s@]*)')
    local message = "From: "..message or 'No new messages'

    popup_msg.markup = helpers.colorize_text(message, fg_grey)

  end)
end

update_popup()

return email_widget
