local wibox = require("wibox")
local gtable = require("gears.table")
local gshape = require("gears.shape")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local button = require("util.buttons")
local naughty = require("naughty")
local dpi = beautiful.xresources.apply_dpi
local env = require("env-config")
local helpers = require("helpers")
local theme = require("loaded-theme")

local text_rss = {
  threatpost = {},
  ycombinator = {}
}

local max_feeds = 4
local feed_width = 400
local feed_height = 248

for i = 1, max_feeds do
  text_rss['threatpost'][i] = widget.base_text('left')
  text_rss['ycombinator'][i] = widget.base_text('left')
end

local function start_screen_hide()
  start_screen.visible = false
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
      button.add_hover(text_rss['threatpost'][i], rss.treatpost.title[i], beautiful.fg_grey_light, beautiful.fg_grey)
      add_link(text_rss['threatpost'][i], rss.treatpost.link[i])
    end
  end
  if rss.ycombinator then
    for i = 1, max_feeds do
      button.add_hover(text_rss['ycombinator'][i], rss.ycombinator.title[i], beautiful.fg_grey_light, beautiful.fg_grey)
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
      shape = helpers.rrect(8),
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
        widget = widget.create_title(title, beautiful.primary),
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

-- images
local theme_picture_container = wibox.container.background()
theme_picture_container.forced_height = dpi(100)
theme_picture_container.forced_width = dpi(160)

local theme_picture = wibox.widget {
  wibox.widget.imagebox(beautiful.wallpaper),
  widget = theme_picture_container
}

local theme_name = widget.create_title(theme.name, beautiful.fg_primary, 17)
local picture_widget = widget.box('vertical', { theme_picture, theme_name })

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
local quote_title = widget.create_title("", beautiful.fg_grey_light, 17)
local quote = wibox.widget.textbox(quotes[math.random(#quotes)])
local quote_widget = widget.box("vertical", {quote_title, quote}, dpi(10))

-- date
local day = wibox.widget.textclock("%d")
day.markup = helpers.colorize_text(day.text, beautiful.primary)
local month = wibox.widget.textclock("%B")
month.markup = helpers.colorize_text(month.text, beautiful.secondary)

local date_widget = widget.box("vertical", { day, month }, dpi(14))

-- function for buttons
local launch_term = function(cmd)
 awful.spawn.with_shell(env.term .. env.term_call[2] .. cmd)
 start_screen_hide()
end

local exec_prog = function(cmd)
  awful.spawn(cmd)
  start_screen_hide()
end

-- buttons apps
local gimp_cmd = function() exec_prog("gimp") end
local gimp = button.create("", beautiful.primary_light, beautiful.primary, gimp_cmd)
local game_cmd = function() exec_prog("lutris") end
local game = button.create("", beautiful.secondary_light, beautiful.secondary, game_cmd)
local pentest_cmd = function() launch_term("msf") end
local pentest = button.create("ﮊ", beautiful.alert_light, beautiful.alert, pentest_cmd)

local buttons_widget = widget.box('vertical', { gimp,game,pentest })

-- buttons path
local image_cmd = function() launch_term("nnn ~/images") end
local image = button.create("IMAGES", beautiful.primary_light, beautiful.primary, image_cmd, 12)

local torrent_cmd = function() launch_term("nnn ~/torrents") end
local torrent = button.create("TORRENTS", beautiful.secondary_light, beautiful.secondary, torrent_cmd, 12)

local movie_cmd = function() launch_term("nnn ~/videos") end
local movie = button.create("MOVIES", beautiful.alert_light, beautiful.alert, movie_cmd, 12)

local buttons_path_1_widget = widget.box('horizontal', { image,torrent }, 25)
local buttons_path_2_widget = widget.box('horizontal', { movie }, 25)

-- buttons url
local github_cmd = function() exec_prog("/opt/brave/brave https://github.com") end
local github = button.create("", beautiful.primary_light, beautiful.primary, github_cmd)

local twitter_cmd = function() exec_prog("/opt/brave/brave https://twitter.com") end
local twitter = button.create("", beautiful.secondary_light, beautiful.secondary, twitter_cmd)

local reddit_cmd = function() exec_prog("/opt/brave/brave https://reddit.com") end
local reddit = button.create("", beautiful.alert_light, beautiful.alert, reddit_cmd)

local buttons_url_widget = widget.box('vertical', { github, twitter, reddit })

-- Minimal TodoList
local todo_textbox = wibox.widget.textbox() -- to store the prompt
local history_file = os.getenv("HOME").."/.todoslist"

local todo_max = 6
local todos = {
  ttexts = {},
  tbuttons = {},
  del_line = {},
  tlayout = {}
}

local function update_history()
  local i = 1
  local history = io.open(history_file, "r")
  if history == nil then return end
  for line in history:lines() do
    local text = line or ""
    todos.ttexts[i].markup = helpers.colorize_text(text, beautiful.fg_primary)
    i = i+1
  end
  history:close()

  if i < todo_max then -- clear the rest
    for o = i, todo_max do
      todos.ttexts[o].markup = helpers.colorize_text("", beautiful.fg_primary)
    end
  end
end

local function exec_prompt()
  awful.prompt.run {
    prompt = " New task: ", 
    fg = beautiful.fg_grey , 
    history_path = os.getenv("HOME").."/.history_todo",
    textbox = todo_textbox,
    exe_callback = function(input)
      if not input or #input == 0 then return end
      local command = "echo "..input.." >> "..history_file
      awful.spawn.easy_async_with_shell(command, function()
        update_history()
      end)
    end
  }
end

local function remove_todo(line)
  local line = line or 0
  local command = "[ -f "..history_file.." ] && sed -i "..line.."d "..history_file
  awful.spawn.easy_async_with_shell(command, function()
    update_history()
  end)
end

for i=1, todo_max do
  todos.ttexts[i] = widget.base_text('left')
  todos.del_line[i] = function() remove_todo(i) end -- serve to store the actual line
  todos.tbuttons[i] = button.create("x ", beautiful.alert_light, beautiful.alert, todos.del_line[i], 10)
  todos.tlayout[i] = widget.box('horizontal', { todos.tbuttons[i], todos.ttexts[i] })
end
update_history()
local todo_new = button.create("", beautiful.primary_light, beautiful.primary, exec_prompt, 10)
local todo_widget = widget.box("horizontal", { todo_new, todo_textbox })
local todo_list = widget.box("vertical", todos.tlayout)

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
        boxes(date_widget, 100, 100, 1),
        boxes(buttons_widget, 100, 300, 1),
        layout = wibox.layout.fixed.vertical
      },
      {
        nil,
        {
          boxes(picture_widget, 210, 200, 1),
          boxes(quote_widget, 210, 200, 1),
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
          boxes(todo_widget, 210, 30, 0),
          boxes(todo_list, 210, 200, 1),
          boxes(buttons_path_1_widget, 210, 85, 1),
          boxes(buttons_path_2_widget, 210, 85, 1),
          layout = wibox.layout.fixed.vertical
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      {
        boxes(buttons_url_widget, 100, 350, 1),
        layout = wibox.layout.fixed.vertical
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
