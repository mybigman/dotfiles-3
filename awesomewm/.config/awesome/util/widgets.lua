local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")

local widgets = {}

function widgets.create_text(text, fg, font)
  local w = widgets.create_base_text(font)
  w.markup = helpers.colorize_text(text, fg)
  return w
end

function widgets.create_base_text(font)
  return wibox.widget {
    align  = 'center',
    valign = 'center',
    font = font,
    widget = wibox.widget.textbox
  }
end

function widgets.base_icon()
  local font = beautiful.widget_icon_font or "Iosevka Term Regular 11" 
  return widgets.create_base_text(font)
end

function widgets.base_text()
  local font = beautiful.widget_text_font or "Iosevka Term Regular 9" 
  return widgets.create_base_text(font)
end

function widgets.icon(w)
  return wibox.widget {
    w,
    right = 4,
    left = 2,
    widget = wibox.container.margin
  }
end

function widgets.text(w)
  return wibox.widget {
    w,
    right = 2,
    widget = wibox.container.margin
  }
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
      w1, w2, w3,
      layout = _layout
    }
  elseif ( w2 ~= nil ) then
    widget = wibox.widget {
      w1, w2,
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

local function icon_plus_text_size(w)
  return {
    w,
    left = 10, right = 10, top = 3, bottom = 3,
    widget = wibox.container.margin
  }
end

local function icon_size(w)
  return {
    w,
    left = 9, right = 9, top = 9, bottom = 9,
    widget = wibox.container.margin
  }
end

function widgets.bg_rounded(bg_color, border_color, w, widget_type)
  local mtype
  if ( widget_type ~= nil and widget_type == "button" ) then
    mtype = icon_size(w)
  else
    mtype = icon_plus_text_size(w)
  end
  return wibox.widget {
    {
      mtype,
      shape = gears.shape.rounded_rect,
      bg = bg_color,
      shape_border_color = border_color,
      shape_border_width = 2,
      widget = wibox.container.background
    },
    layout = wibox.layout.fixed.horizontal
  }
end

function widgets.bg_border_line(bg_color, border_color, w, widget_type)
  local mtype
  local shape_line = function(cr, width, height) 
    gears.shape.transform(gears.shape.rounded_rect) : translate(0,20) (cr,width, -1, 2) 
  end
  if ( widget_type ~= nil and widget_type == "button" ) then
    mtype = icon_size(w)
  else
    mtype = icon_plus_text_size(w)
  end
  return wibox.widget {
    {
      mtype,
      shape = shape_line,
      bg = bg_color,
      shape_border_color = border_color,
      shape_border_width = 2,
      widget = wibox.container.background
    },
    layout = wibox.layout.fixed.horizontal
  }
end

function widgets.bg(bg_color, w)
  return wibox.widget {
    {
      w,
      bg     = bg_color,
      widget = wibox.container.background
    },
    spacing = 10,
    layout  = wibox.layout.fixed.horizontal
  }
end

function widgets.border_bottom(w, colour)
  return wibox.widget {
    w,
    bottom = 2,
    color = colour,
    widget = wibox.container.margin
  }
end

function widgets.for_one_icon(fg, bg, icon, font)
  local w = widgets.create_text(icon, fg, font)
  return wibox.widget {
    w,
    bg = bg,
    widget = wibox.container.background
  }
end

function widgets.circle(w, background)
  return wibox.widget {
    w,
    bg = background,
    shape_clip = true,
    shape = gears.shape.circle,
    widget = wibox.container.background
  }
end

function widgets.circle_padding(w, space)
  return {
    w,
    spacing = space,
    layout  = wibox.layout.fixed.horizontal
  }
end

function widgets.update_background(w, background)
  w:set_shape(gears.shape.circle) -- otherwise there's no borders
  w:set_shape_border_width(2)
  w:set_shape_border_color(background)
end

return widgets
