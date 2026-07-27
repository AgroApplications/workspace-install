#!/bin/bash
set -euo pipefail

install_docker_packages() {
    install_package_group "Docker & container tooling" "${DOCKER_PACKAGES[@]}"
    sudo usermod -aG docker "$USER"
    print_warning "To use docker without sudo, start a new session: newgrp docker"

    if sudo systemctl is-active --quiet docker; then
        if sudo docker ps >/dev/null 2>&1; then
            print_success "Docker daemon reachable (sudo docker ps)"
        else
            print_warning "Docker installed, but sudo docker ps failed; check daemon/logs"
        fi
    else
        print_warning "Docker daemon not active; start it: sudo systemctl start docker"
    fi

    if ! check_command "lazydocker"; then
        print_header "Installing lazydocker"
        curl -s https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
        print_success "lazydocker installed"
    else
        print_success "lazydocker already installed"
    fi

    if ! check_command "ctop"; then
        print_header "Installing ctop"
        sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
        sudo chmod +x /usr/local/bin/ctop
        print_success "ctop installed"
    else
        print_success "ctop already installed"
    fi

    echo ""
    echo "After re-login/new shell you can verify without sudo:"
    echo "  newgrp docker"
    echo "  docker ps"
    echo ""
}

return 0

