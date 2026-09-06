#!/bin/bash
set -euo pipefail

post_install_notes() {
    print_header "Setup Complete!"

    echo ""
    echo -e "${YELLOW}Important Notes (WSL):${NC}"
    echo ""
    echo "1. Docker:"
    echo "   Prefer Docker Desktop with WSL integration over docker.io inside the distro."
    echo "   If you installed docker.io, enable systemd and re-login:"
    echo "   ${BLUE}newgrp docker${NC}"
    echo ""
    echo "2. Project location:"
    echo "   Keep git repos on the Linux filesystem (${BLUE}~/code${NC}), not ${BLUE}/mnt/c${NC}."
    echo "   I/O on /mnt/c is much slower and can break file watchers."
    echo ""
    echo "3. Python virtual environment:"
    echo "   ${BLUE}uv init my-project${NC}"
    echo "   ${BLUE}cd my-project && uv sync${NC}"
    echo ""
    echo "4. Shell enhancements installed:"
    echo "   bat (cat replacement), eza (ls replacement), lsd, fd-find, ripgrep, fzf"
    echo "   Consider adding aliases: ${BLUE}alias cat='batcat' && alias ls='eza'${NC}"
    echo ""
    echo -e "${GREEN}Your WSL development environment is ready!${NC}"
    echo ""
}

return 0
