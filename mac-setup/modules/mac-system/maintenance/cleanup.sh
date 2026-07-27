#!/bin/bash
set -euo pipefail

cleanup_mac_system() {
    print_header "System maintenance"
    brew cleanup
    print_success "Brew cache cleaned"
}

return 0

