#!/bin/bash
set -euo pipefail

install_github_cli() {
    if check_command "gh"; then
        print_success "GitHub CLI (gh) already installed"
        return 0
    fi

    print_header "Installing GitHub CLI (gh) from official repository"
    sudo mkdir -p -m 755 /etc/apt/keyrings
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
    print_success "GitHub CLI (gh) installed from official repository"
}

install_git_packages() {
    install_package_group "Git tooling" "${GIT_PACKAGES[@]}"
    install_github_cli
    git lfs install

    if ! check_command "lazygit"; then
        print_header "Installing lazygit"
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        sudo tar xf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit
        rm -f /tmp/lazygit.tar.gz
        print_success "lazygit installed"
    else
        print_success "lazygit already installed"
    fi

    print_success "Git tools installed"
}

return 0

