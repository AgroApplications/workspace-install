#!/bin/bash
set -euo pipefail

install_core_build_tools() {
    install_package_group "Core build tools" "${CORE_BUILD[@]}"
}

return 0
