#!/bin/bash
set -euo pipefail

install_data_tools() {
    install_package_group "Data & JSON tools" "${DATA_TOOLS[@]}"
}

return 0
