#!/bin/bash
set -euo pipefail

cleanup_package_cache() {
    print_header "Maintenance & cleanup"
    sudo apt autoremove -y
    sudo apt clean
    print_success "Package cache cleaned"
}

print_demo_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📦 Basic Development Packages Installation Complete!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Installed categories:"
    echo "  ✅ Core build tools (gcc, g++, make, cmake)"
    echo "  ✅ Python ecosystem (python3, pip, venv)"
    echo "  ✅ Development libraries (ssl, xml, image processing)"
    echo "  ✅ System utilities (curl, compression, gnupg)"
    echo "  ✅ Text editors (vim, neovim, nano)"
    echo "  ✅ Network tools (ssh, net-tools, dns)"
    echo "  ✅ Monitoring tools (htop, iotop, sysstat)"
    echo "  ✅ Database libraries (postgresql, mysql, sqlite)"
    echo "  ✅ Language support (nodejs, java)"
    echo "  ✅ Version control (git, svn, mercurial)"
    echo "  ✅ Documentation tools (doxygen, pandoc)"
    echo "  ✅ Cryptography (gnupg, openssl)"
    echo "  ✅ Multimedia libraries (ffmpeg, imagemagick)"
    echo "  ✅ Additional tools (jq, shellcheck, parallel)"
    echo ""
    print_success "System ready for development!"
}

return 0

