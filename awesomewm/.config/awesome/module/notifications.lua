local beautiful = require("beautiful")
local naughty = require("naughty")

-- timeout
naughty.config.defaults.timeout = 8
naughty.config.presets.low.timeout = 5
naughty.config.presets.critical.timeout = 20

naughty.config.presets.normal = {
  font         = beautiful.font,
  fg           = beautiful.fg_grey_light,
  bg           = beautiful.grey,
  border_color = beautiful.primary_dark,
  border_width = 1
}

naughty.config.presets.low = {
  font         = beautiful.font,
  fg           = beautiful.fg_grey,
  bg           = beautiful.grey,
  border_color = beautiful.grey_dark,
  border_width = 1
}

naughty.config.presets.ok = naughty.config.presets.low
naughty.config.presets.info = naughty.config.presets.low
naughty.config.presets.warn = naughty.config.presets.normal

naughty.config.presets.critical = {
  font         = beautiful.font,
  fg           = beautiful.fg_alert,
  bg           = beautiful.alert_dark,
  border_color = beautiful.alert,
  border_width = 2
}

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ 
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors 
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
  -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ 
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })

    in_error = false
  end)
end

-- signal, TODO need awesome-git as dependencies to enable the signal !!
-- https://github.com/elenapan/dotfiles/issues/60
--naughty.connect_signal("request::display", function(n)

  --naughty.layout.box {
  --  notification = n,
  --  type = "splash",
  --  widget_template = {}
--  }
--end)
