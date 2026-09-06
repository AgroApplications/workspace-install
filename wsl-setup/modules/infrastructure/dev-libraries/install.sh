#!/bin/bash
set -euo pipefail

install_dev_libraries() {
    install_package_group "Development libraries" "${DEV_LIBRARIES[@]}"
}

return 0
