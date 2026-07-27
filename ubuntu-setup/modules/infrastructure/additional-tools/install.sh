#!/bin/bash
set -euo pipefail

install_additional_tools() {
    install_package_group "Task management" "${TASK_TOOLS[@]}"
    install_package_group "Additional utilities" "${ADDITIONAL_TOOLS[@]}"
}

return 0
