   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   echo 455000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   echo 1690000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
   echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
   echo "25000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
   echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
   echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
   echo "-1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
   echo "80 455000:33 598000:40 715000:50 832000:60 949000:67 1053000:80 1248000:92 1456000:98 1690000:98" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
   echo 50000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
   echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
   echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   echo 741000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   echo 2314000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
   echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
   echo "20000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
   echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
   echo 1469000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
   echo "-1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
   echo "74 741000:61 858000:69 962000:64 1066000:74 1170000:69 1261000:70 1469000:79 1703000:88 1807000:90 1937000:92 2002000:95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   echo 30000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
   echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
