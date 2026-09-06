#!/bin/bash
set -euo pipefail

install_network_tools() {
    install_package_group "Network tools" "${NETWORK_TOOLS[@]}"

    if systemd_is_active; then
        print_warning "openssh-server is installed but not started automatically in WSL"
    else
        print_warning "Skipping sshd start — systemd is not active in this WSL distro"
    fi
}

return 0
