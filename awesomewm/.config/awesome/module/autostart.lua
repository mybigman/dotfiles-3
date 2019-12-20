local awful = require("awful")

-- Autostart windowless processes
local function run_once(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format(
      'pgrep -u $USER -x %s > /dev/null || pgrep -u $USER -x -f %s > /dev/null || (%s)',
      findme, findme, cmd
    ))
  end
end

run_once({'compton -b'})
run_once({'brave-sec'})
run_once({ env.term .. env.term_call[1] .. 'music_n' .. env.term_call[2] .. 'ncmpcpp'})
run_once({ env.term .. env.term_call[1] .. 'music_c' .. env.term_call[2] .. 'cava'})
run_once({ env.term .. env.term_call[1] .. 'music_t' .. env.term_call[2] .. 'tmux'})
run_once({ env.term .. env.term_call[1] .. 'mail' .. env.term_call[2] .. 'neomutt'})
run_once({ env.term .. env.term_call[1] .. 'chat' .. env.term_call[2] .. 'weechat'})
