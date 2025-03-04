#!/bin/bash

# This script toggles the CPU frequency governor between 'performance' and 'powersave' modes
# for all CPUs in the system. It requires sudo privileges to set the governor.
#
# Usage: sudo ./toggle_governor.sh
#
# Functions:
# - get_current_governor: Prints the current CPU frequency governor.
# - toggle_governor: Toggles the CPU frequency governor between 'performance' and 'powersave'.
# - set_governor_for_all_cpus: Sets the specified governor for all CPUs.
# - main: Main script logic to interact with the user and toggle the governor.

# Function to get the current governor
get_current_governor() {
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

# Function to toggle the governor
toggle_governor() {
    local current_governor="$1"
    if [[ "$current_governor" == "performance" ]]; then
        echo "powersave"
    else
        echo "performance"
    fi
}

# Function to set the governor for all CPUs
set_governor_for_all_cpus() {
    local new_governor="$1"
    for cpu in $(ls -d /sys/devices/system/cpu/cpu[0-9]* | sort -V); do
        cpu_name="${cpu#/sys/devices/system/cpu/}"  # Extract 'cpu0', 'cpu1', ...
        echo -n "$cpu_name : "
        echo "$new_governor" | sudo tee "$cpu/cpufreq/scaling_governor"
    done
}

# Main script logic
if [[ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor ]]; then
    current_governor=$(get_current_governor)
    new_governor=$(toggle_governor "$current_governor")
    set_governor_for_all_cpus "$new_governor"
    echo "Switched all CPUs to $new_governor"
else
    echo "CPU governor control not found!"
fi