#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  while read -r m; do
    if [ "$(echo $m | cut -d " " -f3)" == "primary" ];then
      MONITOR_NAME=$(echo $m | cut -d " " -f1)
      if [ $MONITOR_NAME == "DP-1" ];then
        MONITOR=$MONITOR_NAME BAR_HEIGHT="1.5%" DPI=120 polybar --reload -c $HOME/.config/polybar/config top &
      else
        MONITOR=$MONITOR_NAME BAR_HEIGHT="2.5%" DPI=96 polybar --reload -c $HOME/.config/polybar/config top &
      fi
    fi
  done < <(xrandr --query | grep " connected")
else
  polybar -c $HOME/.config/polybar/config top &
fi
