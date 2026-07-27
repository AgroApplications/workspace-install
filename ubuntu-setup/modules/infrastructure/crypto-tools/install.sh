#!/bin/bash
set -euo pipefail

install_crypto_tools() {
    install_package_group "Cryptography tools & libraries" "${CRYPTO_TOOLS[@]}"
}

return 0
