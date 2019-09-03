-- Create a signal: daemon::brightness 
-- return value: brightness
local awful = require("awful")

local brightness_subscribe_script = [[
  bash -c "
    while (inotifywait -e modify /sys/class/backlight/?**/brightness -qq) do echo; done
  "
]]

local brightness_script = [[
  sh -c "
    light -G
  "
]]

local emit_brightness_info = function()
  awful.spawn.with_line_callback(brightness_script, {
    stdout = function(line)
      percentage = math.floor(tonumber(line))
      awesome.emit_signal("daemon::brightness", percentage)
    end
  })
end

-- Run once to initialize widgets
emit_brightness_info()

-- Kill old inotifywait process
awful.spawn.easy_async_with_shell("pgrep -x inotifywait | xargs kill -9", function()
  -- Update brightness status with each line printed
  awful.spawn.with_line_callback(brightness_subscribe_script, {
    stdout = function(_)
      emit_brightness_info()
    end
  })
end)
