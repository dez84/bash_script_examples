#!/bin/bash

# Define log file
log_file="/var/log/server_update.log"

# Function to log messages with timestamps
log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S"): $1" >> "$log_file"
}

# Check if the script is run with root privileges if [[ $EUID -ne 0 ]]; then
   log "This script must be run as root."
   exit 1
fi

# Update package lists
log "Updating package lists..."
apt-get update >> "$log_file" 2>&1
log "Package lists updated."

# Upgrade packages
log "Upgrading packages..."
apt-get upgrade -y >> "$log_file" 2>&1
log "Packages upgraded."

# Remove unnecessary packages
log "Removing unnecessary packages..."
apt-get autoremove -y >> "$log_file" 2>&1 log "Unnecessary packages removed!"

# Clean up package cache
log "Cleaning up package cache..."
apt-get clean >> "$log_file" 2>&1
log "Package cache cleaned."

# Check for errors in the log file
if grep -q "error" "$log_file"; then
    log "Errors occurred during the update process. Check $log_file for details."
else
    log "Server update completed successfully!"
fi

