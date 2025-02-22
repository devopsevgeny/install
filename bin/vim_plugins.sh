#!/usr/bin/env bash
# -----------------------------------------------------
# Script Name:    my_script.sh
# Version:        1.24.0
# Author:         Feigelman Evgeny
# Date:           2025-02-12
# Description:    This script will install most of needed packages, that you will use
#                 during your dayly work as a DevOps expert. Fill free to tell me if
#                 you think that this script can be improved.
set -o errexit
set -o pipefail
set -x
vimrcfile=$HOME/.vimrc
vimrcderectory=$HOME/.vim

# -----------------------------------------------------

# Update vimrc file 
create_vimrc(){
    if [[ ! -f  $vimrcfile ]]; then
        curl -o $vimrcfile  "https://raw.githubusercontent.com/devopsevgeny/install/refs/heads/main/.vimrc"
    else
        cp "$vimrcfile" "${vimrcfile}.old"
        echo "Created a backup of vimrc"
        curl -o $vimrcfile  "https://raw.githubusercontent.com/devopsevgeny/install/refs/heads/main/.vimrc"
    fi
}

# Add more color schemes to vim.
add_color_schemes(){
    if [[ ! -d $vimrcderectory ]];then
        mkdir -p $vimrcderectory/pack/colors/start
        echo "Derectory .vimrc has been created, downloading color scemes"
        cd $vimrcderectory/pack/colors/start
        git clone https://github.com/rafi/awesome-vim-colorschemes.git
        git clone https://github.com/flazz/vim-colorschemes.git
    else
        echo "Already exist"
    fi
}

# Install vim-plugins

install_plugins(){
    if [[ ! -f $vimrcderectory/autoload/plug.vim ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        # Install plugins
        echo "Installing Vim plugins..."
        vim +PlugInstall +qall
        if [[ !? -eq 0 ]];then
            echo "Vim plugins installed successfully!"
        else
            "Failed to install"
        fi
    else
        echo "Already installed"
    fi

    }

# Pimp my VIM

pipm_my_vim(){
    create_vimrc
    add_color_schemes
    install_plugins
}

pipm_my_vim
