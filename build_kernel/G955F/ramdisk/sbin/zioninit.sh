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

# Busybox
if [ -e /su/xbin/busybox ]; then
	BB=/su/xbin/busybox;
else if [ -e /sbin/busybox ]; then
	BB=/sbin/busybox;
else
	BB=/system/xbin/busybox;
fi;
fi;

# Mount
$BB mount -t rootfs -o remount,rw rootfs;
$BB mount -o remount,rw /system;
$BB mount -o remount,rw /data;
$BB mount -o remount,rw /;

#######################CANDY IN################################

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

# Enable FSYNC
	echo "N" > /sys/module/sync/parameters/fsync_enabled
#####################CANDY OUT###############################

######################BLOCK TWEAKS IN#################################

# Set right permissions for sda,b,c,d
  chown root system /sys/block/sd*/queue/scheduler
  chmod 0664 /sys/block/sd*/queue/scheduler
  chown root system /sys/block/sd*/queue/iosched
  chmod 0664 /sys/block/sd*/queue/iosched/*
  chown root system /sys/block/sd*/queue/rotational
  chmod 0664 /sys/block/sd*/queue/rotational
  chown root system /sys/block/sd*/queue/add_random
  chmod 0664 /sys/block/sd*/queue/add_random
  chown root system /sys/block/sd*/queue/rq_affinity
  chmod 0664 /sys/block/sd*/queue/rq_affinity

# We need faster I/O so do not try to force moving to other CPU cores (dorimanx)
for i in /sys/block/sd*/queue; do
	      echo "0" > "$i"/rotational;
		    echo "1" > "$i"/rq_affinity;
				echo "0" > "$i"/add_random;
done

# Set right permissions for mmcblk0
	chown root system /sys/block/mmcblk0/queue/scheduler
  chmod 0664 /sys/block/mmcblk0/queue/scheduler
  chown root system /sys/block/mmcblk0/queue/iosched
  chmod 0664 /sys/block/mmcblk0/queue/iosched/*
  chown root system /sys/block/mmcblk0/queue/rotational
  chmod 0664 /sys/block/mmcblk0/queue/rotational
  chown root system /sys/block/mmcblk0/queue/add_random
  chmod 0664 /sys/block/mmcblk0/queue/add_random
  chown root system /sys/block/mmcblk0/queue/rq_affinity
  chmod 0664 /sys/block/mmcblk0/queue/rq_affinity

for i in /sys/block/mmcblk0/queue; do
	      echo "0" > "$i"/rotational;
		    echo "1" > "$i"/rq_affinity;
				echo "0" > "$i"/add_random;
done

# Set right permissions for vnswap0
	chown root system /sys/block/vnswap0/queue/scheduler
  chmod 0664 /sys/block/vnswap0/queue/scheduler
  chown root system /sys/block/vnswap0/queue/iosched
  chmod 0664 /sys/block/vnswap0/queue/iosched/*
  chown root system /sys/block/vnswap0/queue/rotational
  chmod 0664 /sys/block/vnswap0/queue/rotational
  chown root system /sys/block/vnswap0/queue/add_random
  chmod 0664 /sys/block/vnswap0/queue/add_random
  chown root system /sys/block/vnswap0/queue/rq_affinity
  chmod 0664 /sys/block/vnswap0/queue/rq_affinity

for i in /sys/block/vnswap0/queue; do
        echo "0" > "$i"/rotational;
	      echo "1" > "$i"/rq_affinity;
				echo "0" > "$i"/add_random;
done

# Set I/O Scheduler tweaks mmcblk0
	echo maple > /sys/block/mmcblk0/queue/scheduler
	echo 512 > /sys/block/mmcblk0/queue/read_ahead_kb
	echo 4 > /sys/block/mmcblk0/queue/iosched/writes_starved
	echo 16 > /sys/block/mmcblk0/queue/iosched/fifo_batch
	echo 350 > /sys/block/mmcblk0/queue/iosched/sync_read_expire
	echo 550 > /sys/block/mmcblk0/queue/iosched/sync_write_expire
	echo 250 > /sys/block/mmcblk0/queue/iosched/async_read_expire
	echo 450 > /sys/block/mmcblk0/queue/iosched/async_write_expire
	echo 10 > /sys/block/mmcblk0/queue/iosched/sleep_latency_multiple

# Set I/O Scheduler tweaks sda
	echo maple > /sys/block/sda/queue/scheduler
	echo 256 > /sys/block/sda/queue/read_ahead_kb
	echo 4 > /sys/block/sda/queue/iosched/writes_starved
	echo 16 > /sys/block/sda/queue/iosched/fifo_batch
	echo 350 > /sys/block/sda/queue/iosched/sync_read_expire
	echo 550 > /sys/block/sda/queue/iosched/sync_write_expire
	echo 250 > /sys/block/sda/queue/iosched/async_read_expire
	echo 450 > /sys/block/sda/queue/iosched/async_write_expire
	echo 10 > /sys/block/sda/queue/iosched/sleep_latency_multiple

# Set I/O Scheduler tweaks sdb, sdc, sdd, vnswap0
  echo bfq > /sys/block/sdb/queue/scheduler
	echo bfq > /sys/block/sdc/queue/scheduler
	echo bfq > /sys/block/sdd/queue/scheduler
  echo bfq > /sys/block/vnswap0/queue/scheduler

#######################BLOCK TWEAKS OUT#############################

#######################SELINUX, MAGISK FLAGS IN################################

# Fix SafetyNet by Repulsa
$BB chmod 640 /sys/fs/selinux/enforce

# Knox set to 0 on running system
/sbin/resetprop -n ro.boot.warranty_bit "0"
/sbin/resetprop -n ro.warranty_bit "0"

# Fix safetynet flags
/sbin/resetprop -n ro.boot.veritymode "enforcing"
/sbin/resetprop -n ro.boot.verifiedbootstate "green"
/sbin/resetprop -n ro.boot.flash.locked "1"
/sbin/resetprop -n ro.boot.ddrinfo "00000001"

# Samsung related flags
/sbin/resetprop -n ro.fmp_config "1"
/sbin/resetprop -n ro.boot.fmp_config "1"
/sbin/resetprop -n sys.oem_unlock_allowed "0"

#######################SELINUX, MAGISK FLAGS OUT################################

# Deepsleep fix
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:0/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:1/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:2/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:3/cache_type'

# Google play services wakelock fix
sleep 1
su -c "pm enable com.google.android.gms/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver"

############################# ARE YOU ALIVE IN ?############################


if [ -e /data/.zion959/alive-test.log ]; then
	rm /data/.zion959/alive-test.log;
fi;
echo  Kernel script is working !!! >> /data/.zion959/alive-test.log;
echo "excecuted on $(date +"%d-%m-%Y %r" )" >> /data/.zion959/alive-test.log;

############################# ARE YOU ALIVE OUT ?############################

# Unmount
$BB mount -t rootfs -o remount,rw rootfs;
$BB mount -o remount,ro /system;
$BB mount -o remount,rw /data;
$BB mount -o remount,ro /;
