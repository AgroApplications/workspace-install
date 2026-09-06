#!/bin/bash
set -euo pipefail

configure_wsl_environment() {
    print_header "WSL environment"

    if [[ "${WSL_CONFIGURE_SYSTEMD}" != "true" ]]; then
        print_warning "Leaving /etc/wsl.conf unchanged (WSL_CONFIGURE_SYSTEMD=false)"
        return 0
    fi

    if [[ -f /etc/wsl.conf ]] && grep -qE '^systemd[[:space:]]*=[[:space:]]*true' /etc/wsl.conf; then
        print_success "systemd already enabled in /etc/wsl.conf"
        return 0
    fi

    print_warning "Enabling systemd in /etc/wsl.conf — restart WSL afterwards: wsl.exe --shutdown"
    if [[ -f /etc/wsl.conf ]]; then
        if grep -q '^\[boot\]' /etc/wsl.conf; then
            sudo sed -i '/^\[boot\]/a systemd=true' /etc/wsl.conf
        else
            printf '\n[boot]\nsystemd=true\n' | sudo tee -a /etc/wsl.conf >/dev/null
        fi
    else
        printf '[boot]\nsystemd=true\n' | sudo tee /etc/wsl.conf >/dev/null
    fi
    print_success "Wrote systemd=true to /etc/wsl.conf"
}

return 0
