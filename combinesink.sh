#!/bin/bash

# Name of the combined sink
SINK_NAME="combined_out"
SINK_DESC="Combined Speakers + Headphones"

# First, unload old module if it exists
pactl unload-module module-combine-sink 2>/dev/null

# Load a new combined sink
# Replace 'alsa_output.pci-0000_00_1b.0.analog-stereo' etc. with your real sink names (check with: pactl list short sinks)
pactl load-module module-combine-sink sink_name=$SINK_NAME sink_properties=device.description="$SINK_DESC" slaves=alsa_output.pci-0000_00_1b.0.analog-stereo,alsa_output.usb-Logitech_USB_Headset-00.analog-stereo

# Set it as default sink
pactl set-default-sink $SINK_NAME
