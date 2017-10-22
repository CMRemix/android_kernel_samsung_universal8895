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
        echo "${bldcya}***You need to define your device target!***${txtrst}"
        echo "${bldred}***example: bash build.sh G955F or G950F or N950F***${txtrst}"
        exit 1
fi

export ARCH=arm64
export PATH=~/Toolchains/aarch64-linux-android-6.x/bin:$PATH
export CROSS_COMPILE=aarch64-linux-android-

THREAD=-j$(bc <<< $(grep -c ^processor /proc/cpuinfo)+2)
KERNELDIR=`readlink -f .`;
BOOTDIR=$KERNELDIR/arch/$ARCH/boot/
BK=build

# Make clean source
echo
read -t 30 -p "${bldred}***Make clean source, 10sec timeout (y/n)?***${txtrst}";
if [ "$REPLY" == "y" ]; then
make distclean;
make mrproper;
fi;

# clear ccache
echo
read -t 30 -p "${bldred}***Clear ccache but keeping the config file, 10sec timeout (y/n)?***${txtrst}";
if [ "$REPLY" == "y" ]; then
ccache -C;
fi;

# cleanup previous Image files
echo
echo "${bldgrn}***Clean Up Junks***${txtrst}"
find . -type f -name "*~" -exec rm -f {} \;
find . -type f -name "*orig" -exec rm -f {} \;
find . -type f -name "*rej" -exec rm -f {} \;

rm -rf $KERNELDIR/arch/arm64/boot/dts/exynos/*.dtb;

rm -rf ${KERNELDIR}/out/$DEVICE/*

if [ -e $KERNELDIR/dt.img ]; then
	rm $KERNELDIR/dt.img;
fi;
if [ -e $KERNELDIR/boot.tar ]; then
	rm $KERNELDIR/boot.tar;
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
echo
echo "${bldgrn}***Create Kernel Output Folder***${txtrst}"
mkdir -p $KERNELDIR/out/$DEVICE

# G955F
if [ "$DEVICE" = "G955F" ]; then
    make exynos8895-dream2lte_eur_open_defconfig
fi;
# G950F
if [ "$DEVICE" = "G950F" ]; then
    make exynos8895-dreamlte_eur_open_defconfig
fi;
# N950F
if [ "$DEVICE" = "N950F" ]; then
    make exynos8895-greatlte_eur_open_defconfig
fi;

# Build Kernel
echo "${bldgrn}***Compile Kernel Source Code***${txtrst}"
make $THREAD

# fix ramdisk permissions
echo
echo "${bldgrn}***Fixed Ramdisk Permissions***${txtrst}"
cd ${KERNELDIR}/$BK
cp ./ramdisk_fix_permissions.sh /${KERNELDIR}/ramdisk/$DEVICE/ramdisk/ramdisk_fix_permissions.sh
cd ${KERNELDIR}/ramdisk/$DEVICE/ramdisk/
chmod 0777 ramdisk_fix_permissions.sh
./ramdisk_fix_permissions.sh 2>/dev/null
rm -f ramdisk_fix_permissions.sh

# Build DTB
echo
echo "${bldgrn}***Make DTBS***${txtrst}"
cd ${KERNELDIR}/
make dtbs
./utilities/dtbtool -o dt.img -s 2048 -p ./scripts/dtc/dtc arch/arm64/boot/dts/exynos/

# Make Ramdisk
echo
echo "${bldgrn}***Create Ramdisk***${txtrst}"
if [ "$DEVICE" = "G955F" ]; then
    ./utilities/mkbootfs ramdisk/G955F/ramdisk | gzip > ramdisk.packed
fi;
if [ "$DEVICE" = "G950F" ]; then
    ./utilities/mkbootfs ramdisk/G950F/ramdisk | gzip > ramdisk.packed
fi;
if [ "$DEVICE" = "N950F" ]; then
    ./utilities/mkbootfs ramdisk/N950F/ramdisk | gzip > ramdisk.packed
fi;

# Make BootImage
echo
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

echo -n "SEANDROIDENFORCE" >> boot.img
if [ "$DEVICE" = "G955F" ]; then
    tar -cvf boot.tar boot.img
    mv boot.img out/G955F/dream2lte.img
fi;
if [ "$DEVICE" = "G950F" ]; then
    tar -cvf boot.tar boot.img
    mv boot.img out/G950F/dreamlte.img
fi;
if [ "$DEVICE" = "N950F" ]; then
    tar -cvf boot.tar boot.img
    mv boot.img out/N950F/greatlte.img
fi;

# Generate Changelog
echo
read -t 30 -p "${bldred}**Generate Changelog, 30 sec timeout (y/n)?***${txtrst}";
if [ "$REPLY" == "y" ]; then
bash changelog.sh
fi;

echo
echo "${bldcya}***** Make archives *****${txtrst}"

cp -R ./$BK/apps ${KERNELDIR}/out/$DEVICE/
cp -R ./$BK/kernel ${KERNELDIR}/out/$DEVICE/
cp -R ./$BK/magisk ${KERNELDIR}/out/$DEVICE/
cp -R ./$BK/META-INF ${KERNELDIR}/out/$DEVICE/
cp -R ./$BK/su ${KERNELDIR}/out/$DEVICE/
if [ "$DEVICE" = "G955F" ]; then
cp -R ${KERNELDIR}/out/$DEVICE/dream2lte.img ${KERNELDIR}/out/$DEVICE/kernel
rm -f ${KERNELDIR}/out/$DEVICE/dream2lte.img
fi;
if [ "$DEVICE" = "G950F" ]; then
cp -R ${KERNELDIR}/out/$DEVICE/dreamlte.img ${KERNELDIR}/out/$DEVICE/kernel
rm -f ${KERNELDIR}/out/$DEVICE/dreamlte.img
fi;
if [ "$DEVICE" = "N950F" ]; then
cp -R ${KERNELDIR}/out/$DEVICE/greatlte.img ${KERNELDIR}/out/$DEVICE/kernel
rm -f ${KERNELDIR}/out/$DEVICE/greatlte.img
fi;

cd ${KERNELDIR}/out/$DEVICE
GET_VERSION=`grep 'S8_NN_*V' ${KERNELDIR}/.config | sed 's/.*".//g' | sed 's/-S.*//g'`

cd ${KERNELDIR}/out/$DEVICE/kernel/ZION/
zip -r ../ZION.zip *
rm -rf ${KERNELDIR}/out/$DEVICE/kernel/ZION/
cd ${KERNELDIR}/out/$DEVICE/
zip -r ZION959-$DEVICE-Kernel-${GET_VERSION}-`date +[%d-%m-%y]`.zip .

echo
echo "Done"

echo "${bldcya}***Build completed Please Check the OUTPUT folder***${txtrst}"
