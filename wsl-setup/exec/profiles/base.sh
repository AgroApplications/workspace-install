#!/bin/bash
set -euo pipefail

run_base_profile() {
    check_prerequisites
    configure_wsl_environment
    run_system_update
    install_basic_packages
    install_git_packages
    install_docker_packages
    install_python_packages
    install_python_package_managers
    verify_installation
    post_install_notes
}

return 0
