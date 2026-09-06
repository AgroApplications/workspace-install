#!/bin/bash
set -euo pipefail

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        print_success "$1 is installed"
        "$1" --version 2>/dev/null | head -n 1 || true
        return 0
    else
        print_warning "$1 is NOT installed"
        return 1
    fi
}

linux_arch() {
    case "$(uname -m)" in
        x86_64) echo "amd64" ;;
        aarch64|arm64) echo "arm64" ;;
        *) echo "amd64" ;;
    esac
}

is_wsl() {
    [[ -n "${WSL_DISTRO_NAME:-}" ]] && return 0
    [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]] && return 0
    grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null && return 0
    return 1
}

wsl_kernel_version() {
    if [[ -d /run/WSL ]] || grep -qi 'WSL2' /proc/version 2>/dev/null; then
        echo 2
        return
    fi
    if is_wsl; then
        echo 1
        return
    fi
    echo 0
}

systemd_is_active() {
    command -v systemctl >/dev/null 2>&1 \
        && systemctl is-system-running >/dev/null 2>&1
}

install_package_group() {
    local title="$1"
    shift
    if [[ $# -eq 0 ]]; then
        print_warning "No packages defined for ${title}"
        return
    fi

    print_header "$title"

    local missing=()
    for package in "$@"; do
        echo "Installing ${package}..."
        if ! sudo apt install -y "${package}"; then
            print_warning "Skipping ${package}: not available in current apt repos"
            missing+=("${package}")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        print_warning "Completed ${title} with skipped packages: ${missing[*]}"
    else
        print_success "${title} installed"
    fi
}

# allow scripts to source this safely
return 0
