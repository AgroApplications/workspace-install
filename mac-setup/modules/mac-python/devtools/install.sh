#!/bin/bash
set -euo pipefail

install_python_libs() {
    install_package_group "Python libraries (Homebrew)" "${PYTHON_LIBS[@]}"
}

return 0
