# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team CoreELEC (https://coreelec.org)

PKG_NAME="media_modules-aml"
PKG_VERSION="e39b85e2ba8a18816c62fd4b22fa3e14ad53bc35"
PKG_SHA256="39a510e8c469c083d83c70f974c4f60f5efddf7b748b82ff65980b6b2a9417fc"
PKG_LICENSE="GPL"
PKG_SITE="https://coreelec.org"
PKG_URL="https://github.com/CoreELEC/media_modules-aml/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="${PKG_NAME}: Linux driver"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make -C $(kernel_path) M=${PKG_BUILD}/drivers \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG12=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG2_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG4=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG4_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_VC1=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264_MVC=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H265=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_VP9=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MJPEG=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MJPEG_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_REAL=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS2=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS3=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AV1=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS3=m
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    find ${PKG_BUILD}/ -name \*.ko -not -path '*/\.*' -exec cp {} ${INSTALL}/$(get_full_module_dir)/${PKG_NAME} \;

  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/video/NO_TEE
    for soc in ${TEE_SOC}; do
      cp -PR ${PKG_BUILD}/firmware/${soc} ${INSTALL}/$(get_full_firmware_dir)/video
    done
    cp -PR ${PKG_BUILD}/firmware/video_ucode.bin ${INSTALL}/$(get_full_firmware_dir)/video/NO_TEE

  mkdir -p ${INSTALL}/usr/lib/coreelec
    install -m 0755 ${PKG_DIR}/scripts/media_modules-aml.sh ${INSTALL}/usr/lib/coreelec/media_modules-aml
}

post_install() {
  enable_service media_modules-aml.service
}
