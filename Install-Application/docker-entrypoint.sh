#!/bin/bash

# Docker Entrypoint Script for SunshineCloud Universal Desktop
# This script initializes various services and starts the desktop environment

set -e

echo "Starting SunshineCloud Universal Desktop container..."

# Function to log messages with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to check if a service is running
# check_service() {
#     local service_name=$1
#     if systemctl is-active --quiet "$service_name" 2>/dev/null; then
#         log "$service_name is running"
#         return 0
#     else
#         log "$service_name is not running"
#         return 1
#     fi
# }

# Initialize SSH
log "Initializing SSH service..."
if [ -f "/usr/local/share/ssh-init.sh" ]; then
    /usr/local/share/ssh-init.sh
    log "SSH initialization completed"
else
    log "Warning: SSH init script not found"
fi

# Initialize Docker
log "Initializing Docker service..."
if [ -f "/usr/local/share/docker-init.sh" ]; then
    /usr/local/share/docker-init.sh
    log "Docker initialization completed"
else
    log "Warning: Docker init script not found"
fi

# Start supervisor service
log "Starting supervisor service..."
service supervisor start || log "Warning: Failed to start supervisor"

# Restart D-Bus service
log "Restarting D-Bus service..."
service dbus restart || log "Warning: Failed to restart D-Bus"

# Start XRDP service
log "Starting XRDP service..."
service xrdp start || log "Warning: Failed to start XRDP"

# Start MySQL if it exists
# if [ -d "/SunshineCloud/MySQL-Server" ]; then
#     log "Starting MySQL service..."
#     service mysql start || log "Warning: Failed to start MySQL"
# fi

# Start Redis if it exists
# if command -v redis-server &> /dev/null; then
#     log "Starting Redis service..."
#     service redis-server start || log "Warning: Failed to start Redis"
# fi

# Set up display for GUI applications
export DISPLAY=:0

log "All services have been initialized"
log "Container is ready for use"

# Keep the container running with an interactive bash shell
exec bash "$@"
