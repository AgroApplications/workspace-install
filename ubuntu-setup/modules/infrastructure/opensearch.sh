#!/bin/bash
set -euo pipefail

install_opensearch_tools() {
    print_header "OpenSearch infrastructure helpers"
    print_warning "OpenSearch is not installed by default. Please review ${OPENSEARCH_INSTALL_PATH} for manual deployment instructions."
}

return 0

