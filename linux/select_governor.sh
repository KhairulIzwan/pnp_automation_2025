#!/bin/bash

# This script allows the user to select the CPU frequency governor from the available options
# for all CPUs in the system. It requires sudo privileges to set the governor.
#
# Usage: sudo ./select_governor.sh
#
# Functions:
# - get_current_governor: Prints the current CPU frequency governor.
# - list_available_governors: Lists all available CPU frequency governors.
# - list_available_governors_with_numbers: Lists all available CPU frequency governors with numbers.
# - set_governor_for_all_cpus: Sets the specified governor for all CPUs.
# - main: Main script logic to interact with the user and set the governor.

# Function to get the current governor
get_current_governor() {
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

# Function to list available governors
list_available_governors() {
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
}

# Function to list available governors with numbers
list_available_governors_with_numbers() {
    local governors=($(list_available_governors))
    for i in "${!governors[@]}"; do
        echo "$i) ${governors[$i]}"
    done
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
    echo "Current governor: $(get_current_governor)"
    echo "Available governors:"
    list_available_governors_with_numbers
    read -p "Enter the number of the governor you want to set: " selected_number
    governors=($(list_available_governors))
    selected_governor="${governors[$selected_number]}"
    set_governor_for_all_cpus "$selected_governor"
    echo "Switched all CPUs to $selected_governor"
else
    echo "CPU governor control not found!"
fi