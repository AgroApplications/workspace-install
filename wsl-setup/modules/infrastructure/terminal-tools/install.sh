#!/bin/bash
set -euo pipefail

install_terminal_tools() {
    install_package_group "Modern terminal & CLI tools" "${TERMINAL_TOOLS[@]}"
}

return 0
