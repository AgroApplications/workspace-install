#!/bin/bash
set -euo pipefail

install_cloud_tools() {
    install_package_group "Cloud & IaC tools" "${CLOUD_TOOLS[@]}"
}

return 0
