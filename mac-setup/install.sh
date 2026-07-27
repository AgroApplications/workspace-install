#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Helpers & config ────────────────────────────────────────

source "${ROOT_DIR}/scripts/helpers.sh"
source "${ROOT_DIR}/config/packages.conf"
source "${ROOT_DIR}/config/settings.conf"

# ── Prerequisites (PRD section 7) ──────────────────────────

check_prerequisites() {
    print_header "Checking prerequisites"

    if ! command -v brew &> /dev/null; then
        print_error "Homebrew is not installed. Install it first:"
        echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        exit 1
    fi
    print_success "Homebrew found: $(brew --version | head -n1)"

    if ! xcode-select -p &> /dev/null; then
        print_error "Xcode Command Line Tools are not installed. Run:"
        echo "  xcode-select --install"
        exit 1
    fi
    print_success "Xcode CLT found: $(xcode-select -p)"

    local macos_major
    macos_major="$(sw_vers -productVersion | cut -d. -f1)"
    if [[ "${macos_major}" -lt 13 ]]; then
        print_error "macOS 13+ (Ventura) is required. Found: $(sw_vers -productVersion)"
        exit 1
    fi
    print_success "macOS version: $(sw_vers -productVersion)"
}

# ── System modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/mac-system/system-update.sh"
source "${ROOT_DIR}/modules/mac-system/system-utilities/install.sh"
source "${ROOT_DIR}/modules/mac-system/terminal-tools/install.sh"
source "${ROOT_DIR}/modules/mac-system/editors/install.sh"
source "${ROOT_DIR}/modules/mac-system/maintenance/cleanup.sh"

# ── Python modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/mac-python/basic/install.sh"
source "${ROOT_DIR}/modules/mac-python/managers/install.sh"
source "${ROOT_DIR}/modules/mac-python/packages/install.sh"
source "${ROOT_DIR}/modules/mac-python/devtools/install.sh"

# ── DevOps modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/mac-devops/git/install.sh"
source "${ROOT_DIR}/modules/mac-devops/vcs/install.sh"
source "${ROOT_DIR}/modules/mac-devops/docker/install.sh"
source "${ROOT_DIR}/modules/mac-devops/kubernetes/install.sh"

# ── Infrastructure modules ──────────────────────────────────

source "${ROOT_DIR}/modules/mac-infra/core-build/install.sh"
source "${ROOT_DIR}/modules/mac-infra/dev-libraries/install.sh"
source "${ROOT_DIR}/modules/mac-infra/network-tools/install.sh"
source "${ROOT_DIR}/modules/mac-infra/monitoring-tools/install.sh"
source "${ROOT_DIR}/modules/mac-infra/profiling-tools/install.sh"
source "${ROOT_DIR}/modules/mac-infra/db-libs/install.sh"
source "${ROOT_DIR}/modules/mac-infra/lang-support/install.sh"
source "${ROOT_DIR}/modules/mac-infra/doc-tools/install.sh"
source "${ROOT_DIR}/modules/mac-infra/crypto-tools/install.sh"
source "${ROOT_DIR}/modules/mac-infra/multimedia-libs/install.sh"
source "${ROOT_DIR}/modules/mac-infra/cloud-tools/install.sh"
source "${ROOT_DIR}/modules/mac-infra/data-tools/install.sh"
source "${ROOT_DIR}/modules/mac-infra/additional-tools/install.sh"

# ── Verification ────────────────────────────────────────────

verify_installation() {
    print_header "Verifying Installation"

    echo ""
    echo "Checking installed versions:"
    echo ""
    for cmd in brew python3 pip3 uv poetry git gh docker kubectl; do
        check_command "${cmd}"
    done

    echo ""
    echo "Testing Python virtual environment..."
    python3 -m venv /tmp/mac-setup-test-env
    source /tmp/mac-setup-test-env/bin/activate
    pip3 install --upgrade pip > /dev/null 2>&1
    deactivate
    rm -rf /tmp/mac-setup-test-env
    print_success "Virtual environment test passed"
}

# ── Post-install notes ──────────────────────────────────────

post_install_notes() {
    print_header "Setup Complete!"

    echo ""
    echo -e "${YELLOW}Important Notes:${NC}"
    echo ""
    echo "1. Docker:"
    echo "   Docker Desktop must be running for docker commands."
    echo "   Alternatively, Podman is available: ${BLUE}podman machine init && podman machine start${NC}"
    echo ""
    echo "2. Python virtual environment:"
    echo "   ${BLUE}uv init my-project${NC}"
    echo "   ${BLUE}cd my-project && uv sync${NC}"
    echo ""
    echo "3. Kubernetes:"
    echo "   ${BLUE}kubectl config get-contexts${NC}"
    echo "   ${BLUE}k9s${NC}  (interactive cluster UI)"
    echo ""
    echo "4. Shell enhancements installed:"
    echo "   bat (cat replacement), eza (ls replacement), lsd, broot, fastfetch"
    echo "   Consider adding aliases: ${BLUE}alias cat='bat' && alias ls='eza'${NC}"
    echo ""
    echo -e "${GREEN}Your macOS development environment is ready!${NC}"
    echo ""
}

# ── Profiles ────────────────────────────────────────────────

run_base_profile() {
    check_prerequisites
    run_system_update
    install_system_utilities
    install_python_basics
    install_python_managers
    install_git_tooling
    install_docker_tooling
    verify_installation
    cleanup_mac_system
    post_install_notes
}

run_full_profile() {
    check_prerequisites
    run_system_update
    install_system_utilities
    install_terminal_tools
    install_editors
    install_python_basics
    install_python_managers
    install_python_packages
    install_python_libs
    install_git_tooling
    install_vcs_tooling
    install_docker_tooling
    install_kubernetes_tooling
    install_core_build_tools
    install_dev_libraries
    install_network_tools
    install_monitoring_tools
    install_profiling_tools
    install_database_libraries
    install_language_support
    install_documentation_tools
    install_crypto_tools
    install_multimedia_libraries
    install_cloud_tools
    install_data_tools
    install_additional_tools
    verify_installation
    cleanup_mac_system
    post_install_notes
}

# ── Entry point ─────────────────────────────────────────────

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ "${MAC_SETUP_PROFILE:-}" == "full" ]]; then
        run_full_profile
    else
        run_base_profile
    fi
else
    return 0
fi
