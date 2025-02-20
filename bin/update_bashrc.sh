#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    update_bashrc.sh
# Version:        1.24.0
# Author:         Feigelman Evgeny
# Date:           2025-02-12
# Description:    Updates .bashrc with Git completion and modifies
#                 and configure HISTSIZE/HISTFILESIZE 
#                 Back up .bashrc before modification.
# -----------------------------------------------------

set -o errexit
set -o pipefail
set -x

BASHRC="$HOME/.bashrc"
BACKUP="$HOME/.bashrc.backup"
changes_needed=()  # Array to track what needs to change


check_bashrc(){
# Ensure .bashrc exists
    if [ ! -f "$BASHRC" ]; then
        echo "Unable to find .bashrc file"
        exit 1
    fi

# Check if HISTSIZE needs updating
    if grep -q "^HISTSIZE=1000$" "$BASHRC"; then
        changes_needed+=("Update HISTSIZE")
    elif ! grep -q "^HISTSIZE=" "$BASHRC"; then
        changes_needed+=("Add HISTSIZE")
    fi

# Check if HISTFILESIZE needs updating
    if grep -q "^HISTFILESIZE=2000$" "$BASHRC"; then
        changes_needed+=("Update HISTFILESIZE")
    elif ! grep -q "^HISTFILESIZE=" "$BASHRC"; then
        changes_needed+=("Add HISTFILESIZE")
    fi

# Check if Git completion is missing
    if ! grep -q "__git_ps1" "$BASHRC"; then
        changes_needed+=("Add Git completion")
    fi
}
backup_bashrc(){
# Backup if changes_needed not empty
if [ ${#changes_needed[@]} -gt 0 ] && [ ! -f "$BACKUP" ]; then
    echo "Backing up .bashrc to $BACKUP"
    cp "$BASHRC" "$BACKUP"
fi
}
# Apply changes

apply_changes(){
    echo "# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)" >> "$BASHRC"

    for change in "${changes_needed[@]}"; do
        case $change in
            "Update HISTSIZE")
                sed -i 's/^HISTSIZE=1000$/HISTSIZE=10000/' "$BASHRC"
                echo "Updated HISTSIZE=10000"
                ;;
            "Add HISTSIZE")
                echo "HISTSIZE=10000" >> "$BASHRC"
                echo "Appended HISTSIZE=10000"
                ;;
            "Update HISTFILESIZE")
                sed -i 's/^HISTFILESIZE=2000$/HISTFILESIZE=20000/' "$BASHRC"
                echo "Updated HISTFILESIZE=20000"
                ;;
                "Add HISTFILESIZE")
                echo "HISTFILESIZE=20000" >> "$BASHRC"
                echo "Appended HISTFILESIZE=20000"
               ;;
            "Add Git completion")
                cat << 'EOF' >> "$BASHRC"

# Ensure Git completion is available
if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
fi

# Set PS1 with Git branch
PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\$ '
EOF
                echo "Git completion added. Run 'source ~/.bashrc' to apply changes."
                ;;
        esac
    done
}
update_bashrc_file(){
    check_bashrc
    backup_bashrc
    apply_changes
}

update_bashrc_file
