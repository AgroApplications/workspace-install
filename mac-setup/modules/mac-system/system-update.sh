#!/bin/bash
set -euo pipefail

run_system_update() {
    print_header "macOS Brew Update"
    brew update
    brew upgrade
    print_success "Brew packages refreshed"
}

return 0

