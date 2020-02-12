local awful = require("awful")
local wibox = require("wibox")
local gtable = require("gears.table")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local widget = require("util.widgets")
local helpers = require("helpers")
local smartBorders = require("util.smart-borders")
local theme = require("loaded-theme")
local gshape = require("gears.shape")
--local naughty = require("naughty")

local smart_border = beautiful.double_border or false

-- import widget
local ncmpcpp = require("widgets.mpc")({ mode = "titlebar" })

local mbuttons = function(c)
  return gtable.join(
  awful.button({ }, 1, function()
    c:emit_signal("request::activate", "titlebar", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ }, 3, function()
    c:emit_signal("request::activate", "titlebar", { raise = true })
    awful.mouse.client.resize(c)
  end)
  )
end

local function if_titlebar_is_off(c)
  local client_off = { 'Brave-browser', 'Lutris', 'music_n' } -- from the rc.lua
  for _,v in pairs(client_off) do
    if v == c.class then
      return true 
    end
  end
  return false
end

-- check if beautiful.titlebar_title_enabled is true
local with_title_or_not = function(c, disable_title)
  local disable_title = disable_title or nil -- boolean
  if disable_title then
    return wibox.widget.textbox(" ")
  elseif beautiful.titlebar_title_enabled then
    return wibox.widget {
      align = "center", widget = awful.titlebar.widget.titlewidget(c)
    }
  else
    return
  end
end

local title_with_border = function(c, ...)
  local width = c.width / 3

  if beautiful.titlebar_internal_border then
    -- box_margin change border color if c.client is focus or not
    local w = wibox.widget {
      with_title_or_not(c, ...),
      bottom = 2,
      color = beautiful.titlebar_internal_border_colors[2], -- default color
      forced_width = dpi(width),
      widget = wibox.container.margin
    }
    c:connect_signal("unfocus", function(c)
      w.color = beautiful.titlebar_internal_border_colors[2]
    end)
    c:connect_signal("focus", function(c)
      w.color = beautiful.titlebar_internal_border_colors[1]
    end)

    return wibox.widget {
      nil,
      w,
      expand = "none",
      layout = wibox.layout.align.horizontal
    }
  else
    return with_title_or_not(c, ...)
  end
end
  
local mytitle = function(c)
  if if_titlebar_is_off(c) then return wibox.widget{} end

  if beautiful.double_border then -- we need go down the title
    local width = c.width / 5
    return wibox.widget {
      {
        {
          title_with_border(c),
          right = dpi(width), left = dpi(width),
          widget = wibox.container.margin,
        },
        buttons = mbuttons(c),
        layout  = wibox.layout.flex.horizontal,
      },
      top = dpi(30), -- TODO: test on other themes with other font
      widget = wibox.container.margin,
      layout = wibox.layout.flex.vertical,
    }
  else -- display the default bar
    return wibox.widget {
      title_with_border(c),
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    }
  end
end

-- functions for windows
local window_close = function(c)
  c:kill()
end

-- if buttons are enable
local gen_button = function(c, icon, fg, cmd)
  local button = widget.base_icon()
  local r_margin = 0
  local r_top = 0
  button.markup = helpers.colorize_text(icon, fg)

  button:buttons(gtable.join(
    awful.button({}, 1, function()
      cmd(c)
    end)
  ))

  if smart_border then
    r_margin = dpi(11)
    r_top = dpi(4)
  else
    r_margin = dpi(8)
    r_top = dpi(0)
  end

  if if_titlebar_is_off(c) then return wibox.widget{} end

  if beautiful.titlebar_buttons_enabled then
    return wibox.widget {
      nil,
      {
        button,
        top = r_top,
        right = r_margin,
        widget = wibox.container.margin
      },
      nil,
      layout = wibox.layout.fixed.horizontal
    }
  else
    return button
  end
end

client.connect_signal("request::titlebars", function(c)

  -- the titlebar work only on top for now with double_border enable !
  local position = beautiful.titlebar_position or 'top'

  -- if titlebars_imitate_borders are enabled
  if beautiful.titlebars_imitate_borders then
    helpers.create_titlebar(c, buttons, "top", beautiful.titlebars_imitate_borders_size)
    helpers.create_titlebar(c, buttons, "bottom", beautiful.titlebars_imitate_borders_size)
    helpers.create_titlebar(c, buttons, "left", beautiful.titlebars_imitate_borders_size)
    helpers.create_titlebar(c, buttons, "right", beautiful.titlebars_imitate_borders_size)
  end

  -- bottom bar for ncmpcpp
  if c.class == "music_n" and theme.name ~= "machine" then
    awful.titlebar(c, {
      font = beautiful.titlebar_font, position = "bottom", size = dpi(50)
    }) : setup { 
      nil,
      ncmpcpp,
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    }
  end

  -- add a titlebar if titlebars_enabled is true
  if beautiful.titlebars_enabled then
    awful.titlebar(c, { size = beautiful.titlebar_size, position = position }) : setup {
      { -- Left
        --awful.titlebar.widget.iconwidget(c),
        buttons = mbuttons(c),
        layout  = wibox.layout.fixed.horizontal
      },
      {
        mytitle(c),
        buttons = mbuttons(c),
        layout  = wibox.layout.flex.horizontal
      },
      { -- Right
        --awful.titlebar.widget.floatingbutton (c),
        --awful.titlebar.widget.maximizedbutton(c),
        --awful.titlebar.widget.stickybutton   (c),
        --awful.titlebar.widget.ontopbutton    (c),
        gen_button(c, '', beautiful.alert, window_close),
        layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.align.horizontal
    }

    -- add an additional internal border on non floating client
    if c.floating ~= true and beautiful.titlebar_internal_border then
      awful.titlebar(c, { size = beautiful.titlebar_size, position = "bottom" }) : setup {
        nil,
        {
          title_with_border(c, true),
          buttons = mbuttons(c),
          layout  = wibox.layout.flex.horizontal
        },
        nil,
        layout = wibox.layout.align.horizontal
      }
    end
  end
end)

-- Add the smart_border if enable
if smart_border then
  client.connect_signal("request::titlebars", function(c) smartBorders.set(c, true) end)
  client.connect_signal("property::size", smartBorders.set)
end
