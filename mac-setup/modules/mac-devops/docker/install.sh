#!/bin/bash
set -euo pipefail

install_docker_tooling() {
    install_package_group "Docker tooling" "${DOCKER_PACKAGES[@]}"
    print_success "Add your user to the docker group via Docker Desktop settings"
}

return 0

