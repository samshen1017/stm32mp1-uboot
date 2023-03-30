#!/bin/bash

UBOOT_DIR=$PWD/u-boot-stm32mp-v2021.10-stm32mp-r2
ENV_SET=/home/isaac/toolchain/st/stm32mp1/4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi

# 更换需要编译的目标板
# TARGET_NAME=stm32mp157c-astro
TARGET_NAME=stm32mp157d-openedv

cd $UBOOT_DIR

#设置编译器
source $ENV_SET

if [ $1 == "debug" ]; then
    unset -v CFLAGS LDFLAGS
    make ARCH=arm CROSS_COMPILE=arm-ostl-linux-gnueabi- O="$PWD/../build" "$TARGET_NAME"_defconfig
    make ARCH=arm CROSS_COMPILE=arm-ostl-linux-gnueabi- O="$PWD/../build" DEVICE_TREE=$TARGET_NAME all

elif [ $1 == "copy" ]; then
    mkdir -p ../../image
    cp ../build/u-boot-nodtb.bin ../../image
    cp ../build/u-boot.dtb ../../image

elif [ $1 == "clean" ]; then
    make O="$PWD/../build" distclean
    rm -rf $PWD/../build
    rm -rf $PWD/../deploy
fi

