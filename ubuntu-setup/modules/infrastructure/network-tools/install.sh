#!/bin/bash
set -euo pipefail

install_network_tools() {
    install_package_group "Network tools" "${NETWORK_TOOLS[@]}"
}

return 0

