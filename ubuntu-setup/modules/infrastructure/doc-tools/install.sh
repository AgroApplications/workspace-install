#!/bin/bash
set -euo pipefail

install_documentation_tools() {
    install_package_group "Documentation tooling" "${DOC_TOOLS[@]}"
}

return 0

