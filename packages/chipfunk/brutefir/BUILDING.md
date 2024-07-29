# Build the addon

The addon is build using LibreELEC.tv build-system, so this has to be setup first.


## Clone LibreELEC.tv

    git clone https://github.com/LibreELEC/LibreELEC.tv
    cd LibreELEC.tv


## Checkout release

    git checkout 11.0.4


## Make a directory to hold package and dependencies

In LibreELEC.tv repository create a subfolder for additional packages

    mkdir -p packages/chipfunk
    cd packages/chipfunk/


## Clone requirements

    git clone https://github.com/chipfunk/LibreELEC.tv-addon-fftw3 fftw3
    git clone https://github.com/chipfunk/LibreELEC.tv-addon-fftw3f fftw3f


## Clone addon package

    git clone https://github.com/chipfunk/LibreELEC.tv-addon-brutefir brutefir


## Prepare build environment

You can add environment-variables to build for a specific target-device and -platform. Now is a good time to do so.

For a Hardkernel Odroid-C2 i use

    PROJECT=LibreELEC
    PROJECT=Amlogic
    DEVICE=AMLGX
    ARCH=arm


## Build a release first

This step can take a long time ...

In LibreELEC.tv repository run

    make release


In the meantime get something to hydrate yourself.


## Build this addon

In LibreELEC.tv repository run

    scripts/create_addon brutfir

to actually build the addon.

You should end-up with a zip-file in folder

    target/addons/11.0/${PROJECT}/brutefir/brutefir-${VERSION}-${ADDON_VERSION}.zip

