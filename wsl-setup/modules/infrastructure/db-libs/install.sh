#!/bin/bash
set -euo pipefail

install_database_libraries() {
    install_package_group "Database development libraries" "${DB_LIBS[@]}"
}

return 0
