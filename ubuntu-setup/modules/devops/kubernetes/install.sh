#!/bin/bash
set -euo pipefail

install_kubernetes_tools() {
    install_package_group "Kubernetes tools (apt)" "${KUBERNETES_TOOLS[@]}"

    if ! check_command "kubectl"; then
        print_header "Installing kubectl via snap"
        sudo snap install kubectl --classic
        print_success "kubectl installed via snap"
    fi

    if ! check_command "k9s"; then
        print_header "Installing k9s via snap"
        sudo snap install k9s --channel=stable
        print_success "k9s installed via snap"
    fi
}

return 0
