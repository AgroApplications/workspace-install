#!/bin/bash
set -euo pipefail

# Thin entry point. Execution lives in exec/:
#   exec/load.sh          — composition root (helpers, config, modules, profiles)
#   exec/prerequisites.sh — WSL / systemd / distro checks
#   exec/profiles/        — base and full runbooks
#   exec/verify.sh        — post-install checks
#   exec/notes.sh         — operator notes

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/exec/load.sh"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ "${WSL_SETUP_PROFILE:-}" == "full" ]]; then
        run_full_profile
    else
        run_base_profile
    fi
else
    return 0
fi
