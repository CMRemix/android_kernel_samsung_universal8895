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

# WakeUp Parameter
 	chmod 644 /sys/module/wakeup/parameters/enable_sensorhub_wl
 	echo N > /sys/module/wakeup/parameters/enable_sensorhub_wl
	chmod 644 /sys/module/wakeup/parameters/enable_ssp_wl
	echo N > /sys/module/wakeup/parameters/enable_ssp_wl
	chmod 644 /sys/module/wakeup/parameters/enable_bcmdhd4361_wl
	echo N > /sys/module/wakeup/parameters/enable_bcmdhd4361_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_wake_wl
	chmod 644 /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
	echo N > /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
	chmod 644 /sys/module/wakeup/parameters/enable_mmc0_detect_wl
	echo N > /sys/module/wakeup/parameters/enable_mmc0_detect_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl

# Set I/O Scheduler tweaks mmcblk0
	chmod 644 /sys/block/mmcblk0/queue/scheduler
	echo "maple" > /sys/block/mmcblk0/queue/scheduler
	echo "512" > /sys/block/mmcblk0/queue/read_ahead_kb
    chmod 644 /sys/block/mmcblk0/queue/iosched/writes_starved
	echo "4" > /sys/block/mmcblk0/queue/iosched/writes_starved
    chmod 644 /sys/block/mmcblk0/queue/iosched/fifo_batch
	echo "16" > /sys/block/mmcblk0/queue/iosched/fifo_batch
	echo "350" > /sys/block/mmcblk0/queue/iosched/sync_read_expire
	echo "550" > /sys/block/mmcblk0/queue/iosched/sync_write_expire
	echo "250" > /sys/block/mmcblk0/queue/iosched/async_read_expire
	echo "450" > /sys/block/mmcblk0/queue/iosched/async_write_expire
	echo "10" > /sys/block/mmcblk0/queue/iosched/sleep_latency_multiple

# Set right permissions for block/*
    chmod 0664 /sys/block/block/*/iosched/*
    chmod 0664 /sys/block/*/queue/rotational
    chmod 0664 /sys/block/*/queue/add_random
# We need faster I/O so do not try to force moving to other CPU cores (dorimanx)
    for i in /sys/block/*/queue; do
	      echo "0" > "$i"/rotational;
				echo "0" > "$i"/add_random;
done
# mmcblk0
    echo 5 > /sys/block/mmcblk0/bdi/min_ratio
    echo 128 > /sys/block/mmcblk0/queue/read_ahead_kb

# VM
    echo 1 > /proc/sys/vm/laptop_mode

# Default zpool for ZSWAP
	echo zsmalloc > /sys/module/zswap/parameters/zpool

# Knox set to 0 on running system
    /sbin/resetprop -n ro.boot.warranty_bit "0"
    /sbin/resetprop -n ro.warranty_bit "0"

# Fix safetynet flags
    /sbin/resetprop -n ro.boot.veritymode "enforcing"
    /sbin/resetprop -n ro.boot.verifiedbootstate "green"
    /sbin/resetprop -n ro.boot.flash.locked "1"
    /sbin/resetprop -n ro.boot.ddrinfo "00000001"
    /sbin/resetprop -n ro.build.selinux "1"

# Samsung related flags
    /sbin/resetprop -n ro.fmp_config "1"
    /sbin/resetprop -n ro.boot.fmp_config "1"
    /sbin/resetprop -n sys.oem_unlock_allowed "0"

# Change to Enforce Status.
    setenforce 0
# Fix SafetyNet by Repulsa
    chmod 664 /sys/fs/selinux/enforce

# Alive ?
    if [ -f /system/etc/ZION_LOGs/zioninit_Test.log ] ; then
        rm /system/etc/ZION_LOGs/zioninit_Test.log
fi

    echo "Init.d is working" >> /system/etc/ZION_LOGs/zioninit_Test.log
    echo "excecuted on $(date +"%d-%m-%Y %r" )" >> /system/etc/ZION_LOGs/zioninit_Test.log
