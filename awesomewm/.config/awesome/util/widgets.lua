local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

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
    --top = 2, -- value depend on the font height
    --bottom = 2, -- value depend on the font height
    right = 2,
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
    --top = 2, -- value depend on the font height
    --bottom = 2, -- value depend on the font height
    right = 2,
    color = bg,
    widget = wibox.container.margin
  }
  return widget
end

function widgets.box(l, w1, w2, w3)
  local widget
  local _layout
  if ( l ~= nil and l == "vertical" ) then
    _layout = wibox.layout.fixed.vertical
  else
    _layout = wibox.layout.fixed.horizontal
  end

  if ( w3 ~= nil ) then
    widget = wibox.widget {
      w1,
      w2,
      w3,
      layout = _layout
    }
  elseif ( w2 ~= nil ) then
    widget = wibox.widget {
      w1,
      w2,
      layout = _layout
    }
  else
    widget = wibox.widget {
      w1,
      layout = _layout
    }
  end
  return widget
end

function widgets.bg_rounded(bg_color, border_color, w)
  return wibox.widget {
    {
      {
        w,
        left = 10,
        right = 10,
        top = 3,
        bottom = 3,
        widget = wibox.container.margin
      },
      shape = gears.shape.rounded_rect,
      bg = bg_color,
      shape_border_color = border_color,
      shape_border_width = 2,
      widget = wibox.container.background
    },
    layout = wibox.layout.fixed.horizontal
  }
end

return widgets
