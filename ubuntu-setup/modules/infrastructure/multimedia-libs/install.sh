#!/bin/bash
set -euo pipefail

install_multimedia_libraries() {
    install_package_group "Multimedia libraries" "${MULTIMEDIA_LIBS[@]}"
}

return 0

