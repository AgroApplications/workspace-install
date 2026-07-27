#!/bin/bash
set -euo pipefail

install_multimedia_libraries() {
    install_package_group "Multimedia tools" "${MULTIMEDIA_TOOLS[@]}"
    install_package_group "Image processing libraries" "${IMAGE_LIBS[@]}"
    install_package_group "Audio/Video codec libraries" "${AV_CODEC_LIBS[@]}"
    install_package_group "Graphics & font libraries" "${GRAPHICS_LIBS[@]}"
}

return 0
