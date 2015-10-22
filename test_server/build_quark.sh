#!/bin/bash

DTLS_EN="dtls=n"

for i in $@; do
  case "$i" in
    dtls)
    DTLS_EN="dtls=y"
    ;;
  esac
done

ROOTFS="/opt/iot-devkit/1.7.2/sysroots/i586-poky-linux"
if [ -z $ROOTFS ]; then
  echo "Error: path to Quark root filesystem must be defined in 'build_quark.sh' script"
  exit 1
fi
if [ ! -e $ROOTFS ]; then
  echo "Error: path to Quark root filesystem '$ROOTFS' not found"
  exit 1
fi

SDK="/opt/iot-devkit/1.7.2/sysroots/x86_64-pokysdk-linux"
if [ -z $SDK ]; then
  echo "Error: path to Quark SDK must be defined in 'build_quark.sh' script"
  exit 1
fi
if [ ! -e $SDK ]; then
  echo "Error: path to Quark SDK '$SDK' not found"
  exit 1
fi

CC="${SDK}/usr/bin/i586-poky-linux/i586-poky-linux-gcc"
EXTRA_CFLAGS="-m32 -march=i586 -O2 -pipe -g -feliminate-unused-debug-types"
LD="${SDK}/usr/bin/i586-poky-linux/i586-poky-linux-ld"
EXTRA_LDFLAGS=""
EXTRA_LIBS=""

make "${DTLS_EN}" "ROOTFS=${ROOTFS}" "CC=${CC}" "EXTRA_CFLAGS=${EXTRA_CFLAGS}" "LD=${CC}" "EXTRA_LDFLAGS=${EXTRA_LDFLAGS}" "EXTRA_LIBS=${EXTRA_LIBS}"
