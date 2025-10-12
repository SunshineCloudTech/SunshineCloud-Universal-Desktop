#!/bin/bash

# Docker Entrypoint Script for SunshineCloud Universal Desktop
# This script initializes various services and starts the desktop environment

set -e

echo "Starting SunshineCloud Universal Desktop container..."

# Set environment variables for services
export HOME=/root
export USER=root
export SHELL=/bin/bash
export TERM=xterm

# Function to log messages with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to ensure directory exists with proper permissions
ensure_dir() {
    local dir=$1
    local owner=${2:-root:root}
    local perms=${3:-755}
    
    if [ ! -d "$dir" ]; then
        sudo mkdir -vp "$dir"
        log "Created directory: $dir"
    fi
    sudo chown "$owner" "$dir" 2>/dev/null || true
    sudo chmod "$perms" "$dir" 2>/dev/null || true
}

# Function to cleanup PID files and stop services gracefully
cleanup() {
    log "Received termination signal, cleaning up..."
    
    # Stop services gracefully
    log "Stopping services..."
    sudo service xrdp stop 2>/dev/null || true
    sudo service supervisor stop 2>/dev/null || true
    sudo service mysql stop 2>/dev/null || true
    sudo service redis-server stop 2>/dev/null || true
    
    # Remove PID files
    log "Cleaning up PID files..."
    sudo rm -f /var/run/xrdp.pid /var/run/xrdp*.pid 2>/dev/null || true
    sudo rm -f /run/xrdp.pid /run/xrdp*.pid 2>/dev/null || true
    sudo rm -f /var/run/supervisor.pid 2>/dev/null || true
    sudo rm -f /var/run/mysqld/mysqld.pid 2>/dev/null || true
    sudo rm -f /var/run/redis/redis-server.pid 2>/dev/null || true
    
    log "Cleanup completed"
    exit 0
}

# Function to clean stale PID files and processes
clean_stale_resources() {
    log "Cleaning stale PID files and processes..."
    
    # Clean XRDP related PID files
    local xrdp_pids=("/var/run/xrdp.pid" "/var/run/xrdp-sesman.pid" "/run/xrdp.pid" "/run/xrdp-sesman.pid")
    for pid_file in "${xrdp_pids[@]}"; do
        if [ -f "$pid_file" ]; then
            local pid=$(cat "$pid_file" 2>/dev/null || echo "")
            if [ -n "$pid" ]; then
                if ! sudo kill -0 "$pid" 2>/dev/null; then
                    log "Removing stale PID file: $pid_file (process $pid not running)"
                    sudo rm -f "$pid_file" 2>/dev/null || true
                else
                    log "Killing existing process $pid from $pid_file"
                    sudo kill -TERM "$pid" 2>/dev/null || true
                    sleep 2
                    sudo kill -KILL "$pid" 2>/dev/null || true
                    sudo rm -f "$pid_file" 2>/dev/null || true
                fi
            else
                log "Removing empty PID file: $pid_file"
                sudo rm -f "$pid_file" 2>/dev/null || true
            fi
        fi
    done
    
    # Clean other service PID files
    local other_pids=("/var/run/supervisor.pid" "/var/run/mysqld/mysqld.pid" "/var/run/redis/redis-server.pid")
    for pid_file in "${other_pids[@]}"; do
        if [ -f "$pid_file" ]; then
            local pid=$(cat "$pid_file" 2>/dev/null || echo "")
            if [ -n "$pid" ] && ! kill -0 "$pid" 2>/dev/null; then
                log "Removing stale PID file: $pid_file"
                sudo rm -f "$pid_file" 2>/dev/null || true
            fi
        fi
    done
    
    # Kill any remaining xrdp processes
    sudo pkill -f xrdp 2>/dev/null || true
    sudo pkill -f sesman 2>/dev/null || true
    
    log "Stale resource cleanup completed"
}

# Set up signal handlers for graceful shutdown
trap cleanup SIGTERM SIGINT SIGQUIT

# Clean stale resources before starting services
clean_stale_resources

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
sudo service supervisor start || log "Warning: Failed to start supervisor"

# Restart D-Bus service
log "Restarting D-Bus service..."
sudo service dbus restart || log "Warning: Failed to restart D-Bus"

# Start XRDP service
log "Starting XRDP service..."

# Ensure required directories exist with proper permissions
ensure_dir "/var/run" "root:root" "755"
ensure_dir "/var/log/xrdp" "xrdp:xrdp" "755"
ensure_dir "/run" "root:root" "755"
ensure_dir "/tmp/.X11-unix" "root:root" "1777"

# Double-check PID files are clean before starting XRDP
sudo rm -f /var/run/xrdp*.pid /run/xrdp*.pid 2>/dev/null || true

# Ensure xrdp configuration is accessible
if [ -f "/etc/xrdp/xrdp.ini" ]; then
    sudo chmod 644 /etc/xrdp/xrdp.ini 2>/dev/null || log "Warning: Could not change permissions for xrdp.ini"
fi
if [ -f "/etc/xrdp/sesman.ini" ]; then
    sudo chmod 644 /etc/xrdp/sesman.ini 2>/dev/null || log "Warning: Could not change permissions for sesman.ini"
fi

# Start XRDP with explicit configuration
if sudo service xrdp start; then
    log "XRDP service started successfully"
else
    log "Warning: Failed to start XRDP service, attempting alternative start method..."
    # Try starting xrdp directly
    sudo /usr/sbin/xrdp --nodaemon &
    sudo /usr/sbin/xrdp-sesman --nodaemon &
    sleep 2
    log "XRDP started using direct method"
fi

# Set up display for GUI applications
export DISPLAY=:0

log "All services have been initialized"
log "Container is ready for use"

# Function to monitor services and restart if needed
monitor_services() {
    while true; do
        sleep 30
        
        # Check if XRDP is running
        if ! pgrep -f "xrdp" > /dev/null 2>&1; then
            log "XRDP process not found, attempting to restart..."
            clean_stale_resources
            if sudo service xrdp start; then
                log "XRDP restarted successfully via service"
            else
                log "Service restart failed, trying direct start..."
                sudo /usr/sbin/xrdp --nodaemon &
                sudo /usr/sbin/xrdp-sesman --nodaemon &
                sleep 2
                log "XRDP restarted using direct method"
            fi
        fi
    done
}

# Enhanced cleanup function that also kills monitor process
enhanced_cleanup() {
    log "Enhanced cleanup: stopping monitor and services..."
    
    # Kill monitor process if it exists
    if [ -n "$MONITOR_PID" ]; then
        sudo kill "$MONITOR_PID" 2>/dev/null || true
    fi
    
    # Call original cleanup
    cleanup
}

# Update signal handler to use enhanced cleanup
trap enhanced_cleanup SIGTERM SIGINT SIGQUIT

# Start service monitor in background
monitor_services &
MONITOR_PID=$!

log "Service monitoring started (PID: $MONITOR_PID)"

# Keep the container running with an interactive bash shell
# Handle the case where we want to keep the container running but responsive to signals
if [ $# -eq 0 ]; then
    # No arguments provided, start interactive bash but keep monitoring
    log "Starting interactive bash session..."
    sudo -u matrix0523 bash 
else
    # Arguments provided, execute them
    log "Executing provided command: $*"
    bash "$@"
fi
