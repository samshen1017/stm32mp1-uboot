#!/bin/bash

UBOOT_DIR=$PWD/u-boot-stm32mp-v2021.10-stm32mp-r2
ENV_SET=/home/isaac/toolchain/st/stm32mp1/4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi

cd $UBOOT_DIR

#设置编译器
source $ENV_SET

#设置FIP目录
export FIP_DEPLOYDIR_ROOT=/home/isaac/mywork/github/FIP_artifacts-stm32mp1/FIP_artifacts

if [ $1 == "all" ]; then
    #编译所有目标板
    make -f $PWD/../Makefile.sdk DEPLOYDIR=$FIP_DEPLOYDIR_ROOT/u-boot all

elif [ $1 == "astro" ]; then
    #编译定制板
    # DEVICETREE="<devicetree1> <devicetree2>"
    make -f $PWD/../Makefile.sdk DEPLOYDIR=$FIP_DEPLOYDIR_ROOT/u-boot DEVICETREE="stm32mp157c-astro" all

elif [ $1 == "clean" ]; then
    make -f $PWD/../Makefile.sdk clean
    rm -rf $PWD/../build
fi

