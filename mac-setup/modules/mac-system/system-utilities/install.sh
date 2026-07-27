#!/bin/bash
set -euo pipefail

install_system_utilities() {
    install_package_group "System utilities" "${SYSTEM_UTILS[@]}"
}

return 0

