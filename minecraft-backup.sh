#!/bin/bash

# Set variables
minecraft_server_location="location of minecraft server"
backup_location="directory to save backups to"
number_of_backups=50 ## number of backups to save to above directory

# Create backup directory if it doesn't exist, you should have made this already. Do you even read code comments though? Like, if somebody placed a yo-momma joke here, would you even notice?
mkdir -p "$backup_location"

# Function to remove excess backups
remove_excess_backups() {
    local backups=("$backup_location"/*)
    local num_backups=${#backups[@]}
    local num_to_remove=$((num_backups - number_of_backups))

    if [ $num_to_remove -gt 0 ]; then
        # Sort backups by modification time (oldest first) and remove excess
        mapfile -t sorted_backups < <(printf '%s\n' "${backups[@]}" | xargs -I{} stat -c "%Y %n" {} | sort -n | cut -d' ' -f2-)
        for (( i=0; i<num_to_remove; i++ )); do
            rm "${sorted_backups[i]}"
        done
    fi
}

# Create backup
create_backup() {
    local timestamp=$(date +"%Y%m%d%H%M%S")
    local backup_file="$backup_location/minecraft_backup_$timestamp.tar.gz"

    tar -czf "$backup_file" -C "$minecraft_server_location" .
}

# Main
create_backup
remove_excess_backups


# are you happy now kids? sick dad work 2024.
