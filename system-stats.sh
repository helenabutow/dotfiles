#!/bin/bash

system_stats=$(/usr/local/bin/tmux-mem-cpu-load -m 1 -g 0 -a 0)
 
disk_latency=$(cd /tmp; /usr/local/bin/ioping -q -T 50ms -i 100ms -c 10 . | grep -F 'min/avg/max' | awk -F'=' '{ print $2 }' | awk -F'/' '{ print $2 }' | tr -d ' ')
 
free_space=$(df -H / | tail -n +2 | awk '{ print $4 }')
 
echo "$system_stats $disk_latency $free_space | font=HelveticaNeue"
