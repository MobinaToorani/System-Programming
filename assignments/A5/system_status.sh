#!/bin/bash

################################################################################
# Assignment: System Status Script
# Author: Mobina Toorani
# Date: 2024-03-25
#
# Description:
#   This script monitors various system metrics such as CPU utilization, free memory,
#   and disk usage, and provides warnings if any metric exceeds a specified threshold.
#
# Instructions:
#   1. Complete the implementation of the following functions:
#      - cpu_utilization: Check CPU utilization and compare it with a threshold percentage.
#      - mem_free: Check free memory percentage and compare it with a threshold.
#      - disk_usage: Check disk usage percentage and compare it with a threshold.
#      - send_report: Send the system status report to the provided email address.

cpu_utilization () {
    if [ -z "$1" ]; then
        echo "Usage: cpu_utilization <cpu_threshold_percentage>"
        exit 1
    fi

    if [ "$1" -lt 0 ] || [ "$1" -gt 100 ]; then
        echo "Enter the CPU threshold percentage between 0 to 100"
        exit 1
    fi

    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "cpu utilization: $cpu_usage"
    if (( $(echo "$cpu_usage > $1" |bc -l) )); then
        echo "cpu warning!!"
    else
        echo "cpu ok!!"
    fi
}

mem_free () {
    if [ -z "$1" ]; then
        echo "Usage: mem_free <free_memory_threshold_percentage>"
        exit 1
    fi

    if [ "$1" -lt 0 ] || [ "$1" -gt 100 ]; then
        echo "Enter the free memory threshold percentage between 0 to 100"
        exit 1
    fi

    mem_free=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "percent memory free is: $mem_free %"
    if (( $(echo "$mem_free < $1" |bc -l) )); then
        echo "memory warning!!"
    else
        echo "memory ok!!"
    fi
}

disk_usage () {
    if [ -z "$1" ]; then
        echo "Usage: disk_usage <disk_threshold_percentage>"
        exit 1
    fi

    if [ "$1" -lt 0 ] || [ "$1" -gt 100 ]; then
        echo "Enter the disk usage threshold percentage between 0 to 100"
        exit 1
    fi

    disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    echo "Disk usage: $disk_usage"
    if [ "$disk_usage" -gt "$1" ]; then
        echo "Disk warning!!"
    else
        echo "Disk ok!!"
    fi
}

send_report () {
    if [ -z "$1" ]; then
        echo "Usage: send_report <email_address>"
        exit 1
    fi

    report=$(check_all)
    echo "$report" | mail -s "System Status Report" "$1"
}

check_all(){
    echo "##########################################"
    echo "Testing CPU utilization, free memory, disk usage status of the system on $(date)"
    echo "##########################################"
    cpu_utilization 80
    echo "##########################################"
    mem_free 95
    echo "##########################################"
    disk_usage 80
    echo "##########################################"
    echo "Capturing the system status"
    echo "Sending email with the system status to $1"
    echo "##########################################"
}

send_report "toor6720@mylaurier.ca"
check_all
