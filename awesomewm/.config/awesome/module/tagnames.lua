local awful = require("awful")
local gtable = require("gears.table")
local beautiful = require("beautiful")

-- init table
local mytagname = class()

function mytagname:init(s)
  -- Each screen has its own tag table.
  --awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  local l = awful.layout.suit -- Alias to save time :)
  -- local layouts = { l.max, l.floating, l.max, l.max , l.tile,
  --     l.max, l.max, l.max, l.floating, l.tile}
  local layouts = { 
    l.tile, l.max, l.tile, l.floating , l.max,
    l.tile, l.tile, l.tile, l.max, l.max
  }

  -- Tag names
  local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }

  -- Create tags
  awful.tag.add(tagnames[1], {
    layout = layouts[1],
    screen = s,
    gap_single_client  = false,
    selected = true,
  })

  awful.tag.add(tagnames[2], {
    layout = layouts[2],
    gap_single_client  = false,
    screen = s,
  })

  awful.tag.add(tagnames[3], {
    layout = layouts[3],
    master_width_factor = 0.34,
    column_count = 2,
    screen = s,
  })

  awful.tag.add(tagnames[4], {
    layout = layouts[4],
    master_width_factor = 0.6,
    screen = s,
  })

  awful.tag.add(tagnames[5], {
    layout = layouts[5],
    gap_single_client  = false,
    screen = s,
  })

  awful.tag.add(tagnames[6], {
    layout = layouts[6],
    gap = 40,
    screen = s,
  })

  awful.tag.add(tagnames[7], {
    layout = layouts[7],
    gap = 4,
    screen = s,
  })

  awful.tag.add(tagnames[8], {
    layout = layouts[8],
    master_width_factor = 0.33,
    gap = 3,
    column_count = 2,
    screen = s,
  })

  awful.tag.add(tagnames[9], {
    layout = layouts[9],
    screen = s,
  })

  awful.tag.add(tagnames[10], {
    layout = layouts[10],
    screen = s,
  })
end

return mytagname
