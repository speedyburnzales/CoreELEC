# BruteFIR for LibreELEC.tv

This project builds [BruteFIR with PulseAudio support](https://github.com/chipfunk/brutefir) as addon for [LibreELEC.tv](https://libreelec.tv) based distributions.

As the patches to BruteFIR are not yet ready for inclusion in the official BruteFIR release, i do NOT use the orignal sources from [Anders Torger's homepage for BruteFIR](http://www.ludd.ltu.se/~torger/brutefir.html), but my own [integration-repository](https://github.com/chipfunk/brutefir).


The packaged BruteFIR supports the following IO modules:

- `pulse` for connecting to a [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/)-server
- `alsa` for traditional [ALSA](https://www.alsa-project.org/) support
- `file` for file-/pipe-support
- `eq`
- `cli`

Mixing different input-/output-modules has NOT been tested yet.


## Installation

As there is no addon-repository available the addon and its requirements have to be installed via ZIP-file.

Copy resulting zip-file to libreelec-host or some other (USB-)storage-device.

Install addon using the menu `Install from ZIP-file`.


### Prerequisites

[FFTW3](https://fftw.org) has to be available as a shared library. It is provided as two separate addons that have to be installed.

- [fftw3](https://github.com/chipfunk/LibreELEC.tv-addon-fftw3//releases)
- [fftw3f](https://github.com/chipfunk/LibreELEC.tv-addon-fftw3f//releases)


## Configuration

BruteFIR loads its configuration from file `/storage/.brutefir_config`.

The provided example in `brutefir_config.example` will be copied in place if no existing config-file is found.

By configuring a PulseAudio `device`-name the sound-server will auto-connect the sink-inputs and source-outputs to the configured and available sinks and sources.

Configure different application-names via param `app_name` if you have multiple instances of BruteFIR connecting to the same PulseAudio-server.


## Service startup and shutdown

The described audio-setup is provided by script `/storage/.kodi/addons/brutefir/usr/share/brutefir/startup.sh`, which is executed on service-startup.

The loaded modules are then stored in `/storage/.brutefir-pulseaudio.modules`.

The modules are unloaded on service-shutdown or -failure by `/storage/.kodi/addons/brutefir/usr/share/brutefir/shutdown.sh`.


## Setup audio-routing via PulseAudio

I've choosen this setup as it gives me a short and constant delay in audio-output when playing media in KODI.

Kernel-module `snd-aloop` is missing, so the audio-signal is routed through PulseAudio.

By giving a null-sink the name `BruteFIR` we get a monitoring output named `BruteFIR.monitor` in PulseAudio.
This output will be picked up by BruteFIR's IO-module `pulse`.

The filtered output from BruteFIR is available as a PulseAudio source-output,
which has to be connected to an output for actual sound, e.g. the ALSA-device "default".


### Configure PulseAudio to provide null-sink to stream to BruteFIR

Load null-sink to loopback KODI-output to BruteFIRs input-stream

    pactl load-module module-null-sink sink_name="BruteFIR"


### Activate ALSA soundcard

Provide ALSA-card to PulseAudio by loading module `module-alsa-sink`. The resulting sink will be named `alsa_output.default`.

    pactl load-module module-alsa-sink device=default


### Set default sink

Declare null-sink as default output, BruteFIR will pickup audio from its monitor-out `BruteFIR.monitor`.

    pactl set-default-sink BruteFIR


### Reboot

You should hear sounds when reboot is completed.

In KODI settings `Settings -> System -> Audio` the previously available ALSA-devices should be gone, because the PulseAudio module `module-als-sink` already uses them.


### Set KODI to output audio via PulseAudio

If you don't hear any sounds by now, use the menu `Settings -> System -> Audio` to switch KODI output to PulseAudio.


## Troubleshooting

### Plugin fails to install

Sometimes the plugin fails to install. I'm not sure yet what ist causing this.
Reboot and try again, it helped most of time.
Or try deleting all plugin-files manually.


### Commands systemd

A short list of helpful commands for pulseaudio

#### List input-elements

    pactl list sinks
    pactl list sources

#### List output-elements

    pactl list sink-inputs
    pactl list source-outputs


#### Start the service

    systemctl start brutefir.service


#### Stop the service

    systemctl stop brutefir.service


#### Restart the service

    systemctl restart brutefir.service


Happy filtering :)

