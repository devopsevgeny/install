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
# -----------------------------------------------------
WORKDIR="$(pwd)"
OS_TYPE=""

source "$WORKDIR/bin/awscli.sh"
source "$WORKDIR/bin/addrepos.sh"
source "$WORKDIR/bin/update_bashrc.sh"
source "$WORKDIR/bin/install_azure_cli.sh"

# Function to check for root privileges
check_no_root() {
  if [[ $EUID == "0" ]] || [[ $UID == "0" ]]; then
    echo "Do not use root user or sudo "
    exit 1
  fi

}

YUM_PACKAGES=("git" "vim" "vscodium")

APT_PACKAGES=("git" "vim" "codium" "ca-certificates" "apt-transport-https" "lsb-release" "gnupg" "neovim" "bash-completion" "netcat-traditional" "gcc" "make" "cmake" "docker.io" "docker-compose" "kubectl" "helm" "python3-pip" "google-cloud-sdk" "terraform" "ansible" "cloud-init" "zsh" "openssl" "nmap" "wireshark" "tcpdump" "traceroute" "jq" "yq" "dbeaver-ce" "mysql-client" "postgresql-client" "redis-tools" "mongodb-database-tools" "sqlite3" "jmeter" "k6" "htop" "iotop" "iftop" "atop" "sysstat" "flatpak" "pipx" "unzip" "tar" "rsync" "vagrant" "virtualbox" "libvirt-clients" "libvirt-daemon-system" "tmux" "screen"
)


# Function to determine OS type and set a global variable
set_os_type() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            debian|ubuntu|linuxmint)
                OS_TYPE="Debian-based"
                ;;
            rhel|centos|fedora)
                OS_TYPE="RHEL-based"
                ;;
            *)
                OS_TYPE="Unknown"
                ;;
        esac
    else
        OS_TYPE="Unknown"
    fi
}

# Function to use the OS_TYPE variable
print_os_type() {
    echo "The operating system is identified as: $OS_TYPE"
}

install_minicube(){
# Minicube
if [ ! -f /usr/local/bin/minikube ]; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
fi

}

# Function to use the OS_TYPE variable

install_packages(){
    case $OS_TYPE in 
        Debian-based)
	echo Installing pakages for $OS_TYPE OS.
	sudo apt update;sudo apt upgrade -y;sudo apt install -y "${APT_PACKAGES[@]}"
	;;

	RHEL-based)
	sudo yum update -y;
	sudo yum install -y epel-release || sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E '%{rhel}').noarch.rpm;
	sudo um update -y;
	sudo yum install -y  "${YUM_PACKAGES[@]}"
	echo Installing pakages for $OS_TYPE OS.
        ;;

        *)
        echo -n "$OS_TYPE is unknown, please install manually"
        ;;
    esac
}

check_no_root
set_os_type
print_os_type
aws_cli
add_repos
install_packages
update_bashrc_file
install_azure_cli
install_minicube
