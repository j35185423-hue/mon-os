#!/bin/bash
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  startx /usr/bin/emulationstation
fi
