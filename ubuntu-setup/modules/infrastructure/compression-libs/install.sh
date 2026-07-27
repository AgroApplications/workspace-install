#!/bin/bash
set -euo pipefail

install_compression_libraries() {
    install_package_group "Compression libraries" "${COMPRESSION_LIBS[@]}"
}

return 0
