local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local separators = require("util.separators")
local keygrabber = require("awful.keygrabber")
local widgets = require("util.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")

local pad = separators.pad
local font_icon = beautiful.myfont .. " Bold 63"
local font_icon_2 = beautiful.myfont .. " Bold 64" -- to scale little icon with text
local font_text = beautiful.myfont .. " Regular 11"

-- keylogger
local exit_screen_grabber

function exit_screen_hide()
  keygrabber.stop(exit_screen_grabber)
  exit_screen.visible = false
end

-- {{{ Poweroff part
local poweroff_command = function() 
  --awful.spawn.with_shell("sudo systemctl poweroff")
  awful.spawn("sudo systemctl poweroff")
  exit_screen_hide()
end

local poweroff_icon = widgets.create_text("⭘", beautiful.alert_dark, font_icon)
local poweroff_text = widgets.create_text("<b>P</b>oweroff", "#aaaaaa", font_text)
local poweroff = widgets.box("vertical", { poweroff_icon, poweroff_text })
poweroff:buttons(gears.table.join(
  awful.button({ }, 1, function() 
    poweroff_command()
  end)
))
-- {{{ END Poweroff part

-- {{{ Exit part
local exit_command = function() 
  awesome.quit()
end

local exit_icon = widgets.create_text("ﴙ", beautiful.secondary_dark, font_icon_2)
local exit_text = widgets.create_text("<b>E</b>xit", "#aaaaaa", font_text)
local exit = widgets.box("vertical", { exit_icon, exit_text })
exit:buttons(gears.table.join(
  awful.button({ }, 1, function() 
    exit_command()
  end)
))
-- {{{ END Exit part

-- {{{ Lock part
local lock_command = function() 
  exit_screen_hide()
  lock_screen_show()
end

local lock_icon = widgets.create_text("", beautiful.primary_dark, font_icon)
local lock_text = widgets.create_text("<b>L</b>ock", "#aaaaaa", font_text)
local lock = widgets.box("vertical", { lock_icon, lock_text })
lock:buttons(gears.table.join(
  awful.button({ }, 1, function() 
    lock_command()
  end)
))
-- {{{ END Lock part

-- get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

exit_screen = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "dock" })
exit_screen.bg = beautiful.grey_dark .. "00"
exit_screen.width = screen_width
exit_screen.height = screen_height

function exit_screen_show()
  local grabber = keygrabber {
    keybindings = {
      { {}, 'p', function() poweroff_command() end },
      { {}, 'e', function() exit_command() end },
      { {}, 'l', function() lock_command() end },
      { {}, 'q', function() exit_screen_hide() end },
    },
    stop_key = "Escape",
    stop_callback = function() exit_screen_hide() end,
  }

  if grabber.is_running and exit_screen.visible == false then
    grabber:stop()
  elseif exit_screen.visible == false then
    grabber:stop()
  end

  grabber:start()
  exit_screen.visible = true
end

-- buttons
exit_screen:buttons(gears.table.join(
  -- Middle click - Hide exit_screen
  awful.button({ }, 2, function ()
    exit_screen_hide()
  end),
  -- Right click - Hide exit_screen
  awful.button({ }, 3, function ()
    exit_screen_hide()
  end)
))

local function bg_hover(w)
  local wbg = wibox.container.background()
  wbg.shape = helpers.rrect(14)
  wbg.bg = beautiful.grey_dark
  wbg:connect_signal("mouse::leave", function(c)
    wbg.bg = beautiful.grey_dark
  end)
  wbg:connect_signal("mouse::enter", function(c)
    wbg.bg = beautiful.grey
  end)
  return wibox.widget {
    {
      w,
      top = 10,
      left = 20,
      right = 20,
      bottom = 20,
      widget = wibox.container.margin
    },
    widget = wbg
  }
end

exit_screen:setup {
  nil,
  {
    {
      nil,
      {
        {
          {
            nil,
            {
              bg_hover(poweroff),
              bg_hover(exit),
              bg_hover(lock),
              spacing = 8,
              layout = wibox.layout.fixed.horizontal
            },
            expand = "none",
            layout = wibox.layout.align.vertical
          },
          margins = 18,
          widget = wibox.container.margin
        },
        shape = helpers.rrect(18),
        bg = beautiful.grey_dark,
        widget = wibox.container.background
      },
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    layout = wibox.layout.fixed.vertical
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.vertical
}
