
#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    add_aliases.sh
# Version:        1.24.0
# Author:         Feigelman Evgeny
# Date:           2025-02-12
# Description:    This script will add a many useble alieases.
#                 
#         
set -o errexit
set -o pipefail
set -x
# -----------------------------------------------------
BASH_ALIASES=$HOME/.bash_aliases
# Check if .bash_aliases is already exists and if no,add one

if [ -e $BASH_ALIASES ]; then 
    echo ".bash_aliases is already exists"
else
    
