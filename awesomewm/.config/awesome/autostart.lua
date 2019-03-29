local awful = require("awful")
local filesystem = require('gears.filesystem')

local autostart = {}

-- Autostart windowless processes
local function run_once(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd))
  end
end

function autostart.run()
  --awful.spawn.with_shell("compton -b")
--  awful.spawn.with_shell("brave-sec")

-- use the spawn_once
  run_once({'compton -b'})
  run_once({'brave-sec'})

  run_once({'kitty --class=music_n -e ncmpcpp'})
  run_once({'kitty --class=music_t -e tmux'})
  run_once({'kitty --class=music_r -e ranger'})
  run_once({'kitty --class=music_c -e cava'})

  run_once({'kitty --class=mail -e mutt'})
  run_once({'kitty --class=chat -e weechat'})
--spawn_once("chromium", "Chromium", tags[1][3])
--spawn_once("thunar", "Thunar", tags[1][4])
--spawn_once("xchat", "Xchat", tags[1][5])
end

return autostart
