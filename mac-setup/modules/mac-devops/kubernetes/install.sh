#!/bin/bash
set -euo pipefail

install_kubernetes_tooling() {
    install_package_group "Kubernetes tools" "${KUBERNETES_TOOLS[@]}"
}

return 0
