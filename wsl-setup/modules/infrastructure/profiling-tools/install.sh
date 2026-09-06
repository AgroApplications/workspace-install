#!/bin/bash
set -euo pipefail

install_profiling_tools() {
    print_warning "perf/bpfcc target the Microsoft WSL kernel — some packages may be skipped or non-functional"
    install_package_group "Profiling tools" "${PROFILING_TOOLS[@]}"
}

return 0
