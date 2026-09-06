#!/bin/bash
set -euo pipefail

cleanup_package_cache() {
    print_header "Maintenance & cleanup"
    sudo apt autoremove -y
    sudo apt clean
    print_success "Package cache cleaned"
}

return 0
