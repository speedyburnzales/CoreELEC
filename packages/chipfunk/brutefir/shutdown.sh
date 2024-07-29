#! /bin/sh

# Where to store loaded module-IDs
PULSEAUDIO_MODULES_FILE=/storage/.brutefir-pulseaudio.modules

# Unload previous loaded modules
for i in `cat $PULSEAUDIO_MODULES_FILE`; do pactl unload-module "$i"; done

rm $PULSEAUDIO_MODULES_FILE
