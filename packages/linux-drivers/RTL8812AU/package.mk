# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8812AU"
PKG_VERSION="d98018d038a5db96066e79f26ed4a72f2fe1774e"
PKG_SHA256="69891a35724a6c30fcb29d9eba783879e0bee3f5f7847341fce06101a7542f5f"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/aircrack-ng/rtl8812au"
PKG_URL="https://github.com/aircrack-ng/rtl8812au/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8812AU Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
export KCFLAGS+=" -Wno-array-bounds -Wno-stringop-overflow -Wno-restrict -Wno-address -Wno-stringop-overread"
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
