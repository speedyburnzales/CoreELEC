#! /bin/sh

# Install BruteFIR config if not existent
if [ ! -f "/storage/.brutefir_config" ]; then
    cp /storage/.kodi/addons/brutefir/share/brutefir/brutefir_config.example /storage/.brutefir_config
fi

. /storage/.kodi/addons/brutefir/bin/shutdown.sh

# Provide ALSA output
pactl load-module module-alsa-sink device_id=Impacto >> $PULSEAUDIO_MODULES_FILE      # Impacto
pactl load-module module-alsa-sink device_id=USB >> $PULSEAUDIO_MODULES_FILE      # AudioBox USB
pactl load-module module-alsa-sink >> $PULSEAUDIO_MODULES_FILE        # Hdmi (default)

# Load null-sink to loopback Kodi-output to BruteFIRs input-stream
pactl load-module module-null-sink sink_name="BruteFIR" >> $PULSEAUDIO_MODULES_FILE

# Declare null-sink as default output, will pickup audio from its monitor-out
pactl set-default-sink BruteFIR
