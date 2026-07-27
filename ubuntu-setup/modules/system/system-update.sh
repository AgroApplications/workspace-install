#!/bin/bash
set -euo pipefail

run_system_update() {
    print_header "Step 1: Updating System Packages"
    sudo apt update
    sudo apt upgrade -y
    print_success "System updated"
}

return 0

