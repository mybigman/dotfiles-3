local beautiful = require("beautiful")
local theme = {}

theme.name = "new"

local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/"
beautiful.init( theme_dir .. theme.name .. "/theme.lua" )

local bars = require("bar-themes."..theme.name)

return theme
