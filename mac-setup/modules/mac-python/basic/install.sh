#!/bin/bash
set -euo pipefail

install_python_basics() {
    install_package_group "Python interpreters & runtime" "${PYTHON_BASIC[@]}"
}

return 0
