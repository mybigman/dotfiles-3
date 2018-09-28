#!/usr/bin/env sh

killall -q polybar

polybar_proc=$(pgrep -u $UID -x polybar)

# Terminate already running bar instances
for i in ${polybar_proc} ; do
    kill -9 $i
done

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar top & bottom
polybar top &
polybar top-second &
#polybar bottom-launcher &
# polybar bottom &

# For i3
# polybar i3top &
# polybar i3secondtop &
# polybar i3bottom &

echo "Bars launched..."
