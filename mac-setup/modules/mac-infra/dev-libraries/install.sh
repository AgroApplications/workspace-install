#!/bin/bash
set -euo pipefail

install_dev_libraries() {
    install_package_group "Development libraries" "${DEV_LIBRARIES[@]}"
    install_package_group "Compression libraries" "${COMPRESSION_LIBS[@]}"
}

return 0
