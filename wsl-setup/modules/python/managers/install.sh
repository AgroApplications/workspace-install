#!/bin/bash
set -euo pipefail

install_python_package_managers() {
    print_header "Step 3: Installing Python Package Managers (UV + Poetry)"

    echo "Installing UV..."
    if ! check_command "uv"; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="/home/$USER/.local/bin:$PATH"
        print_success "UV installed successfully"
    else
        print_success "UV already installed"
    fi

    echo "Installing pipx..."
    sudo apt install -y pipx

    echo "Installing Poetry..."
    if ! check_command "poetry"; then
        pipx install poetry
        export PATH="/home/$USER/.local/bin:$PATH"
        print_success "Poetry installed successfully"
    else
        print_success "Poetry already installed"
    fi
}

return 0
