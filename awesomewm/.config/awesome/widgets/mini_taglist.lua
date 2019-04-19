local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local ntags = 10
local s = awful.screen.focused()
local tag_text = {}

-- Create textboxes and set their buttons
for i = 1, ntags do
  table.insert(tag_text, wibox.widget.textbox())
  tag_text[i]:buttons(
  gears.table.join(
  -- mouse left click
    awful.button({ }, 1, function()
      local current_tag = s.selected_tag
      local clicked_tag = s.tags[i]
      if clicked_tag == current_tag then
        awful.tag.history.restore()
      else
        clicked_tag:view_only()
      end
    end),
    awful.button({ modkey }, 1, function()
      if client.focus then
        client.focus:move_to_tag(s.tags[i])
      end
    end),
    awful.button({ }, 3, function() 
      local clicked_tag = s.tags[i]
      awful.tag.viewtoggle(clicked_tag)
    end),
    awful.button({ modkey }, 3, function()
      if client.focus then
        client.focus:toggle_tag(s.tags[i])
      end
    end),
    -- Middle mouse button
    awful.button({ }, 4, function() awful.tag.viewnext(s.tags[i].screen) end),
    awful.button({ }, 5, function() awful.tag.viewprev(s.tags[i].screen) end)
  ))
  tag_text[i].font = beautiful.taglist_font
  tag_text[i].forced_width = dpi(25)
  tag_text[i].align = "center"
  tag_text[i].valign = "center"
end

local text_taglist = wibox.widget{
  tag_text[1],
  tag_text[2],
  tag_text[3],
  tag_text[4],
  tag_text[5],
  tag_text[6],
  tag_text[7],
  tag_text[8],
  tag_text[9],
  tag_text[10],
  layout = wibox.layout.fixed.horizontal
}

--local text_taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

local function update_widget()
  for i = 1, ntags do
    local tag_clients
    if s.tags[i] then
      tag_clients = s.tags[i]:clients()
    end
    if s.tags[i] == s.selected_tag then
      tag_text[i].markup = helpers.colorize_text(beautiful.taglist_text_focused[i], beautiful.taglist_text_color_focused[i])
    elseif awful.tag.getproperty(s.tags[i], "urgent") then
      tag_text[i].markup = helpers.colorize_text(beautiful.taglist_text_urgent[i], beautiful.taglist_text_color_urgent[i])
    elseif tag_clients and #tag_clients > 0 then
      tag_text[i].markup = helpers.colorize_text(beautiful.taglist_text_occupied[i], beautiful.taglist_text_color_occupied[i])
    else
      tag_text[i].markup = helpers.colorize_text(beautiful.taglist_text_empty[i], beautiful.taglist_text_color_empty[i])
    end
  end
end

client.connect_signal("unmanage", function(c)
  update_widget()
end)
client.connect_signal("untagged", function(c)
  update_widget()
end)
client.connect_signal("tagged", function(c)
  update_widget()
end)
client.connect_signal("screen", function(c)
  update_widget()
end)
awful.tag.attached_connect_signal(s, "property::selected", function ()
  update_widget()
end)
awful.tag.attached_connect_signal(s, "property::hide", function ()
  update_widget()
end)
awful.tag.attached_connect_signal(s, "property::activated", function ()
  update_widget()
end)
awful.tag.attached_connect_signal(s, "property::screen", function ()
  update_widget()
end)
awful.tag.attached_connect_signal(s, "property::index", function ()
  update_widget()
end)
awful.tag.attached_connect_signal(s, "property::urgent", function ()
  update_widget()
end)

return text_taglist
