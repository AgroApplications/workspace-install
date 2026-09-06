#!/bin/bash
set -euo pipefail

check_prerequisites() {
    print_header "Checking WSL prerequisites"

    if ! is_wsl; then
        print_error "This setup must run inside WSL (Windows Subsystem for Linux)."
        echo "  Open a WSL terminal and re-run from the Linux filesystem."
        exit 1
    fi
    print_success "WSL detected: ${WSL_DISTRO_NAME:-unknown distro}"

    local wsl_ver
    wsl_ver="$(wsl_kernel_version)"
    if [[ "${WSL_REQUIRE_WSL2}" == "true" && "${wsl_ver}" != "2" ]]; then
        print_error "WSL 2 is required. Found WSL ${wsl_ver}."
        echo "  wsl.exe --set-version ${WSL_DISTRO_NAME:-<distro>} 2"
        exit 1
    fi
    print_success "WSL version: ${wsl_ver}"

    if command -v apt >/dev/null 2>&1; then
        print_success "apt found: $(apt --version | head -n1)"
    else
        print_error "apt is required (Ubuntu/Debian WSL distro)."
        exit 1
    fi

    if systemd_is_active; then
        print_success "systemd is active"
    else
        print_warning "systemd is not active. Docker-in-WSL, snap, and sshd will not start."
        echo "  Enable in /etc/wsl.conf, then run: wsl.exe --shutdown"
        echo "  [boot]"
        echo "  systemd=true"
    fi
}

return 0
