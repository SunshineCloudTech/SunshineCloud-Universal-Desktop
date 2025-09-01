#!/bin/bash
# PulseAudio initialization script for XFCE desktop

# Check if PulseAudio is already running
if ! pgrep -x "pulseaudio" > /dev/null; then
    echo "Starting PulseAudio..."
    
    # Create user pulse directory if it doesn't exist
    mkdir -p ~/.pulse
    
    # Copy XRDP modules if they exist
    if [ -d "/var/lib/xrdp-pulseaudio-installer" ]; then
        PULSE_MODULE_DIR=$(pulseaudio --dump-modules 2>/dev/null | grep -o '/usr/lib/[^/]*/pulse-[0-9.]*/modules' | head -1)
        if [ -n "$PULSE_MODULE_DIR" ] && [ -d "$PULSE_MODULE_DIR" ]; then
            sudo cp /var/lib/xrdp-pulseaudio-installer/*.so "$PULSE_MODULE_DIR/"
            echo "XRDP PulseAudio modules copied to $PULSE_MODULE_DIR"
        fi
    fi
    
    # Start PulseAudio with proper configuration
    pulseaudio --start --log-target=syslog --daemonize=yes
    
    # Wait for PulseAudio to be ready
    sleep 2
    
    # Check if PulseAudio started successfully
    if pgrep -x "pulseaudio" > /dev/null; then
        echo "PulseAudio started successfully"
        
        # Set default sink and source if available
        pactl set-default-sink xrdp-sink 2>/dev/null || true
        pactl set-default-source xrdp-source 2>/dev/null || true
        
        # Enable audio in XFCE
        xfconf-query -c xfce4-mixer -p /active-card -s "$(pactl info | grep 'Default Sink:' | cut -d' ' -f3)" 2>/dev/null || true
    else
        echo "Failed to start PulseAudio"
    fi
else
    echo "PulseAudio is already running"
fi
