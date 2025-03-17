#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    install_azure_cli.sh
# Version:        1.24.0
# Author:         Feigelman Evgeny
# Date:           2025-02-12
# Description:    Updates .bashrc with Git completion and modifies
#                 HISTSIZE/HISTFILESIZE by appending an extra '0'.
#                 Ensures .bashrc is backed up only once before modification.
# -----------------------------------------------------

set -o errexit
set -o pipefail

#!/bin/bash

install_azure_cli() {
# Check if Azure CLI is installed

    if ! command -v az &>/dev/null; then
        echo "Azure CLI is NOT installed. Installing via pipx..."

        # Ensure pipx is installed
        if ! command -v pipx &>/dev/null; then
            echo "Installing pipx..."
            sudo apt update && sudo apt install -y pipx
            pipx ensurepath
            source ~/.bashrc
        fi

        # Install Azure CLI using pipx
        pipx install azure-cli

# Verify installation

	pipx ensurepath
	source ~/.bashrc
        if command -v az &>/dev/null; then
            echo "Azure CLI installed successfully!"
            az version
        else
            echo "Azure CLI installation failed!"
            return 1
        fi
    else
        echo "Azure CLI is already installed: $(which az)"
        az version  # Show version
    fi
}

# Call the function
install_azure_cli

