local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local separators = require("util.separators")
local keygrabber = require("awful.keygrabber")

local pad = separators.pad

local username = os.getenv("USER")
local goodbye_widget = wibox.widget.textbox("Goodbye " .. username:sub(1,1):upper() .. username:sub(2))

--exit,
--lock,

-- get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

exit_screen = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "dock", width = screen_width, height = screen_height })

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
          --lock,
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
