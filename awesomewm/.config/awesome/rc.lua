-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Variable definitions
env = require("env-config") -- user settings globally

-- Themes define colours, icons, font and wallpapers.
local theme = require("loaded-theme")
naughty.notify({ text = "theme "..theme.name.." is loaded" })

require("notifications")

local keys = require("keys")
local helpers = require("helpers")
local start_screen = require("layouts.start_screen")

require("layouts.sidebar")
require("layouts.lock_screen")

-- Start daemons
require("daemons")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Get screen geometry
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  awful.layout.suit.corner.ne,
  awful.layout.suit.corner.sw,
  awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu

local mymainmenu = require("menu")

-- Menubar configuration
terminal = env.term
menubar.utils.terminal = env.term -- Set the terminal for applications that require it
-- }}}

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    -- Method 1: Built in function
    --gears.wallpaper.maximized(wallpaper, s, true)

    -- Method 2: Set theme's wallpaper with feh
    awful.spawn.with_shell("feh --bg-fill " .. wallpaper)

    -- Method 3: Set last wallpaper with feh
    --awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- add padding on all screens
  s.padding = beautiful.general_padding

  -- Each screen has its own tag table.
  --awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
  local l = awful.layout.suit -- Alias to save time :)
  -- local layouts = { l.max, l.floating, l.max, l.max , l.tile,
  --     l.max, l.max, l.max, l.floating, l.tile}
  local layouts = { 
    l.tile, l.max, l.tile, l.floating , l.max,
    l.tile, l.tile, l.tile, l.max, l.max
  }

  -- Tag names
  local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }

  -- Create tags
  awful.tag.add(tagnames[1], {
    layout = layouts[1],
    screen = s,
    gap_single_client  = false,
    selected = true,
  })
  awful.tag.add(tagnames[2], {
    layout = layouts[2],
    gap_single_client  = false,
    screen = s,
  })
  awful.tag.add(tagnames[3], {
    layout = layouts[3],
    master_width_factor = 0.34,
    --gap = 4,
    column_count = 2,
    screen = s,
  })
  awful.tag.add(tagnames[4], {
    layout = layouts[4],
    master_width_factor = 0.6,
    screen = s,
  })
  awful.tag.add(tagnames[5], {
    layout = layouts[5],
    gap_single_client  = false,
    screen = s,
  })
  awful.tag.add(tagnames[6], {
    layout = layouts[6],
    gap = 40,
    screen = s,
  })
  awful.tag.add(tagnames[7], {
    layout = layouts[7],
    gap = 4,
    screen = s,
  })
  awful.tag.add(tagnames[8], {
    layout = layouts[8],
    master_width_factor = 0.33,
    gap = 3,
    column_count = 2,
    screen = s,
  })
  awful.tag.add(tagnames[9], {
    layout = layouts[9],
    screen = s,
  })
  awful.tag.add(tagnames[10], {
    layout = layouts[10],
    screen = s,
  })
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

local function in_percent(size, coord)
  local value = 0
  -- if x , use width screen
  if coord == 'x' then
    value = screen_width / 100 * size
  -- if y, use height screen
  else
    value = screen_height / 100 * size
  end
  return value
end

-- Create the gravity system like subtlewm
function like_subtle(gravities) -- args: x, y, width, height
  local x = in_percent(gravities[1], 'x')
  local y = in_percent(gravities[2], 'y')
  local width = in_percent(gravities[3], 'x')
  local height = in_percent(gravities[4], 'y')
  return  { floating = true, width = width, height = height, x = x, y = y }
end

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.clientkeys,
      buttons = keys.clientbuttons,
      screen = awful.screen.preferred,
      size_hints_honor = false,
      honor_workarea = true,
      honor_padding = true,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
    },
    class = {
      "mpv",
      "Gpick",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Wpa_gui",
      "pinentry",
      "veromix",
      "xtightvncviewer"
    },

    name = {
      "Event Tester",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    },
    type = {
      "dialog",
    }
  }, properties = { floating = true }},

  -- On top
  {
    rule_any = {
      class = {
        "Rofi",
        "mpv",
      },
    },
    properties = {
      ontop = true,
    },
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
  },

  -- Titlebars OFF
  { rule_any = {
    class = {
      "Brave-browser",
      "Lutris"
    },
  }, properties = { },
  callback = function(c)
    awful.titlebar.hide(c,"top")
    awful.titlebar.hide(c,"bottom")
    awful.titlebar.hide(c,"left")
    awful.titlebar.hide(c,"right")
  end
  },

  -- Fullscreen clients
  { rule_any = {
    class = {
      "baldur.exe",
    },
  }, properties = { fullscreen = true }},
  
  { rule = { class = "music_n" },
    properties = like_subtle(beautiful.gravity_ncmpcpp or {4, 14, 30, 49}) },

  { rule = { class = "music_c" },
    properties = like_subtle(beautiful.gravity_cava or { 4, 67, 30, 20 }) },

  { rule = { class = "music_t" },
    properties = like_subtle(beautiful.gravity_music_term or { 40, 67, 30, 20 }) },

  { rule_any = {
    class = {
      "miniterm", -- i use this when i need to enter password with sudo
    },
  }, properties = like_subtle({33, 33, 33, 33}) }, -- center33

  -- Centered windows
  { rule_any = {
    class = {
      "feh",
      "Sxiv",
      "mpv",
      "shellweb", -- rss popup
    },
    name = {
      "Save File"
    },
  }, properties = like_subtle({25, 25, 50, 50}) }, -- center66

  -- Maximised
  { rule_any = {
    class = {
      "Zathura" 
    },
  }, properties = { maximized = true } },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  { rule = { class = "Brave-browser" },
    properties = { screen = 1, tag = beautiful.tagnames[2] } },

  { rule = { class = "music*" },
    properties = { screen = 1, tag = beautiful.tagnames[4] } },

  { rule = { class = "Gimp" },
    properties = { screen = 1, tag = beautiful.tagnames[5] } },

  { rule = { class = "mail" },
    properties = { screen = 1, tag = beautiful.tagnames[6] } },
  { rule = { class = "chat" },
    properties = { screen = 1, tag = beautiful.tagnames[6] } },
  { rule_any = {
    class = {
      "baldur.exe",
      "Wine"
    },
  },properties = { screen = 1, tag = beautiful.tagnames[8] } },
}
-- }}}

require("titlebar")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enforce floating mode on layout.suit.floating and enable floating on layout.tile
client.connect_signal("property::floating", function(c)
  -- on floating
  local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
  if layout_is_floating then
    c.floating = true
  end
  -- on tile
  local layout_is_tile = (awful.layout.get(mouse.screen) == awful.layout.suit.tile)
  if layout_is_tile and c.floating then
    c.shape = helpers.rrect(beautiful.border_radius)
  else
    c.shape = gears.shape.rectangle
  end
end)

-- Rounded Corner only on floating client
if beautiful.border_radius ~= 0 then
  client.connect_signal("manage", function (c, startup)
    if not c.fullscreen and not c.maximized and c.floating then
      c.shape = helpers.rrect(beautiful.border_radius)
    end
  end)

  -- Fullscreen & maximised clients should not have rounded corners
  local function no_round_corners(c)
    if c.fullscreen or c.maximized or not c.floating then
      c.shape = gears.shape.rectangle
    else
      c.shape = helpers.rrect(beautiful.border_radius)
    end
  end

  client.connect_signal("property::fullscreen", no_round_corners)
  client.connect_signal("property::maximized", no_round_corners)
end

-- No borders if only one tiled client
screen.connect_signal("arrange", function(s)
  for _, c in pairs(s.clients) do
    if #s.tiled_clients == 1 and c.floating == false and c.first_tag.layout.name ~= "floating" then
      c.border_width = 0
    elseif #s.tiled_clients > 1 or c.first_tag.layout.name == "floating" then
      c.border_width = beautiful.border_width
    end
  end
end)

-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
tag.connect_signal('property::layout', function(t)
  for k, c in ipairs(t:clients()) do
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
      -- Geometry x = 0 and y = 0 most probably means that the
      -- clients have been spawned in a non floating layout, and thus
      -- they don't have their floating_geometry set properly.
      -- If that is the case, don't change their geometry
      local cgeo = awful.client.property.get(c, 'floating_geometry')
      if cgeo ~= nil then
        if not (cgeo.x == 0 and cgeo.y == 0) then
          c:geometry(awful.client.property.get(c, 'floating_geometry'))
        end
      end
      --c:geometry(awful.client.property.get(c, 'floating_geometry'))
    end
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = true })
end)

if beautiful.border_width > 0 then
  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end

-- Autostart
local autostart = require("autostart")
autostart.run()

-- }}}
