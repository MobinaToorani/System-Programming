#!/bin/bash

################################################################################
# Assignment: System Status Script
# Author: Mobina Tooranisama
# Date: 2024-03-23
#
# Description:
#   This script monitors various system metrics such as CPU utilization, free memory,
#   and disk usage, and provides warnings if any metric exceeds a specified threshold.
# Usage:
#   sh ./system_status.sh
################################################################################

# Function to check CPU Utilization
cpu_utilization () {
    if [ -z "$1" ]; then
        echo "Usage: cpu_utilization <cpu_threshold_percentage>"
        return
    fi
    local cpu_threshold=$1
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    
    if [ "$(echo "$cpu_usage > $cpu_threshold" | bc)" -eq 1 ]; then
        echo "cpu utilization: $cpu_usage"
        echo "cpu warning!!"
    else
        echo "cpu utilization: $cpu_usage"
        echo "cpu ok!!"
    fi
}

# Function to check free memory
mem_free () {
    if [ -z "$1" ]; then
        echo "Usage: mem_free <free_memory_threshold_percentage>"
        return
    fi
    local mem_threshold=$1
    local mem_free=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')
    local mem_free_percent=$(echo "scale=2; 100 - $mem_free" | bc)
    
    if [ "$(echo "$mem_free_percent < $mem_threshold" | bc)" -eq 1 ]; then
        echo "percent memory free is : $mem_free_percent %"
        echo "memory warning!!"
    else
        echo "percent memory free is : $mem_free_percent %"
        echo "memory ok!!"
    fi
}

# Function to check disk usage
disk_usage () {
    if [ -z "$1" ]; then
        echo "Usage: disk_usage <disk_threshold_percentage>"
        return
    fi
    local disk_threshold=$1
    local disk_usage=$(df -H | awk '$NF=="/"{printf "%d", $5}' | sed 's/%//g')
    
    if [ "$disk_usage" -gt "$disk_threshold" ]; then
        echo "Disk usage: $disk_usage"
        echo "Disk warning!!"
    else
        echo "Disk usage: $disk_usage"
        echo "Disk ok!!"
    fi
}

# Function to send a system status report via email
send_report () {
    if [ -z "$1" ]; then
        echo "Usage: send_report <email_address>"
        return
    fi
    local email_address=$1
    local report_body="$(check_all)"
    
    echo "$report_body" | mail -s "System Status Report" "$email_address"
}

# Function to check all system metrics
check_all(){
    echo "########################################"
    echo "Testing CPU utilization, free memory, disk usage status of the system on $(date)"
    echo "########################################"
    cpu_utilization ${1:-80}
    mem_free ${2:-95}
    disk_usage ${3:-80}
    echo "########################################"
}

# Calling the function and sending the report
check_all $@ | send_report "sehra@wlu.ca"
