local wibox = require("wibox")
local gtable = require("gears.table")
local gshape = require("gears.shape")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local naughty = require("naughty")
local dpi = beautiful.xresources.apply_dpi
local env = require("env-config")
local helpers = require("helpers")

local text_rss = {
  threatpost = {},
  ycombinator = {}
}

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

-- images, TODO: create a widget to change the wallpaper rather than this
local user_picture_container = wibox.container.background()
user_picture_container.forced_height = dpi(160)
user_picture_container.forced_width = dpi(160)
user_picture_container.shape = gshape.circle

local user_picture = wibox.widget {
  wibox.widget.imagebox(os.getenv("HOME").."/.config/awesome/profile.png"),
  widget = user_picture_container
}

-- quotes
local quotes = {
  "Change is neither good nor bad. It simply is.",
  "Fear stimulates my imagination.",
  "You're good. Get better. Stop asking for things.",
  "Why does everybody need to talk about everything?",
  "Today's a good day for Armageddon.",
  "In the highest level a man has the look of knowing nothing.",
  "Even if it seems certain that you will lose, retaliate.",
  "The end is important in all things.",
  "Having only wisdom and talent is the lowest tier of usefulness.",
  "I'm living like there's no tomorrow, cause there isn't one."
}
local quote_title = widget.create_title("", beautiful.fg_grey_light)
local quote = wibox.widget.textbox(quotes[math.random(#quotes)])
local quote_widget = widget.box("vertical", {quote_title, quote}, dpi(10))

-- date
local day = wibox.widget.textclock("%d")
day.markup = helpers.colorize_text(day.text, beautiful.fg_primary)
local month = wibox.widget.textclock("%B")
month.markup = helpers.colorize_text(month.text, beautiful.fg_secondary)

local date_widget = widget.box("vertical", { day, month }, dpi(10))

-- shortcut icon
local function make_button(icon, color_up, color_down, cmd, fsize)
  local font = beautiful.myfont or "Iosevka Term"
  local font_size = fsize or "35"
  local w = widget.create_text(icon, color_down, font.." "..font_size)
  add_hover(w, icon, color_up, color_down)
  w:buttons(gtable.join(awful.button({}, 1, function() cmd() end)))
  return w
end

local gimp_cmd = function() awful.spawn("gimp") end
local gimp = make_button("", beautiful.fg_grey_light, beautiful.fg_grey, gimp_cmd)
local game_cmd = function() awful.spawn("lutris") end
local game = make_button("", beautiful.fg_grey_light, beautiful.fg_grey, game_cmd)
local pentest_cmd = function() awful.spawn("msf") end -- TODO no work like this
local pentest = make_button("ﮊ", beautiful.fg_grey_light, beautiful.fg_grey, pentest_cmd)

local buttons_widget = widget.box('vertical', { gimp,game,pentest })

-- Minimal TodoList
local todo_textbox = wibox.widget.textbox() -- to store the prompt
local history_file = os.getenv("HOME").."/.todo_history"

local function update_history()
  local w = {}
  local history = io.open(history_file, "r")
  if history == nil then return end
  for line in history:lines() do
    table.insert(w, wibox.widget.textbox(line))
  end
  history:close()
  return w
end

local function exec_prompt()
  awful.prompt.run {
    prompt = " New task: ", 
    fg = beautiful.fg_grey , 
    history_path = history_file,
    textbox = todo_textbox,
    exe_callback = function(input)
      if not input or #input == 0 then return end
      todos = update_history()
    end
  }
end

local todos = update_history()
local todo_new = make_button("", "#bbffee", "#8adeaa", exec_prompt, 10)
local todo_widget = widget.box("horizontal", { todo_new, todo_textbox })
local todo_list = widget.box("vertical", todos)

-- the start_screen
start_screen = wibox({ visible = false, ontop = true, type = "dock" })
start_screen.bg = beautiful.grey .. "00"
awful.placement.maximize(start_screen)

start_screen:buttons(gtable.join(
  awful.button({}, 3, function() start_screen_hide() end)
))

start_screen:setup {
  nil,
  {
    nil,
    {
      {
        nil,
        {
          boxes(date_widget, 100, 100, 1),
          boxes(buttons_widget, 100, 250, 1),
          layout = wibox.layout.fixed.vertical
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      {
        nil,
        {
          boxes(user_picture, 210, 210, 1),
          boxes(quote_widget, 200, 200, 1),
          layout = wibox.layout.fixed.vertical
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      {
        boxes(threatpost_widget, feed_width, feed_height, 1),
        boxes(ycombinator_widget, feed_width, feed_height, 1),
        layout = wibox.layout.fixed.vertical
      },
      {
        nil,
        {
          boxes(todo_widget, 30, 30, 0),
          boxes(todo_list, 200, 200, 1),
          layout = wibox.layout.fixed.vertical
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      layout = wibox.layout.fixed.horizontal
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
