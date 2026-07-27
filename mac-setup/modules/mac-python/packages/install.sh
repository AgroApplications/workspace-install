#!/bin/bash
set -euo pipefail

install_python_packages() {
    install_package_group "Python dev tools" "${PYTHON_TOOLS[@]}"
}

return 0
