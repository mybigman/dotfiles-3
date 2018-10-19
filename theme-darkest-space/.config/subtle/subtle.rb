set :increase_step, 5
set :border_snap, 10
set :default_gravity, :center66
set :urgent_dialogs, false
set :honor_size_hints, false
set :gravity_tiling, true 
set :click_to_focus, false
set :skip_pointer_warp, true
set :skip_urgent_warp, false
set :wmname, "Subtle"

#
# == Screen
#

screen 1 do
  top    [ ]
  bottom [ ]
end

# Example for a second screen:
#screen 2 do
#  top    [ ]
#  bottom [ ]
#end

#
# == Styles
#

# Style for all style elements
style :all do
  background  "#202020"
  icon        "#757575"
  border      "#303030", 0
  padding     0, 3
  font        "-*-*-*-*-*-*-14-*-*-*-*-*-*-*"
end

# Style for the all views
style :views do
  foreground  "#757575"
end

# Style for active/inactive windows
style :clients do
  active    "#5f8787", 1
  inactive  "#333333", 1
  margin_left 1
  margin_right 0
  margin_top 0
  margin_bottom 1
  padding 0
  width     50
end

# Style for subtle
style :subtle do
  margin      0, 0, 0, 0
  panel       "#202020"
  background  "#3d3d3d"
  stipple     "#757575"
end

#
# == Gravities
#

# Center
gravity :center,         [   0,   6, 100, 91 ]
gravity :center66,       [  25,  25,  50,  50 ]
gravity :center33,       [  33,  33,  33,  33 ]

# Gimp
gravity :gimp_image,     [  10,   6,  80, 91 ]
gravity :gimp_toolbox,   [   0,   6,  10, 91 ]
gravity :gimp_dock,      [  90,   6,  10, 91 ]

#
# == Grabs
#

# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4
grab "W-S-5", :ViewJump5
grab "W-S-6", :ViewJump6

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4
grab "W-5", :ViewSwitch5
grab "W-6", :ViewSwitch6

# Select next and prev view */
grab "W-Tab", :ViewNext
grab "W-Tab", :ViewPrev

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2
grab "W-A-3", :ScreenJump3
grab "W-A-4", :ScreenJump4
grab "W-A-5", :ScreenJump5
grab "W-A-6", :ScreenJump6

# Force reload of config and sublets
grab "W-C-r", :SubtleReload

# Force restart of subtle
grab "W-C-S-r", :SubtleRestart

# Quit subtle
grab "W-C-q", :SubtleQuit

# Move current window
grab "W-B1", :WindowMove

# Resize current window
grab "W-B3", :WindowResize

# Toggle floating mode of window
grab "W-f", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
grab "W-s", :WindowStick

# Toggle zaphod mode of window (will span across all screens)
grab "W-equal", :WindowZaphod

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-l", :WindowLower

# Select next windows
grab "W-Left",  :WindowLeft
grab "W-Down",  :WindowDown
grab "W-Up",    :WindowUp
grab "W-Right", :WindowRight

# Kill current window
grab "W-z", :WindowKill

# Cycle between given gravities
grab "W-F1", [ :c1 ]
grab "W-F2", [ :c2, :center66 ]
grab "W-F3", [ :c3 ]

# Exec programs
grab "W-Return", "#{ENV["TERMINAL"]}"
grab "W-p", "rofi -show run"

# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

# Custom grab
grab "C-A-Right", "mpc next"
grab "C-A-Left", "mpc prev"
grab "S-A-d", "mpc del 0"
grab "C-A-Up", "mpc volume +1"
grab "C-A-Down", "mpc volume -1"
grab "G-F9", "xbacklight +1"
grab "G-F8", "xbacklight -1"

#
# == Tags
#

# Simple tags
tag "terms" do
    match :instance => "xterm|[u]?rxvt|termite|kitty"
end

tag "browser" do
  match "uzbl|opera|firefox|navigator|vivaldi|brave"
  gravity :center
end

# Placement
tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "resize" do
  match  "sakura|gvim"
  resize true
end

tag "gravity" do
  gravity :center
end

# Modes
tag "stick" do
  match "mplayer|mpv"
  float true
  stick false
end

tag "imgs" do
    match "sxiv|feh"
    #float true
    gravity :center66
end

tag "float" do
  match "display"
  float true
end

## programs on view dev [3]
gravity :c1, [ 0, 6, 33, 91 ]
gravity :c2, [ 33, 6, 34, 91 ]
gravity :c3, [ 67, 6, 33, 91 ]

tag "code_1" do
    match "code-1"
    gravity :c1
end

tag "code_2" do
    match "code-2"
    gravity :c2
end

tag "code_3" do
    match "code-3"
    gravity :c3
end

tag "code_4" do
    match "code-4"
    gravity :c1
end

tag "code_5" do
    match "code-5"
    gravity :c2
end

tag "code_6" do
    match "code-6"
    gravity :c3
end
## End programs on view dev [3]

## Programs on view console [4]
gravity :term, [ 6, 18, 34, 26 ]
gravity :wee, [ 6, 46, 34, 40 ]
gravity :mus, [ 41, 18, 27, 36 ]
gravity :cav, [ 69, 30, 25, 24 ]
gravity :mai, [ 41, 56, 53, 30 ]

tag "pwd" do
    match "pwd"
    gravity :term
end

tag "chat" do
    match :instance => "weechat"
    gravity :wee
end

tag "music" do
    match :instance => "ncmpcpp"
    gravity :mus
end

tag "cava" do
    match :instance => "cava"
    gravity :cav
end

tag "mail" do
    match :instance => "mutt"
    gravity :mai
end
## End Programs on view console [4]

# Gimp
tag "gimp_image" do
  match   :role => "gimp-image-window"
  gravity :gimp_image
end

tag "gimp_toolbox" do
  match   :role => "gimp-toolbox$"
  gravity :gimp_toolbox
end

tag "gimp_dock" do
  match   :role => "gimp-dock"
  gravity :gimp_dock
end

tag "gimp_scum" do
  match role: "gimp-.*|screenshot"
end

tag "vms" do
  match "VirtualBox"
  gravity :center66
end

#
# == Views
#

view "terms", "terms|imgs|default"
view "www",   "browser"
view "dev",   "code_.*"
view "console",   "pwd|music|cava|chat|mail"
view "gimp",  "gimp_.*"
view "vm",  "vms"

#
# Autorun
#

on :start do
    Subtlext::Client.spawn( "compton -b" )
    Subtlext::Client.spawn( "pscircle.sh" )
    Subtlext::Client.spawn( "#{ENV["TERMINAL"]}" )
    Subtlext::Client.spawn( "~/.config/polybar/launch.sh subtle" )
    Subtlext::Client.spawn( "~/.config/subtle/init-dev.sh" )
    Subtlext::Client.spawn( "~/.config/subtle/init-console.sh" )
    Subtlext::Client.spawn( "brave-sec" )
end

on :reload do
    Subtlext::Client.spawn( "~/.config/polybar/launch.sh subtle" )
    Subtlext::Client.spawn( "sh ~/.fehbg" )
end
