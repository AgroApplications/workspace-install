#!/bin/bash
set -euo pipefail

install_locale_support() {
    install_package_group "Locale support packages" "${LOCALE_PACKAGES[@]}"
    for locale in "${LOCALE_GEN[@]}"; do
        sudo locale-gen "${locale}"
    done
    sudo update-locale LANG="${DEFAULT_LOCALE}"
    print_success "Locale support configured"
}

return 0

