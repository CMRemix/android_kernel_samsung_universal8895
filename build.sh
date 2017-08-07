#!/bin/bash

DEVICE=$1
if [ "$DEVICE" != "" ]; then
	echo
        echo "Starting your build for $DEVICE"
else
        echo ""
        echo "You need to define your device target!"
        echo "example: bash build.sh G955F or G950F"
        exit 1
fi

export ARCH=arm64
export PATH=~/Toolchains/aarch64-cortex_a53-linux-gnueabi/bin:$PATH
export CROSS_COMPILE=aarch64-cortex_a53-linux-gnueabi-

THREAD=-j$(bc <<< $(grep -c ^processor /proc/cpuinfo)+2)
KERNELDIR=`readlink -f .`;
BOOTDIR=$KERNELDIR/arch/$ARCH/boot/

# Make clean source
read -t 30 -p "Make clean source, 10sec timeout (y/n)?";
if [ "$REPLY" == "y" ]; then
make distclean;
make mrproper;
fi;

# clear ccache
read -t 30 -p "Clear ccache but keeping the config file, 10sec timeout (y/n)?";
if [ "$REPLY" == "y" ]; then
ccache -C;
fi;

# cleanup previous Image files
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
make $THREAD

# Build DTB
make dtbs

./utilities/dtbtool -o dt.img -s 2048 -p ./scripts/dtc/dtc arch/arm64/boot/dts/exynos/

# Make Ramdisk
if [ "$DEVICE" = "G955F" ]; then
    ./utilities/mkbootfs ramdisk/G955F/ramdisk | lzma > ramdisk.packed
fi;
if [ "$DEVICE" = "G950F" ]; then
    ./utilities/mkbootfs ramdisk/G950F/ramdisk | lzma > ramdisk.packed
fi;

# Make BootImage
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

echo "Build completed"
