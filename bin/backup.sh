
#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    backup.sh
# Version:        1.1.1
# Author:         Feigelman Evgeny
# Date:           2025-02-12
# Description:    This script will install most of needed packages, that you will use
#                 during your dayly work as a DevOps expert. Fill free to tell me if
#                 you think that this script can be improved.
set -o errexit
set -o pipefail

# -----------------------------------------------------

backup_dir=$HOME/backup
timestamp=$(date "+%Y-%m-%d")
backup_file="$backup_dir/backup_$timestamp.tar.gz"
original_user=$USER
original_group=$(id -gn "$original_user")
original_owner="$original_user:$original_group"
echo $original_owner

# Functuion taht will check if this folder is already exists and create in case it is not.
backupdir(){
    if [ ! -d $backup_dir  ]; then 
        echo "No backup directory, creating one"
        mkdir -p $backup_dir
    else
        echo "Backup directory is already exists, checking if it jas right permission"
            if [ ! -w $backup_dir  ]; then
                echo "All set, starting a backup"
            else
                echo "Please check permissons"
            fi
    fi
}
backup_files(){
    tmp_dir=$(mktemp -d -t backup-XXXX)
    mkdir -p $tmp_dir/etc
    sudo find /etc/ -type f -name "*.conf" -exec cp {} $tmp_dir/etc  \;
    mkdir  $tmp_dir/home
    sleep 1
    sudo find /home/$SUDO_USER -type f -name ".*" -exec cp {} $tmp_dir/home  \;
    sleep 1
    sudo tar cvzf $backup_file $tmp_dir/*
    sudo chown $original_owner $backup_file

    if [[ $? -eq 0  ]];then 
        echo "Backup succeded"
    else
        echo "Backup failed"
    fi
}

backup(){
backupdir
backup_files
}
