#!/bin/bash
set -euo pipefail

install_editors_terminal() {
    install_package_group "Editors and terminal tools" "${EDITORS_TERMINAL[@]}"
}

return 0

