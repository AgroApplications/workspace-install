#!/bin/bash
set -euo pipefail

install_crypto_tools() {
    install_package_group "Cryptography tools" "${CRYPTO_TOOLS[@]}"
}

return 0

