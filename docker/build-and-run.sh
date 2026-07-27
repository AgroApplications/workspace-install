#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

TARGET="${1:-development}"
IMAGE_NAME="pythonenv-nsv"
TAG="${2:-latest}"

echo "Building Docker image: ${IMAGE_NAME}:${TAG} (target: ${TARGET})"
docker build \
    --target "$TARGET" \
    --tag "${IMAGE_NAME}:${TAG}" \
    "$PROJECT_DIR"

echo "Running container..."
case "$TARGET" in
    development)
        docker run --rm -it \
            -p 8000:8000 \
            -v "${PROJECT_DIR}:/workspace" \
            "${IMAGE_NAME}:${TAG}"
        ;;
    testing)
        docker run --rm \
            "${IMAGE_NAME}:${TAG}"
        ;;
    production)
        docker run --rm -d \
            -p 8000:8000 \
            --name "${IMAGE_NAME}-prod" \
            "${IMAGE_NAME}:${TAG}"
        echo "Production container started. Access at http://localhost:8000"
        ;;
    *)
        echo "Unknown target: ${TARGET}. Use: development, testing, production"
        exit 1
        ;;
esac
