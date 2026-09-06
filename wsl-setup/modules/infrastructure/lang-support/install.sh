#!/bin/bash
set -euo pipefail

install_language_support() {
    install_package_group "Language and runtime support" "${LANG_SUPPORT[@]}"
}

return 0
