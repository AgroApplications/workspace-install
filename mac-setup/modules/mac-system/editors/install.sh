#!/bin/bash
set -euo pipefail

install_editors() {
    install_package_group "Editors" "${EDITORS[@]}"
}

return 0
