#!/system/bin/sh
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

mount -o remount,rw /;
mount -o rw,remount /system

# Make internal storage directory.
if [ ! -d /data/zion ]; then
    DATA_RO=$(busybox mount | grep ' /data ' | grep -c 'ro,')
    if [ "$DATA_RO" -eq "1" ]; then
        busybox mount -o remount,rw /data
    fi
    mkdir /data/zion
    if [ "$DATA_RO" -eq "1" ]; then
        busybox mount -o remount,ro /data
    fi
fi;

# Synapse permissions
ROOTFS_RO=$(busybox mount | grep 'rootfs' | grep -c 'ro,')
if [ "$ROOTFS_RO" -eq "1" ]; then
    busybox mount -o remount,rw /
fi
if [ "$(busybox mount | grep 'rootfs' | grep -c 'ro,')" -eq "1" ]; then
    su -c "busybox mount -o remount,rw /"
fi
if [ "$(busybox mount | grep 'rootfs' | grep -c 'ro,')" -eq "1" ]; then
    log_print "can't mount rootfs"
else
    chmod -R 755 /res/*
    ln -fs /res/synapse/uci /sbin/uci
    /sbin/uci

    # Mount root as RO
    if [ "$ROOTFS_RO" -eq "1" ]; then
        busybox mount -o remount,ro /
        if [ "$(busybox mount | grep 'rootfs' | grep -c 'rw,')" -eq "1" ]; then
            su -c "busybox mount -o remount,ro /"
        fi
    fi
fi

# init.d support
if [ ! -e /system/etc/init.d ]; then
	mkdir /system/etc/init.d
	chown -R root.root /system/etc/init.d
	chmod -R 755 /system/etc/init.d
fi

# start init.d
for FILE in /system/etc/init.d/*; do
	sh $FILE >/dev/null
done;

# Alive ?
if [ -f /system/etc/ZION_LOGs/zionsysinit_Test.log ] ; then
    rm /system/etc/ZION_LOGs/zionsysinit_Test.log
fi

echo "Init.d is working" >> /system/etc/ZION_LOGs/zionsysinit_Test.log
echo "excecuted on $(date +"%d-%m-%Y %r" )" >> /system/etc/ZION_LOGs/zionsysinit_Test.log
