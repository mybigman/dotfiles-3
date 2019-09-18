local awidget = require("awful.widget")
local aspawn = require("awful.spawn")

local rss = {}
local curl = "curl -A 'Mozilla/4.0' -fsm 5 --connect-timeout 3 "

local function rss_grab(object, fields, url)
  local object = object or "item"
  local fields = fields or {"title", "link"} -- link, title, or description
  local url = url or "https://threatpost.com/feed/"

  local out = {}

  for _, v in pairs(fields) do
    out[v] = {}
  end

  local ob = nil
  local i,j,k = 1, 1, 0

  -- code don't work with async method
  local f = io.popen(curl .. '"' .. url .. '"')
  local feed = f:read("*all")
  f:close()

  while true do
    i, j, ob = feed.find(feed, "<" .. object .. ">(.-)</" .. object .. ">", i)
    if not ob then break end

    for _, v in pairs(fields) do
      out[v][k] = ob:match("<" .. v .. ">(.*)</" .. v .. ">")
    end

    k = k+1
    i = j+1
  end

  return out
end

local function treat_rss() 
  local url = "https://threatpost.com/feed/"
  rss['treatpost'] = rss_grab("item", { "title", "link" }, url)
  awesome.emit_signal("daemon::rss", rss)
end

local function poe_rss()
  local url = "https://www.pathofexile.com/news/rss"
  rss['poe'] = rss_grab("item", { "title", "link" }, url)
  awesome.emit_signal("daemon::rss", rss)
end

awidget.watch('sh -c ":"', 900 , function(widget, stdout) -- 15 min
  treat_rss() 
  poe_rss()
end)
