#!/bin/bash
if ! command -v xdotool &> /dev/null; then
    echo "Error: xdotool is not installed. Please install it first: sudo apt install xdotool"
    exit 1
fi

LOG_FILE="$HOME/.steam/steam/logs/webhelper.txt"
touch "$LOG_FILE"
echo "Listening to $LOG_FILE"

tail -f "$LOG_FILE" | while read -r line; do
    if [[ $line =~ ChatWindow_ && $line =~ System\ window:\ (0x[0-9a-fA-F]+) ]]; then
        window_id="${BASH_REMATCH[1]}"
        echo "New chat window: $window_id"
        xdotool windowmap --sync "$window_id" > /dev/null 2>&1

        # Comment this out if you don't want to bring the window to the front
        #xdotool windowactivate "$window_id" > /dev/null 2>&1
    fi
done
