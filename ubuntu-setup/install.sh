#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/scripts/helpers.sh"
source "${ROOT_DIR}/config/packages.conf"
source "${ROOT_DIR}/config/settings.conf"

# ── System modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/system/system-update.sh"
source "${ROOT_DIR}/modules/system/locale-support/install.sh"
source "${ROOT_DIR}/modules/system/maintenance/cleanup.sh"

# ── Python modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/python/basic/install.sh"
source "${ROOT_DIR}/modules/python/packages/install.sh"
source "${ROOT_DIR}/modules/python/managers/install.sh"
source "${ROOT_DIR}/modules/python/devtools/install.sh"

# ── DevOps modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/devops/git/install.sh"
source "${ROOT_DIR}/modules/devops/vcs/install.sh"
source "${ROOT_DIR}/modules/devops/docker/install.sh"
source "${ROOT_DIR}/modules/devops/kubernetes/install.sh"

# ── Infrastructure modules ──────────────────────────────────

source "${ROOT_DIR}/modules/infrastructure/dev-libraries/install.sh"
source "${ROOT_DIR}/modules/infrastructure/compression-libs/install.sh"
source "${ROOT_DIR}/modules/infrastructure/core-build/install.sh"
source "${ROOT_DIR}/modules/infrastructure/editors-terminal/install.sh"
source "${ROOT_DIR}/modules/infrastructure/terminal-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/network-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/monitoring-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/db-libs/install.sh"
source "${ROOT_DIR}/modules/infrastructure/lang-support/install.sh"
source "${ROOT_DIR}/modules/infrastructure/doc-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/profiling-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/crypto-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/multimedia-libs/install.sh"
source "${ROOT_DIR}/modules/infrastructure/cloud-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/data-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/additional-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/opensearch.sh"

# ── Verification ────────────────────────────────────────────

verify_installation() {
    print_header "Verifying Installation"

    echo ""
    echo "Checking installed versions:"
    echo ""
    for cmd in python3 pip3 uv poetry git gh docker kubectl terraform; do
        check_command "${cmd}"
    done

    echo ""
    echo "Testing Python virtual environment..."
    python3 -m venv /tmp/test-env
    source /tmp/test-env/bin/activate
    pip3 install --upgrade pip > /dev/null 2>&1
    deactivate
    rm -rf /tmp/test-env
    print_success "Virtual environment test passed"
}

# ── Post-install notes ──────────────────────────────────────

post_install_notes() {
    print_header "Setup Complete!"

    echo ""
    echo -e "${YELLOW}Important Notes:${NC}"
    echo ""
    echo "1. Docker group membership:"
    echo "   You've been added to the docker group. Log out and back in to apply changes:"
    echo "   ${BLUE}newgrp docker${NC}"
    echo ""
    echo "2. Python virtual environment setup:"
    echo "   Create a new project:"
    echo "   ${BLUE}uv init my-project${NC}"
    echo "   or"
    echo "   ${BLUE}poetry new my-project${NC}"
    echo ""
    echo "3. Kubernetes:"
    echo "   ${BLUE}kubectl config get-contexts${NC}"
    echo "   ${BLUE}k9s${NC}  (interactive cluster UI)"
    echo ""
    echo "4. Shell enhancements installed:"
    echo "   bat (cat replacement), eza (ls replacement), lsd, fd-find, ripgrep, fzf"
    echo "   Consider adding aliases: ${BLUE}alias cat='batcat' && alias ls='eza'${NC}"
    echo ""
    echo -e "${GREEN}Your development environment is ready!${NC}"
    echo ""
}

# ── Profiles ────────────────────────────────────────────────

run_base_profile() {
    run_system_update
    install_basic_packages
    install_git_packages
    install_docker_packages
    install_python_packages
    install_python_package_managers
    verify_installation
    post_install_notes
}

run_full_profile() {
    run_system_update
    install_basic_packages
    install_terminal_tools
    install_dev_libraries
    install_compression_libraries
    install_core_build_tools
    install_git_packages
    install_vcs_tools
    install_docker_packages
    install_kubernetes_tools
    install_python_packages
    install_python_package_managers
    install_python_devtools
    install_editors_terminal
    install_network_tools
    install_monitoring_tools
    install_database_libraries
    install_language_support
    install_documentation_tools
    install_profiling_tools
    install_crypto_tools
    install_multimedia_libraries
    install_cloud_tools
    install_data_tools
    install_additional_tools
    install_locale_support
    cleanup_package_cache
    install_opensearch_tools
    verify_installation
    post_install_notes
}

# ── Entry point ─────────────────────────────────────────────

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ "${DEV_SETUP_PROFILE:-}" == "full" ]]; then
        run_full_profile
    else
        run_base_profile
    fi
else
    return 0
fi
