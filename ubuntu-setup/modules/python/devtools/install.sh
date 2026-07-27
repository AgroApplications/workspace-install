#!/bin/bash
set -euo pipefail

install_python_devtools() {
    install_package_group "Python development libraries" "${PYTHON_LIBS[@]}"

    print_header "Installing Python dev tools via pipx"

    if ! check_command "ruff"; then
        pipx install ruff
        print_success "ruff installed via pipx"
    else
        print_success "ruff already installed"
    fi

    if ! check_command "pre-commit"; then
        pipx install pre-commit
        print_success "pre-commit installed via pipx"
    else
        print_success "pre-commit already installed"
    fi

    if ! check_command "copier"; then
        pipx install copier
        print_success "copier installed via pipx"
    else
        print_success "copier already installed"
    fi
}

return 0
