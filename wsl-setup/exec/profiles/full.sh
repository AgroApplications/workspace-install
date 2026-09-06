#!/bin/bash
set -euo pipefail

run_full_profile() {
    check_prerequisites
    configure_wsl_environment
    run_system_update
    install_basic_packages
    install_terminal_tools
    install_dev_libraries
    install_compression_libraries
    install_core_build_tools
    install_git_packages
    install_vcs_tools
    install_docker_packages
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
    install_data_tools
    install_additional_tools
    install_locale_support
    cleanup_package_cache
    install_opensearch_tools
    verify_installation
    post_install_notes
}

return 0
