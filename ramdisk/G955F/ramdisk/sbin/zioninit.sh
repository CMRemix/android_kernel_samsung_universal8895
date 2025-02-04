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
###############################################################################################

## WAKELOCKS CONTROL
  # NATIVE WAKELOCKS CONTROL METHOD
  #chmod 644 /sys/module/wakeup/parameters/*
 	#echo N > /sys/module/wakeup/parameters/enable_sensorhub_wl
	#echo N > /sys/module/wakeup/parameters/enable_ssp_wl
	#echo N > /sys/module/wakeup/parameters/enable_bcmdhd4361_wl
	#echo N > /sys/module/wakeup/parameters/enable_wlan_wake_wl
	#echo N > /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
	#echo N > /sys/module/wakeup/parameters/enable_mmc0_detect_wl
	#echo N > /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
	#echo N > /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
	#echo N > /sys/module/wakeup/parameters/enable_wlan_wl
	#echo N > /sys/module/wakeup/parameters/enable_wlan_wow_wl
	#echo N > /sys/module/wakeup/parameters/enable_wlan_extscan_wl
	#echo N > /sys/module/wakeup/parameters/enable_netmgr_wl
	#echo N > /sys/module/wakeup/parameters/enable_NETLINK
	#echo N > /sys/module/wakeup/parameters/enable_wlan_txfl_wake
	#echo N > /sys/module/wakeup/parameters/enable_rmnet0
	#echo N > /sys/module/wakeup/parameters/enable_umts_ipc0
  #echo N > /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
  # BOEFFLA_WAKELOCK_BLOCKER
	chmod 644 /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker
	# echo "netmgr_wl;rmnet0;logd" > /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker
	echo "mmc0_detect;wlan_txfl_wake;ssp;ssp_common;sensorhub;NETLINK;bt_wake;bbd" > /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker
###############################################################################################

## Enable FSYNC
	echo "Y" > /sys/module/sync/parameters/fsync_enabled
###############################################################################################

## BLOCK
  # Reset read_ahead_kb to 128
for block_device in /sys/block/*
do
	echo 128 > $block_device/queue/read_ahead_kb
done
  # Set I/O Scheduler tweaks sda
  chmod 644 /sys/block/sda/queue/scheduler
  echo "maple" > /sys/block/sda/queue/scheduler
  # Set I/O Scheduler tweaks mmcblk0
	chmod 644 /sys/block/mmcblk0/queue/scheduler
	echo "maple" > /sys/block/mmcblk0/queue/scheduler
	echo "256" > /sys/block/mmcblk0/queue/read_ahead_kb
  #chmod 644 /sys/block/mmcblk0/queue/iosched/writes_starved
	#echo "4" > /sys/block/mmcblk0/queue/iosched/writes_starved
  #chmod 644 /sys/block/mmcblk0/queue/iosched/fifo_batch
	#echo "16" > /sys/block/mmcblk0/queue/iosched/fifo_batch
	#echo "350" > /sys/block/mmcblk0/queue/iosched/sync_read_expire
	#echo "550" > /sys/block/mmcblk0/queue/iosched/sync_write_expire
	#echo "250" > /sys/block/mmcblk0/queue/iosched/async_read_expire
	#echo "450" > /sys/block/mmcblk0/queue/iosched/async_write_expire
	#echo "10" > /sys/block/mmcblk0/queue/iosched/sleep_latency_multiple
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
###############################################################################################

## VM
  echo 1 > /proc/sys/vm/laptop_mode
# Default zpool for ZSWAP
	echo zsmalloc > /sys/module/zswap/parameters/zpool
###############################################################################################

## CPU PROFILE: A53 & M2
   # A53
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   echo 455000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   echo 1690000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
   echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
   echo "19000 1274000:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
   echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
   echo 858000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
   echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
   echo "75 1170000:85" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
   echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
   echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
   echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
   #chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/mode
   #echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/mode
   #chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/param_index
   #echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/param_index
   # M2
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   echo 741000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   echo 2002000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
   echo 89 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
   echo "59000 1248000:79000 1664000:19000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
   echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
   echo 1248000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
   echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
   echo "80 1040000:81 1352000:87 1664000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
   #chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/mode
   #echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/mode
   #chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/param_index
   #echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/param_index
## INPUT_BOOST
   # echo "1053000 741000" > /sys/kernel/cpu_input_boost/ib_freqs
   # echo "150" > /sys/kernel/cpu_input_boost/ib_duration_ms
   # echo "1" > /sys/kernel/cpu_input_boost/enabled
## CPU_BOOST
   # chmod 644 /sys/module/cpu_boost/parameters/input_boost_enabled
   # echo "1" /sys/module/cpu_boost/parameters/input_boost_enabled
   # chmod 644 /sys/module/cpu_boost/parameters/input_boost_freq
   # echo "0:1053000 4:741000" /sys/module/cpu_boost/parameters/input_boost_freq
   # chmod 644 /sys/module/cpu_boost/parameters/input_boost_ms
   # echo "100"  /sys/module/cpu_boost/parameters/input_boost_ms
## SAMSUNG_INPUT_BOOST A53-M2
   # Main
	 chmod 644 /sys/class/input_booster/*
	 echo "1" > /sys/class/input_booster/level
	 echo "170 962000 1053000 0 0 1" > /sys/class/input_booster/head
	 echo "0" > /sys/class/input_booster/tail
   # Multitouch
   # chmod 644 /sys/class/input_booster/multitouch/*
	 # echo "1 1066000 832000 0 0 1|2 858000 832000 0 0 1" > /sys/class/input_booster/multitouch/freq
   # echo "2" > /sys/class/input_booster/multitouch/level
   # echo "1 1200 0 0|2 0 700 0" > /sys/class/input_booster/multitouch/time
	 # Touch
   # chmod 644 /sys/class/input_booster/touch/*
	 # echo "1 1066000 832000 0 0 1|2 858000 832000 0 0 1" > /sys/class/input_booster/touch/freq
   # echo "2" > /sys/class/input_booster/touch/level
   # echo "1 1200 0 0|2 0 700 0" > /sys/class/input_booster/touch/time
###############################################################################################

## FLAGS
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
###############################################################################################

## SELINUX
# Change to Enforce Status.
#chmod 644 /sys/fs/selinux/enforce
#setenforce 0
# Fix SafetyNet by Repulsa
#chmod 640 /sys/fs/selinux/enforce
###############################################################################################

## Alive ?
if [ -f /system/etc/ZION_LOGs/zioninit_Test.log ] ; then
    rm /system/etc/ZION_LOGs/zioninit_Test.log
fi

echo "zioninit script is working" >> /system/etc/ZION_LOGs/zioninit_Test.log
echo "excecuted on $(date +"%d-%m-%Y %r" )" >> /system/etc/ZION_LOGs/zioninit_Test.log
