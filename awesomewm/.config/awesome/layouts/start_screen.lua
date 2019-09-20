local wibox = require("wibox")
local gtable = require("gears.table")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local naughty = require("naughty")
local dpi = beautiful.xresources.apply_dpi
local env = require("env-config")
local helpers = require("helpers")

local text_rss = {}
text_rss.threatpost = {}
text_rss.ycombinator = {}

local max_feeds = 5
local feed_width = 400
local feed_height = 240

for i = 1, max_feeds do
  text_rss['threatpost'][i] = widget.base_text()
  text_rss['threatpost'][i].align = "left"
  text_rss['ycombinator'][i] = widget.base_text()
  text_rss['ycombinator'][i].align = "left"
end

local function start_screen_hide()
  start_screen.visible = false
end

local function add_hover(w, text, color_up, color_down)
  w.markup = helpers.colorize_text(text, color_down)
  w:connect_signal("mouse::enter", function()
    w.markup = helpers.colorize_text(text, color_up)
  end)
  w:connect_signal("mouse::leave", function()
    w.markup = helpers.colorize_text(text, color_down)
  end)
end

local function add_link(w, url)
  w:buttons(gtable.join(
     awful.button({ }, 1, function()
      awful.spawn(env.term .. env.term_call[1] .. "shellweb" .. env.term_call[2] .. env.web .. " " ..tostring(url))
      start_screen_hide()
    end)
  ))
end

local function update_feeds(rss) 
  if rss.treatpost then
    for i = 1, max_feeds do
      add_hover(text_rss['threatpost'][i], rss.treatpost.title[i], beautiful.fg_grey_light, beautiful.fg_grey)
      add_link(text_rss['threatpost'][i], rss.treatpost.link[i])
    end
  end
  if rss.ycombinator then
    for i = 1, max_feeds do
      add_hover(text_rss['ycombinator'][i], rss.ycombinator.title[i], beautiful.fg_grey_light, beautiful.fg_grey)
      add_link(text_rss['ycombinator'][i], rss.ycombinator.link[i])
    end
  end
end

local function boxes(w, width, height, margin)
  local width, height = width, height or 1, 1
  local margin = margin or 1
  local boxed_widget = wibox.widget {
    {
      {
        nil,
        {
          {
            nil,
            w,
            expand = "none",
            layout = wibox.layout.align.vertical
          },
          margins = dpi(10),
          widget = wibox.container.margin,
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
      },
      bg = beautiful.grey_dark,
      forced_height = dpi(height),
      forced_width = dpi(width),
      widget = wibox.container.background
    },
    margins = dpi(margin),
    color = "#00000000",
    widget = wibox.container.margin
  }
  return boxed_widget
end

local function make_rss_widget(title, w)
  return wibox.widget {
    {
      {
        align = "left",
        widget = widget.create_title(title, beautiful.fg_grey),
      },
      left = 5, bottom = 8, top = 5,
      layout = wibox.container.margin
    },
    {
      widget.box("vertical", w, 10),
      forced_width = feed_width,
      layout = wibox.layout.fixed.vertical
    },
    nil,
    layout = wibox.layout.align.vertical
  }
end

local threatpost_widget = make_rss_widget("threatpost", text_rss.threatpost)
local ycombinator_widget = make_rss_widget("ycombinator", text_rss.ycombinator)

start_screen = wibox({ visible = false, ontop = true, type = "dock" })
start_screen.bg = beautiful.grey .. "00"
awful.placement.maximize(start_screen)

start_screen:buttons(gtable.join(
  awful.button({}, 3, function()
    start_screen_hide()
  end)
))

start_screen:setup {
  nil,
  {
    nil,
    {
      boxes(widget.create_title("RSS Feeds", beautiful.fg_grey), feed_width, 30, 0),
      boxes(threatpost_widget, feed_width, feed_height, 0),
      boxes(ycombinator_widget, feed_width, feed_height, 0),
      layout = wibox.layout.fixed.vertical
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.vertical
}

-- signal rss
awesome.connect_signal("daemon::rss", function(rss) 
  update_feeds(rss) 
end)
