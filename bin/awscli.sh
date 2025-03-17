#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    aws_cli.sh
# Version:        1.24.0
# Author:         Feigelman Evgeny
# Date:           2025-02-14
# Description:    This script manages AWS CLI installation, update, and removal.
set -o errexit
set -o pipefail

# -----------------------------------------------------

aws_cli() {
    uninstall_aws_cli() {
        echo "Uninstalling AWS CLI..."
        sudo rm -f /usr/local/bin/aws /usr/local/bin/aws_completer
        sudo rm -rf /usr/local/aws-cli
        read -p "Remove AWS CLI configurations in ~/.aws? (y/n): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            sudo rm -rf ~/.aws && echo "AWS CLI configurations removed."
        fi
        echo "AWS CLI uninstalled successfully."
    }

    install_aws_cli() {
        CURRENT_USER=$(logname)
        TEMP_DIR=$(mktemp -d)
        sudo chown -R $CURRENT_USER:$CURRENT_USER $TEMP_DIR
        sudo -u $CURRENT_USER bash -c "
            cd $TEMP_DIR && \
            curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
            unzip awscliv2.zip && \
            sudo ./aws/install --update
        "
        sudo rm -rf $TEMP_DIR
        echo "AWS CLI installation completed."
    }

    if [[ $EUID == "0" ]] || [[ $UID == "0" ]]; then
        echo "Do not use root user or sudo "
        exit 1
    fi

    if [ -x "$(command -v aws)" ]; then
        echo "Found preexisting AWS CLI installation."
        PS3="Select an option: "
        select opt in "Update AWS CLI" "Remove AWS CLI" "Skip"; do
            case $opt in
                "Update AWS CLI") install_aws_cli; break
		;;
                "Remove AWS CLI") uninstall_aws_cli; break
		;;
                "Skip") echo "Operation cancelled."; 
		break;;
                *) echo "Invalid option.";;
            esac
        done
    else
        read -p "AWS CLI not found. Install now? (y/n): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            install_aws_cli
        else
            echo "Installation cancelled."
        fi
    fi
}

# To use this script in another script, source it and call aws_cli:
# source $WORKDIR/bin/awscli.sh
# aws_cli

