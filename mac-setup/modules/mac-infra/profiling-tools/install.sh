#!/bin/bash
set -euo pipefail

install_profiling_tools() {
    install_package_group "Profiling tools" "${PROFILING_TOOLS[@]}"
}

return 0

