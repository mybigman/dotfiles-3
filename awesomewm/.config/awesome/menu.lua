local beautiful = require("beautiful")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- ENV
local terminal = os.getenv("TERMINAL") or "xterm"
local editor = os.getenv("EDITOR") or "vim"
local editor_cmd = terminal .. " -e " .. editor
--

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

local myappmenu = {
  { "ncmpcpp", terminal .. " --class=music_n -e ncmpcpp" },
  { "cava", terminal .. " --class=music_c -e cava" },
  { "brave", "brave-sec" },
  { "virtualbox", "firejail VirtualBox" },
  { "weechat", terminal .. " --class=chat -e weechat" },
  { "mutt", terminal .. " --class=mail -e mutt" },
  { "ranger", terminal .. " -e ranger" },
  { "gimp", gimp }
}

local mypentestmenu = {
   { "metasploit", terminal .. " -e msf" },
   { "leaked", terminal .. " -e leaked.py" },
   { "burpsuite", burpsuite }
}

local mygamemenu = {
  { "baldur's gate 1", "" },
  { "baldur's gate 2", "" },
  { "don't starve", "" }
}

local mymainmenu = awful.menu({ items = 
  {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal },
    { "apps", myappmenu },
    { "pentest tools", mypentestmenu },
    { "games", mygamemenu }
  }
})

return mymainmenu
