#!/bin/bash
set -euo pipefail

install_python_packages() {
    install_package_group "Python development packages" "${PYTHON_PACKAGES[@]}"
}

return 0

