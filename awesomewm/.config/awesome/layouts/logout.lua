local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local separators = require("util.separators")
local keygrabber = require("awful.keygrabber")
local widgets = require("util.widgets")

local pad = separators.pad
local font_icon = "Iosevka Term Bold 63"
local font_text = "Iosevka Term Regular 11"

local username = os.getenv("USER")
local goodbye_text = "Goodbye " .. username:sub(1,1):upper() .. username:sub(2)
local goodbye_widget = widgets.create_text(goodbye_text, "#999999", "Iosevka Term Bold  20")

--exit,

-- {{{ Lock part
local lock_command = function() 
  --awful.spawn.with_shell("i3lock")
  exit_screen_hide()
end

local lock_icon = widgets.create_text("", "#aaaaaa", font_icon)
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

exit_screen = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "dock", width = screen_width, height = screen_height, bg = "#0000008f" })

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
          --exit,
          pad(3),
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
