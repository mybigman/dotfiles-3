local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local gshape = require("gears.shape")
local gtable = require("gears.table")
local awful = require("awful")
local env = require("env-config")
local naughty = require("naughty")
local separator = require("util.separators")
local dpi = require("beautiful").xresources.apply_dpi

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

function widgets.create_title(text, fg)
  local font = beautiful.widget_title_font or "Iosevka Term Bold 10" 
  local w = widgets.create_base_text(font)
  w.markup = helpers.colorize_text(text, fg)
  return w
end

function widgets.box(l, widgets, space)
  local spacing = space or 0
  local _layout = wibox.layout.fixed.horizontal -- default horiz
  if l == "vertical" then _layout = wibox.layout.fixed.vertical end

  local w = wibox.widget { layout = _layout, spacing = spacing } -- init a widget
  for _, widget in ipairs(widgets) do
    w:add(widget)
  end

  return w
end

function widgets.box_with_margin(l, ws, space)
  local w = widgets.box(l, ws, space)
  return wibox.widget {
    w,
    left = 5, right = 5,
    widget = wibox.container.margin
  }
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
      shape = gshape.rounded_rect,
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
    gshape.transform(gshape.rounded_rect) : translate(0,20) (cr,width, -1, 2) 
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

function widgets.left_margin(w, size)
  local size = size or 10
  return wibox.widget {
    w,
    left = dpi(size),
    widget = wibox.container.margin
  }
end

function widgets.create_button(fg, icon, fg_hover)
  local font = beautiful.widget_icon_font_button or 'Iosevka Term 16'
  local w = widgets.create_text(icon, fg, font)
  w.align = 'left'
  w.valign = 'center'
  return w
end

function widgets.for_one_icon(fg, bg, icon, font)
  local w = widgets.create_text(icon, fg, font)
  return wibox.widget {
    w,
    bg = bg,
    widget = wibox.container.background
  }
end

function widgets.circle(w, background, color_shape)
  local w_shape = color_shape or nil
  local w_width = 0  
  if w_shape then
    w_width = 1
  end

  return wibox.widget {
    w,
    bg = background,
    shape_clip = true,
    shape = gshape.circle,
    spacing = 4,
    shape_border_color = w_shape,
    shape_border_width = w_width,
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
  w:set_shape(gshape.circle) -- otherwise there's no borders
  w:set_shape_border_width(2)
  w:set_shape_border_color(background)
end

-- used to create an imagebox, argument image is optionnal
function widgets.imagebox(size, image)
  local w = wibox.widget {
    resize = true,
    forced_height = size,
    forced_width = size,
    widget = wibox.widget.imagebox
  }
  if image ~= nil then w.image = image end
  return w
end

function widgets.add_left_click_action(w, action, shell)
  local s = shell or 'noshell' -- noshell (or any word) will prompt a terminal
  if s == 'shell' then
    s = awful.spawn
  else
    s = awful.spawn
  end
  
  w:buttons(gtable.join(
    awful.button({ }, 1, function()
      if s == 'shell' then
        s(action)
      else
        s(env.term .. env.term_call[1] .. 'miniterm' .. env.term_call[2] .. action)
      end
    end)
  ))
end

-- Create a slider
function widgets.make_a_slider(default_value)
  local v = default_value or 15
  return wibox.widget {
    forced_height = dpi(8),
    bar_shape = gshape.rounded_rect,
    bar_height = dpi(5),
    bar_color = beautiful.primary_dark,
    handle_color = beautiful.alert,
    handle_shape = gshape.circle,
    handle_border_color = '#00000012',
    handle_border_width = dpi(3),
    value = v,
    widget = wibox.widget.slider
  }
end

-- add icon, padding and layout to a slider
function widgets.add_icon_to_slider(slider, icon, fg_icon, layout)
  local pad = separator.pad(2)
  local ic = widgets.base_icon()
  ic.markup = helpers.colorize_text(icon, fg_icon)
  return widgets.box(layout, { ic, pad, slider })
end

-- check popup position
function widgets.check_popup_position(wibar_position)
  local wpos = wibar_position or 'top'
  local position = 'top' -- default is top
  if wpos == 'top' then
    position = 'bottom' 
  elseif wpos == 'left' then
    position = 'right'
  elseif wpos == 'right' then
    position = 'left'
  end
  return position
end

function widgets.make_arcchart(w)
  local w = w or nil
  return wibox.widget {
    widget = wibox.container.arcchart,
    bg = beautiful.primary_dark,
    border_color = beautiful.alert_dark,
    colors = { beautiful.alert_light, beautiful.primary_light },
    max_value = 99,
    min_value = 0,
    paddings = 2,
    value = 1,
    --rounded_edge = true,
    forced_height = dpi(150),
    forced_width = dpi(150),
    thickness = dpi(4),
    start_angle = 4.71238898, -- 2pi*3/4
    w
  }
end

return widgets
