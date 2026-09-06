#!/bin/bash
set -euo pipefail

install_monitoring_tools() {
    install_package_group "Monitoring tools" "${MONITORING_TOOLS[@]}"
}

return 0
