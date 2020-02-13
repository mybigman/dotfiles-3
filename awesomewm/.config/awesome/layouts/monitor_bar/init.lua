local theme = require("loaded-theme")

return function(s)
  if theme.name == "machine" then
    require("layouts.monitor_bar.vertical")(s)
  elseif theme.name == "morpho" then
    require("layouts.monitor_bar.horizontal")(s)
  elseif theme.name == "beta" then
    require("layouts.monitor_bar.horizontal_v2")(s)
  else
    require("layouts.monitor_bar.horizontal")(s)
    s.monitor_bar.visible = false
  end
end 
