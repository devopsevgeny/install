
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

add_repos() {

# VSCodium

    if [ ! -f /usr/share/keyrings/vscodium-archive-keyring.gpg ]; then
        wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
        | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
    else
        echo "VSCodium key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/vscodium.list ]; then
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main" \
        | sudo tee /etc/apt/sources.list.d/vscodium.list
    else
        echo "VSCodium repo already exists, skipping..."
    fi

# Google Cloud SDK

    if [ ! -f /usr/share/keyrings/google-cloud-archive-keyring.gpg ]; then
        echo "Adding Google Cloud key..."
        curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
        | sudo gpg --dearmor -o /usr/share/keyrings/google-cloud-archive-keyring.gpg
    else
        echo "Google Cloud key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/google-cloud-sdk.list ]; then
        echo 'deb [signed-by=/usr/share/keyrings/google-cloud-archive-keyring.gpg] https://packages.cloud.google.com/apt cloud-sdk main' \
        | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
    else
        echo "Google Cloud SDK repo already exists, skipping..."
    fi

# Kubernetes tools (kubectl, minikube)

    if [ ! -f /usr/share/keyrings/kubernetes-archive-keyring.gpg ]; then
        curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
    else
        echo "Kubernetes key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/kubernetes.list ]; then
        echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" \
        | sudo tee /etc/apt/sources.list.d/kubernetes.list
    else
        echo "Kubernetes repo already exists, skipping..."
    fi

# Azure CLI

    if [ ! -f /etc/apt/trusted.gpg.d/microsoft.gpg ]; then
        curl -fsSL  https://packages.microsoft.com/keys/microsoft.asc \
        | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg
    else
        echo "Azure key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/azure-cli.list ]; then
        sudo echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ focal main" \
        | sudo tee /etc/apt/sources.list.d/azure-cli.list
    else
        echo "Azure repo already exists, skipping..."
    fi
# Helm

    if [ ! -f /usr/share/keyrings/helm-archive-keyring.gpg ]; then
        curl -fsSL https://baltocdn.com/helm/signing.asc | sudo gpg --dearmor -o /usr/share/keyrings/helm-archive-keyring.gpg
    else
        echo "Helm key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/helm-stable-debian.list ]; then
        echo "deb [signed-by=/usr/share/keyrings/helm-archive-keyring.gpg] https://baltocdn.com/helm/stable/debian/ all main" \
        | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    else
        echo "Helm repo already exists, skipping..."
    fi


# HashiCorp tools (Terraform, Packer)

    if [ ! -f /usr/share/keyrings/hashicorp-archive-keyring.gpg ]; then
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    else
        echo "HashiCorp key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/hashicorp.list ]; then
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $UBUNTU_CODENAME main" \
        | sudo tee /etc/apt/sources.list.d/hashicorp.list
    else
        echo "HashiCorp repo already exists, skipping..."
    fi

# DBeaver

    if [ ! -f /usr/share/keyrings/dbeaver-keyring.gpg ]; then
        curl -fsSL https://dbeaver.io/debs/dbeaver.gpg.key \
        | sudo gpg --dearmor -o /usr/share/keyrings/dbeaver-keyring.gpg
    else
       echo "DBeaver key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/dbeaver.list ]; then
        echo "deb [signed-by=/usr/share/keyrings/dbeaver-keyring.gpg] https://dbeaver.io/debs/dbeaver-ce /" \
        | sudo tee /etc/apt/sources.list.d/dbeaver.list
    else
       echo "DBeaver repo already exists, skipping..."
    fi

# MongoDB CLI

    if [ ! -f /usr/share/keyrings/mongodb-server-keyring.gpg ]; then
        curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-keyring.gpg
    else
        echo "MongoDB key already exists, skipping..."
    fi

    if [ ! -f /etc/apt/sources.list.d/mongodb-org-6.0.list ]; then
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mongodb-server-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" \
        | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
    else
        echo "MongoDB repo already exists, skipping..."
    fi

# K6 load testing tool

    if [ ! -f  /usr/share/keyrings/k6-archive-keyring.gpg ];then
        curl -fsSL https://dl.k6.io/key.gpg |\
        sudo gpg --dearmor -o /usr/share/keyrings/k6-archive-keyring.gpg
    else
        echo "K6  key already exists, skipping..."
    fi

    if  [ ! -f  /etc/apt/sources.list.d/k6.list ];then
        echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" \
        | sudo tee /etc/apt/sources.list.d/k6.list
    else
        echo "K6 repo already exists, skipping.."
    fi

# Vagrant
    if [ ! -f  /usr/share/keyrings/hashicorp-archive-keyring.gpg ];then
        curl -fsSL https://apt.releases.hashicorp.com/gpg  \
        | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    else
        echo "Hashicorp key already exists, skipping..."
    fi

    if [ ! -f  /etc/apt/sources.list.d/hashicorp.list ];then
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"| \
        sudo tee /etc/apt/sources.list.d/hashicorp.list
    else
        echo "Hashicorp repo already exists, skipping..."
    fi

}
