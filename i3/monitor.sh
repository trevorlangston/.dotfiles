#!/bin/bash
INTERNAL_OUTPUT="eDP-1"
EXTERNAL_OUTPUT=`xrandr | grep " connected " | awk '{ print$1 }' | sed -n 2p`

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="EXTERNAL"
        # xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --mode 1920x1080
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="EXTERNAL"
        # xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --mode 1920x1080
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
else
        monitor_mode="all"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --left-of $INTERNAL_OUTPUT
fi

echo "${monitor_mode}" > /tmp/monitor_mode.dat
