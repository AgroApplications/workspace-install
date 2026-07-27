#!/bin/bash
set -euo pipefail

install_python_managers() {
    print_header "Installing Python package managers"

    echo "Installing uv..."
    if ! check_command "uv"; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="$HOME/.local/bin:$PATH"
        print_success "uv installed successfully"
    else
        print_success "uv already installed"
    fi

    echo "Installing pipx..."
    brew install pipx
    pipx ensurepath
    print_success "pipx configured"

    echo "Installing Poetry..."
    if ! check_command "poetry"; then
        pipx install poetry
        print_success "Poetry installed via pipx"
    else
        print_success "Poetry already installed"
    fi
}

return 0
