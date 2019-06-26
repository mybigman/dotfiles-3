local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local separators = require("util.separators")
local keygrabber = require("awful.keygrabber")
local widgets = require("util.widgets")

local pad = separators.pad
local font_icon = "Iosevka Term Bold 63"
local font_icon_2 = "Iosevka Term Bold 64" -- for little icon to align the text :(
local font_text = "Iosevka Term Regular 11"

local username = os.getenv("USER")
local goodbye_text = "Goodbye " .. username:sub(1,1):upper() .. username:sub(2)
local goodbye_widget = widgets.create_text(goodbye_text, "#999999", "Iosevka Term Bold  20")

-- {{{ Poweroff part
local poweroff_command = function() 
  awful.spawn.with_shell("poweroff")
  keygrabber.stop(exit_screen_grabber)
end

local poweroff_icon = widgets.create_text("⭘", "#7d4c73", font_icon)
local poweroff_text = widgets.create_text("Poweroff", "#aaaaaa", font_text)
local poweroff = widgets.box("vertical", poweroff_icon, poweroff_text)
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

local exit_icon = widgets.create_text("ﴙ", "#6f5485", font_icon_2)
local exit_text = widgets.create_text("Exit", "#aaaaaa", font_text)
local exit = widgets.box("vertical", exit_icon, exit_text)
exit:buttons(gears.table.join(
  awful.button({ }, 1, function() 
    exit_command()
  end)
))
-- {{{ END Exit part

-- {{{ Lock part
local lock_command = function() 
  --awful.spawn.with_shell("i3lock")
  exit_screen_hide()
end

local lock_icon = widgets.create_text("", "#42446e", font_icon)
local lock_text = widgets.create_text("Lock", "#aaaaaa", font_text)
local lock = widgets.box("vertical", lock_icon, lock_text)
lock:buttons(gears.table.join(
  awful.button({ }, 1, function() 
    lock_command()
  end)
))
-- {{{ END Lock part

-- get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

exit_screen = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "dock", width = screen_width, height = screen_height, bg = "#0000004f" })

-- keylogger
local exit_screen_grabber

function exit_screen_hide()
  keygrabber.stop(exit_screen_grabber)
  exit_screen.visible = false
end

function exit_screen_show() 
  exit_screen_grabber = keygrabber.run(function(_, key, event)
    if event == "release" then return end
    if key == 'Escape' or key == 'q' or key == 'x' then
      exit_screen_hide()
    elseif key == 'p' then
      poweroff_command()
    elseif key == 'l' then
      lock_command()
    elseif key == 'e' then
      exit_command()
    end
  end)
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

exit_screen:setup {
  nil,
  {
    {
      nil,
      goodbye_widget,
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    {
      nil,
      {
        --{
          poweroff,
          pad(10),
          exit,
          pad(10),
          lock,
          layout = wibox.layout.fixed.horizontal
        --},
        --widget = exit_screen_box
      },
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
      --layout = wibox.layout.fixed.horizontal
    },
    layout = wibox.layout.fixed.vertical
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.vertical
}
