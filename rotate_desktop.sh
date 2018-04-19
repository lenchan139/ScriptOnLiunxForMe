#!/bin/bash
#
# rotate_desktop.sh

# Configure these to match your hardware (names taken from `xinput` output).
TOUCHPAD='ASUS HID Device ASUS HID Device Touchpad'
TOUCHSCREEN='ELAN2562:00 04F3:2562'
TOUCHPEN='ELAN2562:00 04F3:2562 Pen Pen (0)'

if [ -z "$1" ]; then
  echo "Missing orientation."
  echo "Usage: $0 [normal|inverted|left|right] [revert_seconds]"
  echo
  exit 1
fi

function do_rotate
{
  xrandr --output $1 --rotate $2

  TRANSFORM='Coordinate Transformation Matrix'

  case "$2" in
    normal)
      #[ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      [ ! -z "$TOUCHSCREEN" ] && xinput set-prop "$TOUCHSCREEN" "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      [ ! -z "$TOUCHPEN" ] && xinput set-prop "$TOUCHPEN" "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      [ ! -z "$TOUCHPAD" ]    && xinput --disable "$TOUCHPAD"   
      ;;
    inverted)
      #[ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      [ ! -z "$TOUCHSCREEN" ] && xinput set-prop "$TOUCHSCREEN" "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      [ ! -z "$TOUCHPEN" ] && xinput set-prop "$TOUCHPEN" "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      [ ! -z "$TOUCHPAD" ]    && xinput --disable "$TOUCHPAD"   
      ;;
    left)
      #[ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      [ ! -z "$TOUCHSCREEN" ] && xinput set-prop "$TOUCHSCREEN" "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      [ ! -z "$TOUCHPEN" ] && xinput set-prop "$TOUCHPEN" "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      [ ! -z "$TOUCHPAD" ]    && xinput --disable "$TOUCHPAD"   
      ;;
    right)
      #[ ! -z "$TOUCHPAD" ]    && xinput set-prop "$TOUCHPAD"    "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      [ ! -z "$TOUCHSCREEN" ] && xinput set-prop "$TOUCHSCREEN" "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      [ ! -z "$TOUCHPEN" ] && xinput set-prop "$TOUCHPEN" "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      [ ! -z "$TOUCHPAD" ]    && xinput --disable "$TOUCHPAD"   
      ;;
  esac
}

XDISPLAY=`xrandr --current | grep primary | sed -e 's/ .*//g'`
XROT=`xrandr --current --verbose | grep primary | egrep -o ' (normal|left|inverted|right) '`

do_rotate $XDISPLAY $1

if [ ! -z "$2" ]; then
  sleep $2
  do_rotate $XDISPLAY $XROT
  exit 0
fi

