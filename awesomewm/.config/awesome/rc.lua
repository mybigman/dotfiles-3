-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

-- Function to create object in lua - used globally
-- return the init function of each class
local function new(self, ...)
  local instance = setmetatable({}, { __index = self })
  return instance:init(...) or instance
end

-- Function to create object in lua - used globally
function class(base)
  return setmetatable({ new = new }, { __call = new, __index = base })
end

-- {{{ Variable definitions
env = require("env-config") -- user settings globally

-- Themes define colours, icons, font and wallpapers.
local theme = require("loaded-theme")

require("module.notifications")
require("layouts.start_screen")
require("layouts.lock_screen")
require("layouts.app_drawer")
require("module.layout")
require("module.menu")

-- Start daemons
require("daemons")

-- {{{ For each screen
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  require("module.wallpaper")(s)

  -- add padding on all screens
  s.padding = beautiful.general_padding

  -- Each screen has its own tag table.
  require("module.tagnames")(s)

  -- Create the wibox
  require("bars."..theme.name)(s)

  -- Monitor bar
  require("layouts.monitor_bar")(s)
end)
-- }}}

require("module.rules")
require("module.titlebar")
require("module.signals")
require("module.autostart")

naughty.notify({ text = "theme "..theme.name.." is loaded" })
