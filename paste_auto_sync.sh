#!/bin/bash

# Define the path to the configuration file
CONFIG_FILE_PATH="config.txt"  # Replace with the actual path to your config file

# Function to read the configuration file and return an associative array of key-value pairs
declare -A config

function get_config {
    local file=$1
    while IFS='=' read -r key value; do
        if [[ ! $key =~ ^# && -n $key ]]; then
            config[$key]=$value
        fi
    done < "$file"
}

# Read the configuration file
get_config "$CONFIG_FILE_PATH"

# Extract values from the configuration
TARGET_MOUNT_POINT=${config["TargetMountPoint"]}
TARGET_LABEL=${config["TargetLabel"]}
SOURCE_DIRECTORY=${config["SourceDirectory"]}
IFS=',' read -r -a ITEMS_TO_COPY <<< "${config["ItemsToCopy"]}"
DESTINATION_FOLDER=${config["DestinationFolder"]}

# Construct the full destination path on the USB drive
SOURCE_DIRECTORY="$TARGET_MOUNT_POINT/$SOURCE_DIRECTORY"

# Function to get the mount point of the USB drive with the target label
function get_mount_point {
    local label=$1
    mount | grep "on /media/" | grep "${label}" | awk '{print $3}'
}

# Get the mount point of the USB drive
MOUNT_POINT=$(get_mount_point "$TARGET_LABEL")

# If the USB drive is mounted, perform the copy
if [[ -n $MOUNT_POINT && $MOUNT_POINT == $TARGET_MOUNT_POINT ]]; then
    for item in "${ITEMS_TO_COPY[@]}"; do
        SOURCE_PATH="$SOURCE_DIRECTORY/$item"
        DESTINATION_PATH="$DESTINATION_FOLDER/"
        
        if [[ -e $SOURCE_PATH ]]; then
            # Check if the item is a directory
            if [[ -d $SOURCE_PATH ]]; then
                # Forcefully copy the directory
                cp -rf "$SOURCE_PATH" "$DESTINATION_PATH"
            else
                # Forcefully copy the file
                cp -f "$SOURCE_PATH" "$DESTINATION_PATH"
            fi
        else
            echo "Source item does not exist: $SOURCE_PATH"
        fi
    done
else
    echo "Target USB drive is not mounted."
fi