-- Create a signal: daemon::volume
-- return values: volume, is_muted
local aspawn = require("awful.spawn")
local awidget = require("awful.widget")
local naughty = require("naughty")
local env = require("env-config")

if env.sound_system == "alsa" then

  awidget.watch("amixer -D "..env.sound_card_alsa.." sget Master", 2, function(widget, stdout)
    local volume = stdout:match('(%d+)%%') or nil
    local is_muted = volume == 0 and false or true

    if volume ~= nil then
      awesome.emit_signal("daemon::volume", tonumber(volume), is_muted)
    else
      naughty.notify({ title = "Warning!", text = "Can't find volume: "..volume
    }) end end)

else -- asume you use pulseaudio

  local function emit_volume_info()
    aspawn.easy_async("pacmd list-sinks", function(stdout)
      local volume = stdout:match('(%d+)%%') or nil
      local is_muted = stdout:match('muted:%s+yes') and true or false
      --local index_card = stdout:match('*%s+index:%s+(%d+)') or nil

      if volume ~= nil then
        awesome.emit_signal("daemon::volume", tonumber(volume), is_muted)
      else
        naughty.notify({ title = "Warning!", text = "Can't find volume: "..volume })
      end
    end
    )
  end

  -- initialize signal
  emit_volume_info()

  local volume_script = [[
    bash -c '
    pactl subscribe | grep --line-buffered "sink"
    '
  ]]

  -- update the signal when receive new things
  aspawn.easy_async_with_shell("pgrep -x pactl | xargs kill", function()

    -- Run emit_volume_info() with each line printed
    aspawn.with_line_callback(volume_script, {
      stdout = function(line)
        emit_volume_info()
      end
    })

  end)

end
