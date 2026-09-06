#!/bin/bash
set -euo pipefail

install_vcs_tools() {
    install_package_group "Version control systems" "${VCS_TOOLS[@]}"
}

return 0
