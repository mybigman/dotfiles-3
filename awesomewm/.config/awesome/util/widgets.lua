local wibox = require("wibox")
local beautiful = require("beautiful")

local widgets = {}

function widgets.base_icon(bg, icon)
  local bg = bg or beautiful.xbackground
  local icon = icon or ''
  local icon_widget = wibox.widget {
    markup = '<span background="'..bg..'">'..icon..'</span>',
    align  = 'center',
    valign = 'center',
    font = beautiful.widget_icon_font,
    widget = wibox.widget.textbox
  }
  return icon_widget
end

function widgets.base_text(bg, text)
  local bg = bg or beautiful.xbackground
  local text = text or ''
  local text_widget = wibox.widget {
    markup = '<span background="'..bg..'">'..text..'</span>',
    align  = 'center',
    valign = 'center',
    font = beautiful.widget_text_font,
    widget = wibox.widget.textbox
  }
  return text_widget
end

function widgets.icon(bg, icon_widget)
  local bg = bg or beautiful.xbackground
  local widget = wibox.widget {
    icon_widget,
    top = 5, -- value depend on the font height
    bottom = 5, -- value depend on the font height
    right = 6,
    left = 2,
    color = bg,
    widget = wibox.container.margin
  }
  return widget
end

function widgets.text(bg, text_widget)
  local bg = bg or beautiful.xbackground
  local widget = wibox.widget {
    text_widget,
    top = 5, -- value depend on the font height
    bottom = 5, -- value depend on the font height
    right = 2,
    color = bg,
    widget = wibox.container.margin
  }
  return widget
end

function widgets.box(w1, w2, w3)
  local widget
  if ( w3 ~= nil ) then
    widget = wibox.widget {
      w1,
      w2,
      w3,
      layout = wibox.layout.fixed.horizontal
    }
  elseif ( w2 ~= nil ) then
    widget = wibox.widget {
      w1,
      w2,
      layout = wibox.layout.fixed.horizontal
    }
  else
    widget = wibox.widget {
      w1,
      layout = wibox.layout.fixed.horizontal
    }
  end
  return widget
end

return widgets
