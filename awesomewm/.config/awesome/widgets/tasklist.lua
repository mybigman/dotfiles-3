local gtable = require("gears.table")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- remove few symbols
beautiful.tasklist_plain_task_name=true

local tasklist_widget = {}

function tasklist_widget:buttons()
  local tasklist_buttons = gtable.join(
  awful.button({}, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))
  return tasklist_buttons
end

function tasklist_widget:template()
  local t = {
    {
      {
        {
          {
            id     = 'icon_role',
            widget = wibox.widget.imagebox,
          },
          margins = 2,
          widget  = wibox.container.margin,
        },
        {
          id     = 'text_role',
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      left  = 5,
      right = 5,
      top = 5,
      bottom = 5,
      widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background
  }
  return t
end

function tasklist_widget:new(s)
  local widget = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = self:buttons(),
    widget_template = self:template()
  }
  return widget
end

return setmetatable(tasklist_widget, {
  __call = tasklist_widget.new,
})
