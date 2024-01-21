#!/bin/bash

# 08DA82
docker run -v /Users/nielsouvrard/Documents/ti83pce/asm_eZ80/:/workspace -e DISPLAY=10.20.86.103:0 -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" --privileged -it --rm epitech_container zsh