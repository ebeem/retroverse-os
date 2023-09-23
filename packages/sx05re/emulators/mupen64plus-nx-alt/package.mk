# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-nx-alt"
PKG_VERSION="26fd1edd640ff3db49dd5ebb7e54f0de6600fc45"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain nasm:host $OPENGLES"
PKG_SECTION="libretro"
PKG_LONGDESC="Improved mupen64plus libretro core reimplementation"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"
PKG_EE_UPDATE=no

pre_configure_target() {
  sed -e "s|^GIT_VERSION ?.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile

if [ $ARCH == "arm" ]; then
  if [ "${DEVICE}" = "Amlogic-old" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=emuelec BOARD=OLD32BIT"
  elif [ "${DEVICE}" = "OdroidGoAdvance" ] || [ "$DEVICE" == "GameForce" ]; then
    sed -i "s|cortex-a53|cortex-a35|g" Makefile
    PKG_MAKE_OPTS_TARGET+=" platform=odroidgoa"
  elif [ "$DEVICE" == "OdroidM1" ] || [ "$DEVICE" == "RK356x" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=emuelec BOARD=NGRK32BIT"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=AMLG12B"
  fi
else
  if [ "${DEVICE}" = "Amlogic-old" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=emuelec BOARD=OLD"
  elif [ "$DEVICE" == "OdroidM1" ] || [ "$DEVICE" == "RK356x" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=emuelec BOARD=NGRK"
  elif [ "${DEVICE}" = "OdroidGoAdvance" ] || [ "$DEVICE" == "GameForce" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=emuelec BOARD=NGHH"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=odroid64 BOARD=N2"
  fi
fi

PKG_MAKE_OPTS_TARGET+=" LLE=1"
PKG_MAKE_OPTS_TARGET+=" HAVE_PARALLEL_RSP=1"
PKG_MAKE_OPTS_TARGET+=" HAVE_PARALLEL_RDP=1"
PKG_MAKE_OPTS_TARGET+=" HAVE_LTCG=1"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mupen64plus_next_libretro.so $INSTALL/usr/lib/libretro/mupen64plus_next_alt_libretro.so
}
