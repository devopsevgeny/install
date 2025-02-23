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
#Check if .bash_alias snippet already exists and add of needed.
add_bash_aliases_source() {
    local bashrc="$HOME/.bashrc"
    local snippet='if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi'
    
    if ! grep -Fxq "$snippet" "$bashrc"; then
        echo -e "\n$snippet" >> "$bashrc"
        echo "Snippet added to $bashrc"
    else
        echo "Snippet already present in $bashrc"
    fi
}

# Check if .bash_aliases is already exists and if no,add one
add_top_aliases(){
    if [ ! -f $BASH_ALIASES ]; then 
        curl -fLo $BASH_ALIASES https://raw.githubusercontent.com/devopsevgeny/install/refs/heads/main/aliases/aliases
        echo ".bash_aliases created , do not forget to source .bashrc "
    else
        cp $BASH_ALIASES $BASH_ALIASES.old
        curl -fLo $BASH_ALIASES https://raw.githubusercontent.com/devo psevgeny/install/refs/heads/main/aliases/aliases
    fi
}
# Add kubectl aliases
add_kubectl_config() {
    local completion_cmd='source <(kubectl completion bash)'
    local alias_cmd='alias k=kubectl'
    local complete_cmd='complete -o default -F __start_kubectl k'

    grep -qxF "$completion_cmd" ~/.bashrc || echo "$completion_cmd" >> ~/.bashrc
    grep -qxF "$alias_cmd" ~/.bashrc || echo "$alias_cmd" >> ~/.bashrc
    grep -qxF "$complete_cmd" ~/.bashrc || echo "$complete_cmd" >> ~/.bashrc

    source ~/.bashrc
}

alieases(){
    
    add_bash_aliases_source
    add_top_aliases
    add_kubectl_config
}
