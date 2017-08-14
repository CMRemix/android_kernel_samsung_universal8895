#!/bin/bash

# Colorize and add text parameters
export red=$(tput setaf 1)             #  red
export grn=$(tput setaf 2)             #  green
export blu=$(tput setaf 4)             #  blue
export cya=$(tput setaf 6)             #  cyan
export txtbld=$(tput bold)             #  Bold
export bldred=${txtbld}$(tput setaf 1) #  red
export bldgrn=${txtbld}$(tput setaf 2) #  green
export bldblu=${txtbld}$(tput setaf 4) #  blue
export bldcya=${txtbld}$(tput setaf 6) #  cyan
export txtrst=$(tput sgr0) 

DEVICE=$1
if [ "$DEVICE" != "" ]; then
	echo
        echo "${bldcya}***Starting your build for $DEVICE***${txtrst}"
else
        echo ""
        echo "${bldred}***You need to define your device target!***${txtrst}"
        echo "${bldred}***example: bash build.sh G955F or G950F***${txtrst}"
        exit 1
fi

export ARCH=arm64
export PATH=~/Toolchains/aarch64-cortex_a53-linux-gnueabi/bin:$PATH
export CROSS_COMPILE=aarch64-cortex_a53-linux-gnueabi-

THREAD=-j$(bc <<< $(grep -c ^processor /proc/cpuinfo)+2)
KERNELDIR=`readlink -f .`;
BOOTDIR=$KERNELDIR/arch/$ARCH/boot/

# Make clean source
read -t 30 -p "${bldred}***Make clean source, 10sec timeout (y/n)?***${txtrst}";
if [ "$REPLY" == "y" ]; then
make distclean;
make mrproper;
fi;

# clear ccache
read -t 30 -p "${bldred}***Clear ccache but keeping the config file, 10sec timeout (y/n)?***${txtrst}";
if [ "$REPLY" == "y" ]; then
ccache -C;
fi;

# cleanup previous Image files
echo "${bldgrn}***Clean Up Junks***${txtrst}"
find . -type f -name "*~" -exec rm -f {} \;
find . -type f -name "*orig" -exec rm -f {} \;
find . -type f -name "*rej" -exec rm -f {} \;

rm -rf $KERNELDIR/arch/arm64/boot/dts/exynos/*.dtb;

if [ -e $KERNELDIR/dt.img ]; then
	rm $KERNELDIR/dt.img;
fi;
if [ -e $KERNELDIR/boot.tar ]; then
	rm $KERNELDIR/boot.tar;
fi;
if [ -e $KERNELDIR/out/G955F/dream2lte.img ]; then
	rm $KERNELDIR/out/G955F/dream2lte.img;
fi;
if [ -e $KERNELDIR/out/G950F/dreamlte.img ]; then
	rm $KERNELDIR/out/G950F/dreamlte.img;
fi;
if [ -e $KERNELDIR/ramdisk.packed ]; then
	rm $KERNELDIR/ramdisk.packed;
fi;
if [ -e $KERNELDIR/$BOOTDIR/Image ]; then
	rm $KERNELDIR/$BOOTDIR/Image;
fi;
if [ -e $KERNELDIR/$BOOTDIR/dt.img ]; then
	rm $KERNELDIR/$BOOTDIR/dt.img;
fi;
if [ -e $KERNELDIR/$BOOTDIR/Image ]; then
	rm $KERNELDIR/$BOOTDIR/Image;
fi;
if [ -e $KERNELDIR/$BOOTDIR/Image.gz ]; then
	rm $KERNELDIR/$BOOTDIR/Image.gz;
fi;

# Create Output Directory
echo "${bldgrn}***Create Kernel Output Folder***${txtrst}"
if [ "$DEVICE" = "G955F" ]; then
mkdir -p $KERNELDIR/out/G955F
fi;
if [ "$DEVICE" = "G950F" ]; then
mkdir -p $KERNELDIR/out/G950F
fi;

# G955F
if [ "$DEVICE" = "G955F" ]; then
    make exynos8895-dream2lte_eur_open_defconfig
fi;
# G950F
if [ "$DEVICE" = "G950F" ]; then
    make exynos8895-dreamlte_eur_open_defconfig
fi;

# Build Kernel
echo "${bldgrn}***Compile Kernel Source Code***${txtrst}"
make $THREAD

# Build DTB
echo "${bldgrn}***Make DTBS***${txtrst}"
make dtbs

./utilities/dtbtool -o dt.img -s 2048 -p ./scripts/dtc/dtc arch/arm64/boot/dts/exynos/

# Make Ramdisk
echo "${bldgrn}***Create Ramdisk***${txtrst}"
if [ "$DEVICE" = "G955F" ]; then
    ./utilities/mkbootfs ramdisk/G955F/ramdisk | gzip > ramdisk.packed
fi;
if [ "$DEVICE" = "G950F" ]; then
    ./utilities/mkbootfs ramdisk/G950F/ramdisk | gzip > ramdisk.packed
fi;

# Make BootImage
echo "${bldgrn}***Create Boot Image***${txtrst}"
./utilities/mkbootimg \
      --kernel arch/arm64/boot/Image \
      --ramdisk ramdisk.packed \
      --cmdline "" \
      --base 0x10000000 \
      --pagesize 2048 \
      --dt dt.img \
      --ramdisk_offset 0x01000000 \
      --tags_offset 0x00000100 \
      --output boot.img

echo SEANDROIDENFORCE >> boot.img
if [ "$DEVICE" = "G955F" ]; then
    mv boot.img out/G955F/dream2lte.img
fi;
if [ "$DEVICE" = "G950F" ]; then
    tar -cvf boot.tar boot.img
    mv boot.img out/G950F/dreamlte.img
fi;

echo "${bldred}***Build completed Please Check the OUTPUT folder***${txtrst}"
