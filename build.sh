#!/bin/bash

set -e

TARGET="$(pwd)/out"
CONTAINER_NAME="tr-build"
IMAGE_TAG="technical-reference:$(git rev-parse HEAD|head -c 8)"

echo "Starting build..."
docker build -t "${IMAGE_TAG}" .

echo "Copying build output to ${TARGET}"
docker run -d --rm --name "${CONTAINER_NAME}" "${IMAGE_TAG}"
docker cp "${CONTAINER_NAME}:/out" "${TARGET}"
docker stop "${CONTAINER_NAME}"

echo "Done"
