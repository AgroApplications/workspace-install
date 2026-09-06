#!/bin/bash
set -euo pipefail

_install_docker_companion_clis() {
    if ! check_command "lazydocker"; then
        print_header "Installing lazydocker"
        curl -s https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
        print_success "lazydocker installed"
    else
        print_success "lazydocker already installed"
    fi

    if ! check_command "ctop"; then
        print_header "Installing ctop"
        local arch
        arch="$(linux_arch)"
        sudo wget "https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-${arch}" -O /usr/local/bin/ctop
        sudo chmod +x /usr/local/bin/ctop
        print_success "ctop installed"
    else
        print_success "ctop already installed"
    fi
}

install_docker_packages() {
    print_header "Docker & container tooling (WSL)"

    if docker info >/dev/null 2>&1; then
        print_success "Docker is already reachable (Docker Desktop WSL integration or existing daemon)"
        _install_docker_companion_clis
        return 0
    fi

    if [[ "${WSL_PREFER_DOCKER_DESKTOP}" == "true" ]]; then
        print_warning "Docker Desktop not detected. Install Docker Desktop and enable WSL integration."
        print_warning "To install docker.io inside this distro instead, re-run with WSL_PREFER_DOCKER_DESKTOP=false"
        _install_docker_companion_clis
        return 0
    fi

    install_package_group "Docker & container tooling" "${DOCKER_PACKAGES[@]}"
    sudo usermod -aG docker "$USER"
    print_warning "To use docker without sudo, start a new session: newgrp docker"

    if systemd_is_active; then
        sudo systemctl enable --now docker || print_warning "Could not enable docker.service"
        if sudo docker ps >/dev/null 2>&1; then
            print_success "Docker daemon reachable (sudo docker ps)"
        else
            print_warning "Docker installed, but sudo docker ps failed; check daemon/logs"
        fi
    else
        print_warning "systemd is not active; docker.io will not start until you enable systemd in /etc/wsl.conf"
    fi

    _install_docker_companion_clis
}

return 0
