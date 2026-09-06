#!/bin/bash
set -euo pipefail

install_basic_packages() {
    install_package_group "Step 2: Installing Basic Development Packages" "${BASIC_PACKAGES[@]}"
}

return 0
