#!/bin/bash
################################
######usage#####################
#To restore a backup, you would run the script with the backup file name as an argument [AFTER shutting down the running server instance.....], like so:
#./minecraft_restore.sh /path/to/backup/location/minecraft_backup_20240101120000.tar.gz
################################


# Set variables
backup_location="/path/to/backup/location"
minecraft_server_location="/path/to/minecraft/server"

# Function to restore backup
restore_backup() {
    local backup_file="$1"

    # Ensure backup file exists
    if [ ! -f "$backup_file" ]; then
        echo "Backup file '$backup_file' not found."
        exit 1
    fi

    # Extract backup to Minecraft server directory
    tar -xzf "$backup_file" -C "$minecraft_server_location"

    echo "Backup '$backup_file' successfully restored."
}

# Main
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <backup_file>"
    exit 1
fi

restore_backup "$1"
