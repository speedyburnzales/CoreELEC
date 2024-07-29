# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brutefir"
PKG_VERSION="1.0o"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="Proprietary"
PKG_SITE="https://torger.se/anders/brutefir.html"
PKG_URL="http://github.com/chipfunk/${PKG_NAME}/archive/refs/tags/${PKG_VERSION}-pulse.tar.gz"
PKG_SHA256="e6c9af0e6fd504cb16f87da51bd75b2ecb2ef99aae50aea3c368b85265ba52f1"
PKG_MAINTAINER="chipfunk" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_HOST="flex"
PKG_DEPENDS_TARGET="pulseaudio alsa-lib fftw3 fftw3f"
PKG_SECTION=""
PKG_SHORTDESC="FIR convolver"
PKG_LONGDESC="BruteFIR is a software convolution engine, a program for applying long FIR filters to multi-channel digital audio."
PKG_TOOLCHAIN="make" # or one of auto, meson, cmake, cmake-make, configure, make, ninja, autotools, manual

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="BruteFIR"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_VERSION="1.0.0";
PKG_ADDON_REQUIRES="fftw3:1.0.0 fftw3f:1.0.0"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp ${PKG_BUILD}/brutefir ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  chmod +x ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/brutefir

  cp ${PKG_DIR}/startup.sh ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  chmod +x ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/startup.sh

  cp ${PKG_DIR}/shutdown.sh ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  chmod +x ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/shutdown.sh

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib
  cp ${PKG_BUILD}/*.bfio ${ADDON_BUILD}/${PKG_ADDON_ID}/lib
  cp ${PKG_BUILD}/*.bflogic ${ADDON_BUILD}/${PKG_ADDON_ID}/lib

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/share/brutefir
  cp ${PKG_DIR}/brutefir_config.example ${ADDON_BUILD}/${PKG_ADDON_ID}/share/brutefir
}
