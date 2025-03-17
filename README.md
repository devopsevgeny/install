
# DevOps Environment Bootstrapper

## Description

This project is a modularized Bash-based setup tool designed to bootstrap a **complete DevOps environment** on Linux (Debian/Ubuntu or RHEL-based distributions). It installs commonly used tools, configures system files, and sets up DevOps utilities, making your system ready for day-to-day work as a DevOps engineer.

---

## Features

- 🐧 **OS Detection** (Debian/Ubuntu or RHEL)
- 🧰 **Installs DevOps Tools:** Docker, Kubernetes CLI, Helm, Terraform, Azure CLI, GCP SDK, Minikube, Ansible, etc.
- 🔧 **Configures Vim + Plugins** (including color schemes)
- 🛡 **Modifies .bashrc and adds useful aliases**
- 📦 **Configures 3rd-party repositories (VSCodium, Helm, Kubernetes, HashiCorp, MongoDB, and more)**
- 💾 **Backup utility for system and user configuration files**
- 🛠 **Minikube installer**

---

## Prerequisites

- Linux OS (Debian/Ubuntu or RHEL-based system)
- `curl`, `wget`, `git`, and `bash`
- **Non-root user** (the script checks and prevents execution as root directly, but `sudo` will be used inside)

---

## Setup Overview

### Main bootstrap script:

```
setup_environment.sh
```

This script will:

1. **Detect your OS type**.
2. **Install base and DevOps packages**.
3. **Configure additional repos (HashiCorp, Helm, Kubernetes, etc.)**.
4. **Set up `~/.bashrc` and `~/.bash_aliases`**.
5. **Install VIM plugins & themes**.
6. **Install Minikube**.
7. **Create system backups.**

---

## Usage

```bash
git clone https://github.com/devopsevgeny/devops-setup.git
cd devops-setup
chmod +x setup_environment.sh
./setup_environment.sh
```

---

## Modules Breakdown

| Script                 | Description                                                      |
| ---------------------- | ---------------------------------------------------------------- |
| `setup_environment.sh` | Main orchestrator script to bootstrap the environment            |
| `addrepos.sh`          | Adds external repositories like HashiCorp, Helm, etc.            |
| `update_bashrc.sh`     | Updates `.bashrc` with Git completion, Powerline, history tuning |
| `vim_plugins.sh`       | Installs `.vimrc`, color schemes, and essential Vim plugins      |
| `add_aliases.sh`       | Adds helpful aliases and `kubectl` autocompletion                |
| `backup.sh`            | Creates a backup of important system and user configs            |

---

## What's Included

- **Minikube Installation** ✔
- **Kubernetes CLI & Helm Setup** ✔
- **VSCodium & Git Aliases** ✔
- **AWS CLI & Azure CLI** ✔
- **Google Cloud SDK** ✔
- **VIM Customization** ✔
- **Terraform & Ansible** ✔
- **DBeaver & MongoDB Tools** ✔
- **Backup Automation** ✔
- **Powerline & Shell Customizations** ✔

---

## Notes

- This project is highly modular, you can run each component separately if needed.
- Designed for **DevOps engineers** who want to speed up workstation setup.
- Tested on **"Linux Mint 22.1+**
- 

---

## Credits

### Developer

- **Evgeny Feigelman** ([DevOpsEvgeny](https://github.com/devopsevgeny))

### Mentor

- Special thanks to **zero-pytagoras** for guidance and mentorship throughout the project.

---

## Next steps

- Consider adding **unit tests** for isolated components.
- Shoud be tested on "**Rocky Liniux 8**" + aditional destribution
- Fix minicube installation
- Check bug in adding aliases
