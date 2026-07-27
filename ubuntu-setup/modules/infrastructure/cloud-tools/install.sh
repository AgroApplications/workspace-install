#!/bin/bash
set -euo pipefail

install_cloud_tools() {
    install_package_group "Cloud & IaC tools" "${CLOUD_TOOLS[@]}"

    if ! check_command "az"; then
        print_header "Installing Azure CLI"
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
        print_success "Azure CLI installed"
    else
        print_success "Azure CLI already installed"
    fi

    if ! check_command "terraform"; then
        print_header "Installing Terraform"
        sudo apt install -y gnupg software-properties-common
        wget -O- https://apt.releases.hashicorp.com/gpg | \
            gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
            https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
            sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install -y terraform
        print_success "Terraform installed"
    else
        print_success "Terraform already installed"
    fi
}

return 0
