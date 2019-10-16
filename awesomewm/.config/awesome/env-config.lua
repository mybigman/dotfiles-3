local naughty = require("naughty")
local env = {}

env.term = os.getenv("TERMINAL") or "xst"
env.editor = os.getenv("EDITOR") or "vim"
env.web = "w3m" -- a terminal app if possible

-- Bellow are arguments to call a <class> and <exec> a program by terminal
-- post an issue if your terminal is not listed or to add new

if env.term:match('xst') then
  env.term_call = { " -c ", " -e " }
elseif env.term:match('rxvt') then
  env.term_call = { " -T ", " -e " }
elseif env.term:match('kitty') then
  env.term_call = { " --class=" , " -e " }
else
  naughty.notify({ title = 'Warning!', text = 'Your terminal is not recognized!' })
end

env.editor_cmd = env.term .. env.term_call[2] .. env.editor

-- {{{ Monitoring
env.net_device = "wlp2s0" -- interface you want track, only one for now

-- Add files system you want to track, the line bellow match with:
-- /home/yagdra, /opt/musics and /opt/torrents, look with the tool 'df'
env.disks = { "yagdra", "musics", "torrents" }

-- }}} End Monitoring

-- {{{ Sound Settings
-- choose alsa or pulseaudio, alsa will use amixer and pulseaudio pactl
env.sound_system = "alsa" -- if you use pulse, the default card @DEFAULT_SINK@ is used
env.sound_card_alsa = "hw:Pro" -- your card here, used only if sound_system is alsa, example usage: amixer -D hw:Pro sget Master
-- Your card name can be found with: cat /proc/asound/cards

-- }}} End Sound Setting

return env
