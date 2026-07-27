#!/bin/bash
set -euo pipefail

install_git_tooling() {
    install_package_group "Git tooling" "${GIT_PACKAGES[@]}"
}

return 0

