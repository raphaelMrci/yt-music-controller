#!/bin/bash

ACTION=$1

case $ACTION in
  open)
    osascript scripts/open_tab.applescript
    ;;
  shuffle)
    osascript scripts/shuffle.applescript
    ;;
  playpause)
    osascript scripts/play_pause.applescript
    ;;
  next)
    osascript scripts/next.applescript
    ;;
  previous)
    osascript scripts/previous.applescript
    ;;
  *)
    echo "Unknown action: $ACTION"
    ;;
esac
