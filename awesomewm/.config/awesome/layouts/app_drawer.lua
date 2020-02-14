local awful = require("awful")
local naughty = require("naughty")
local gtable = require("gears.table")
local wibox = require("wibox")
local helpers = require("helpers")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local icons = require("icons.app_drawer")
local gshape = require("gears.shape")
local app = require("util.app")
local keygrabber = require("awful.keygrabber")

local s = awful.screen.focused()
local ntags = 10

local w = wibox.widget { spacing = 18, layout = wibox.layout.fixed.horizontal }
local wtitle = widget.create_base_text(beautiful.myfont .. "Bold 20")
local app_drawer_grabber
local my_apps = {}

local function app_drawer_hide()
  app_drawer.visible = false
  keygrabber.stop(app_drawer_grabber)
end

local function exe_app(name)
  app.start(name)
  app_drawer_hide()
end

local function exe_shell(cmd, class)
  local have_class = class or nil
  app.start(cmd, true, have_class)
  app_drawer_hide()
end 

local function exe_web(link)
  app.start(env.web_browser .. " " .. link)
  app_drawer_hide()
end 

-- About the code <b></b> (bold), you can use <u></u> (underline) or even
-- <i></i> (italic) if you prefer
my_apps[1] = {
  title = "Code",
  { name = "<b>T</b>mux", icon = icons["tilix"], exec = function() exe_shell("tmux") end },
  { name = "<b>V</b>im", icon = icons["neovim"], exec = function() exe_shell("vim") end  },
  keybindings = {
    { {}, 't', function() exe_shell("tmux") end },
    { {}, 'v', function() exe_shell("vim") end },
  },
}

my_apps[2] = {
  title = "Web",
  { name = "<b>B</b>rave", icon = icons["brave"], exec = function()
    exe_app(env.web_browser) 
  end },
  { name = "<b>G</b>ithub", icon = icons["github"], exec = function()
    exe_web("https://github.com/szorfein") 
  end },
  { name = "<b>T</b>witter", icon = icons["twitter"], exec = function()
    exe_web("https://twitter.com/szorfein") 
  end },
  { name = "<b>R</b>uby", icon = icons["ruby"], exec = function()
    exe_web("https://www.ruby-lang.org/en/") 
  end },
  { name = "<b>Y</b>outube", icon = icons["youtube"], exec = function()
    exe_web("https://www.youtube.com")
  end },
  { name = "r<b>E</b>ddit", icon = icons["reddit"], exec = function()
    exe_web("https://www.reddit.com/u/szorfein")
  end },
  { name = "exploit-<b>D</b>b", icon = icons["exploit-db"], exec = function()
    exe_web("https://www.exploit-db.com/")
  end },
  keybindings = {
    { {}, 'b', function() exe_app(env.web_browser) end },
    { {}, 'g', function() exe_web("https://github.com/szorfein") end },
    { {}, 't', function() exe_web("https://twitter.com/szorfein") end },
    { {}, 'r', function() exe_web("https://www.ruby-lang.org/en/") end },
    { {}, 'y', function() exe_web("https://www.youtube.com") end },
    { {}, 'e', function() exe_web("https://www.reddit.com/u/szorfein") end },
    { {}, 'd', function() exe_web("https://www.exploit-db.com/") end }
  },
}

my_apps[3] = {
  title = "web-dev",
  { name = "<b>?</b>", icon = icons[""], exec = function() exe_app() end },
  keybindings = {
    { {}, 'h', function() exe_app() end },
  },
}

my_apps[4] = {
  title = "hack",
  { name = "<b>H</b>ydra", icon = icons["hydra"], exec = function() exe_shell("hydra") end },
  { name = "<b>W</b>pscrack", icon = icons["wpscrack"], exec = function() exe_shell("wpscrack") end },
  { name = "wp<b>S</b>can", icon = icons["wpscan"], exec = function() exe_shell("wpscan") end },
  { name = "<b>W</b>ireshark", icon = icons["wireshark"], exec = function() exe_app("wireshark-gtk") end },
  { name = "w<b>I</b>fite", icon = icons["wifite"], exec = function() exe_shell("wifite") end },
  { name = "<b>R</b>eaver", icon = icons["reaver"], exec = function() exe_shell("reaver") end },
  { name = "<b>N</b>map", icon = icons["nmap"], exec = function() app.shell_and_wait("sudo nmap -sS $(ip a | grep inet | grep "..env.net_device.." | awk '{print $2}')", app_drawer_hide) end },
  { name = "ni<b>K</b>to", icon = icons["nikto"], exec = function() exe_shell("nikto") end },
  keybindings = {
    { {}, 'h', function() exe_shell("hydra") end },
    { {}, 'w', function() exe_shell("wpscrack") end },
    { {}, 's', function() exe_shell("wpscan") end },
    { {}, 'a', function() exe_app("wireshark-gtk") end },
    { {}, 'i', function() exe_shell("wifite") end },
    { {}, 'r', function() exe_shell("reaver") end },
    { {}, 'n', function() app.shell_and_wait("sudo nmap -sS $(ip a | grep inet | grep "..env.net_device.." | awk '{print $2}')", app_drawer_hide) end },
    { {}, 'k', function() exe_shell("nikto") end },
  }
}

my_apps[5] = {
  title = "music",
  { name = "<b>N</b>cmpcpp", icon = icons["mpd"], exec = function() exe_shell("ncmpcpp") end },
  { name = "<b>C</b>ava", icon = icons["terminal"], exec = function() exe_shell("cava") end },
  { name = "<b>M</b>pv", icon = icons["mpv"], exec = function() exe_shell("mpv ~/videos", "miniterm") end },
  { name = "<b>S</b>ound", icon = icons["sound"], exec = function() exe_shell("alsamixer") end },
  keybindings = {
    { {}, 'n', function() exe_shell("ncmpcpp") end },
    { {}, 'c', function() exe_shell("cava") end },
    { {}, 'm', function() exe_shell("mpv ~/videos", "miniterm") end },
    { {}, 's', function() exe_shell("alsamixer") end },
  },
}

my_apps[6] = {
  title = "chat",
  { name = "<b>W</b>eechat", icon = icons["irc-chat"], exec = function() exe_shell("weechat") end },
  { name = "<b>N</b>eomutt", icon = icons["mail"], exec = function() exe_shell("neomutt") end },
  { name = "<b>S</b>ignal", icon = icons["signal"], exec = function() exe_app("signal") end },
  keybindings = {
    { {}, 'w', function() exe_shell("weechat") end },
    { {}, 'n', function() exe_shell("neomutt") end },
    { {}, 's', function() exe_app("signal") end },
  },
}

my_apps[7] = {
  title = "document",
  { name = "<b>L</b>ibreoffice", icon = icons["writter"], exec = function() exe_app("libreoffice-writter") end },
  keybindings = {
    { {}, 'v', function() exe_app("libreoffice") end },
  },
}

my_apps[8] = {
  title = "image",
  { name = "<b>G</b>imp", icon = icons["gimp"], exec = function() exe_app("gimp") end },
  { name = "<b>W</b>allpapers", icon = icons["images"], exec = function() app.feh("~/images", app_drawer_hide) end },
  { name = "<b>I</b>magemagick", icon = icons["imagemagick"], exec = function() exe_shell("imagemagick") end },
  keybindings = {
    { {}, 'g', function() exe_app("gimp") end },
    { {}, 'w', function() app.feh("~/images", app_drawer_hide) end },
    { {}, 'i', function() exe_shell("imagemagick") end },
  },
}


my_apps[9] = {
  title = "vm",
  { name = "<b>V</b>irtualbox", icon = icons["virtualbox"], exec = function() exe_app("VirtualBox") end },
  keybindings = {
    { {}, 'v', function() exe_app("VirtualBox") end },
  },
}

my_apps[10] = {
  title = "games",
  { name = "<b>L</b>utris", icon = icons["lutris"], exec = function() exe_app("lutris") end },
  { name = "<b>S</b>team", icon = icons["steam"], exec = function() exe_app("Steam") end },
  { name = "<b>D</b>ontstarve", icon = icons["dontstarve"], exec = function() exe_app("lutris") end },
  keybindings = {
    { {}, 'l', function() exe_app("lutris") end },
    { {}, 's', function() exe_app("Steam") end },
    { {}, 'd', function() exe_app("lutris") end },
  },
}

local function key_grabber(app_tag)

  local grabber = keygrabber {
      keybindings = app_tag.keybindings,
      stop_key = "Escape",
      stop_callback = function() app_drawer_hide() end,
  }

  if grabber.is_running and app_drawer.visible == false then
    grabber:stop()
  elseif app_drawer.visible == false then
    grabber:stop()
  else
    grabber:start()
  end
end

local bg_hover = function()
  local w = wibox.container.background()
  w.shape = helpers.rrect(14)
  w.bg = beautiful.grey
  w:connect_signal("mouse::leave", function(c)
    w.bg = beautiful.grey
  end)
  w:connect_signal("mouse::enter", function(c)
    w.bg = beautiful.grey_light
  end)
  return w
end

local function gen_menu(index)
  if not my_apps[index] then return end
  w:reset()
  for _,v in ipairs(my_apps[index]) do
    local app_icon = widget.imagebox(70, v.icon)
    wtitle.markup = helpers.colorize_text(my_apps[index].title, beautiful.fg_grey)
    app_icon:buttons(gtable.join(
      awful.button({}, 1, function() v.exec() end)
    ))
    local app_name = widget.create_base_text(beautiful.font .. "Regular 12")
    app_name.markup = helpers.colorize_text(v.name, beautiful.fg_grey_light)
    w:add(wibox.widget {
      {
        {
          app_icon,
          app_name,
          layout = wibox.layout.fixed.vertical
        },
        margins = 20,
        widget = wibox.container.margin
      },
      widget = bg_hover
    })
  end
  key_grabber(my_apps[index])
end

function update_app_drawer(desired_tag)
  local d = tonumber(desired_tag) or nil
  local curr_tag = s.selected_tag
  if d ~= nil then
    gen_menu(d)
  elseif curr_tag ~= nil then
    --naughty.notify({ text = "We are in the "..tostring(curr_tag.index) })
    gen_menu(curr_tag.index)
  else -- fallback to find the right curr_tag
    for i = 1, ntags do
      if tag then
        if curr_tag == s.tags[i] then
          --naughty.notify({ text = "We are in the "..tostring(i) })
          gen_menu(i)
          break
        end
      end
    end
  end
end

app_drawer = wibox({ visible = false, ontop = true, type = "dock", position = "top" })
app_drawer.bg = beautiful.grey_dark .. "fc"
app_drawer.x = 0
app_drawer.y = beautiful.wibar_position == "top" and beautiful.wibar_size or 0 
app_drawer.height = 160
app_drawer.width = awful.screen.focused().geometry.width

app_drawer:buttons(gtable.join(
  -- Middle click - Hide app_drawer
  awful.button({}, 2, function()
    app_drawer_hide()
  end),
  -- Right click - Hide app_drawer
  awful.button({}, 3, function()
    app_drawer_hide()
  end)
))

local textclock = wibox.widget {
  format = '<span foreground="'..beautiful.fg_primary..'" font="22.5">%H:%M</span>',
  refresh = 60,
  timezone = "Europe/Paris",
  widget = wibox.widget.textclock,
  forced_height = 88,
  forced_width = 90
}

app_drawer:setup {
  --{
  --  wibox.widget.textbox("   "),
  --  wtitle,
  --  layout = wibox.layout.fixed.horizontal
  --},
  nil,
  {
    nil,
    w,
    expand = "none",
    layout = wibox.layout.align.vertical
  },
  --textclock,
  expand = "none",
  layout = wibox.layout.align.horizontal
}

awful.tag.attached_connect_signal(s, "property::selected", function()
  update_app_drawer()
end)
