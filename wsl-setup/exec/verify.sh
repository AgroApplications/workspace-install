#!/bin/bash
set -euo pipefail

verify_installation() {
    print_header "Verifying Installation"

    echo ""
    echo "Checking installed versions:"
    echo ""
    for cmd in python3 pip3 uv poetry git gh docker; do
        check_command "${cmd}" || true
    done

    echo ""
    echo "Testing Python virtual environment..."
    python3 -m venv /tmp/wsl-setup-test-env
    source /tmp/wsl-setup-test-env/bin/activate
    pip3 install --upgrade pip > /dev/null 2>&1
    deactivate
    rm -rf /tmp/wsl-setup-test-env
    print_success "Virtual environment test passed"
}

return 0
