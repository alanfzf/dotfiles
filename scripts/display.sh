#!/bin/bash

# Check if the script path argument is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide the path of the xrandr script as an argument."
    exit 1
fi

# Check if the provided file exists
script_path=$1
if [ ! -f "$script_path" ]; then
    echo "Error: The specified file does not exist."
    exit 1
fi

# Move the xrandr script to be globally available
sudo mv "$script_path" /usr/local/bin/xrandr-script.sh

sudo tee /etc/lightdm/lightdm.conf > /dev/null <<EOF
[Seat:*]
display-setup-script=/usr/local/bin/xrandr-script.sh
EOF

# Inform the user about the changes made
echo "xrandr script moved to /usr/local/bin/ and configured in lightdm.conf"
