#!/system/bin/sh
# ZION959 PROFILE MANAGER
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
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   echo 741000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   echo 2314000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
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
   echo 30000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration

   # INPUT_BOOST
   echo "949000 858000" > /sys/kernel/cpu_input_boost/ib_freqs
   echo "700" > /sys/kernel/cpu_input_boost/ib_duration_ms
   echo "0" > /sys/kernel/cpu_input_boost/enabled
