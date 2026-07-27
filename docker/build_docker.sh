#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

IMAGE_NAME="pythonenv-nsv"
VERSION="${1:-$(grep 'version' "$PROJECT_DIR/pyproject.toml" | head -1 | sed 's/.*"\(.*\)".*/\1/')}"

echo "=== Building all Docker targets ==="

echo "--- Building development image ---"
docker build --target development -t "${IMAGE_NAME}:dev" "$PROJECT_DIR"

echo "--- Building testing image ---"
docker build --target testing -t "${IMAGE_NAME}:test" "$PROJECT_DIR"

echo "--- Building production image ---"
docker build --target production -t "${IMAGE_NAME}:${VERSION}" "$PROJECT_DIR"
docker tag "${IMAGE_NAME}:${VERSION}" "${IMAGE_NAME}:latest"

echo "=== Build complete ==="
docker images | grep "$IMAGE_NAME"
