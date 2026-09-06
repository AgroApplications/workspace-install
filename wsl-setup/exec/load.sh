#!/bin/bash
set -euo pipefail

# Composition root for wsl-setup.
# Sourced by install.sh after ROOT_DIR is set.
# Loads helpers + config, then modules (install functions), then exec (runbooks).

if [[ -z "${ROOT_DIR:-}" ]]; then
    echo "ROOT_DIR must be set before sourcing exec/load.sh" >&2
    return 1 2>/dev/null || exit 1
fi

# ── Helpers & config ────────────────────────────────────────

source "${ROOT_DIR}/scripts/helpers.sh"
source "${ROOT_DIR}/config/packages.conf"
source "${ROOT_DIR}/config/settings.conf"

# ── System modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/system/system-update.sh"
source "${ROOT_DIR}/modules/system/wsl-environment/install.sh"
source "${ROOT_DIR}/modules/system/locale-support/install.sh"
source "${ROOT_DIR}/modules/system/maintenance/cleanup.sh"

# ── Python modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/python/basic/install.sh"
source "${ROOT_DIR}/modules/python/packages/install.sh"
source "${ROOT_DIR}/modules/python/managers/install.sh"
source "${ROOT_DIR}/modules/python/devtools/install.sh"

# ── DevOps modules ──────────────────────────────────────────

source "${ROOT_DIR}/modules/devops/git/install.sh"
source "${ROOT_DIR}/modules/devops/vcs/install.sh"
source "${ROOT_DIR}/modules/devops/docker/install.sh"

# ── Infrastructure modules ──────────────────────────────────

source "${ROOT_DIR}/modules/infrastructure/dev-libraries/install.sh"
source "${ROOT_DIR}/modules/infrastructure/compression-libs/install.sh"
source "${ROOT_DIR}/modules/infrastructure/core-build/install.sh"
source "${ROOT_DIR}/modules/infrastructure/editors-terminal/install.sh"
source "${ROOT_DIR}/modules/infrastructure/terminal-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/network-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/monitoring-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/db-libs/install.sh"
source "${ROOT_DIR}/modules/infrastructure/lang-support/install.sh"
source "${ROOT_DIR}/modules/infrastructure/doc-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/profiling-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/crypto-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/multimedia-libs/install.sh"
source "${ROOT_DIR}/modules/infrastructure/data-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/additional-tools/install.sh"
source "${ROOT_DIR}/modules/infrastructure/opensearch.sh"

# ── Execution layer ─────────────────────────────────────────

source "${ROOT_DIR}/exec/prerequisites.sh"
source "${ROOT_DIR}/exec/verify.sh"
source "${ROOT_DIR}/exec/notes.sh"
source "${ROOT_DIR}/exec/profiles/base.sh"
source "${ROOT_DIR}/exec/profiles/full.sh"

return 0
