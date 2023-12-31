# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="sundog"
PKG_VERSION="dd9ea5de8648c26d218b152746bf66109ca611bf"
PKG_SHA256="1ac9d7c1b01c9013a23219e3b79cbbb29e38b6a148e6e72e6a247c64cef65d20"
PKG_ARCH="any"
PKG_SITE="https://github.com/laanwj/sundog"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_LONGDESC="A port of the Atari ST game SunDog: Frozen Legacy (1984) by FTL software "
PKG_TOOLCHAIN="make"

pre_configure_target() {
  cd src
  PKG_MAKE_OPTS_TARGET=" -C ${PKG_BUILD}/src sundog"
  sed -i "s|sdl2-config|$SYSROOT_PREFIX/usr/bin/sdl2-config|g" Makefile
  sed -i "s|-lreadline|-lreadline -lncurses|g" Makefile
}

makeinstall_target() {
	mkdir -p $INSTALL/usr/bin
	cp ${PKG_BUILD}/src/sundog $INSTALL/usr/bin
}
