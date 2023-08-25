#!/bin/bash

cpu_threshold=90
memory_threshold=90

while true; do
   cpu_usage=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
   memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

   if (( $(echo "$cpu_usage > $cpu_threshold" | bc -l) )); then
       echo "CPU usage is high: $cpu_usage%"
       # Send alert (e.g., email, SMS)
   fi

   if (( $(echo "$memory_usage > $memory_threshold" | bc -l) )); then
       echo "Memory usage is high: $memory_usage%"
       # Send alert (e.g., email, SMS)
   fi

   sleep 300  # Check every 5 minutes
done

