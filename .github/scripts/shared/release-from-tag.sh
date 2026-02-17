#!/bin/sh
set -eu

: "${CI_COMMIT_TAG:?CI_COMMIT_TAG required}"

echo "[release] Starting GitHub release job..."

if [ -z "${CI_COMMIT_TAG:-}" ]; then
  echo "[release] No tag detected (CI_COMMIT_TAG is empty); skipping release."
  exit 0
fi

echo "[release] Installing github-cli (if needed)..."
if ! command -v gh >/dev/null 2>&1; then
  apk add --no-cache github-cli >/dev/null
fi

echo "[release] Creating GitHub release for tag ${CI_COMMIT_TAG}..."
gh release create "$CI_COMMIT_TAG" --title "$CI_COMMIT_TAG" --notes "Release $CI_COMMIT_TAG"

echo "[release] Release created for tag ${CI_COMMIT_TAG}."
echo "[release] Release job completed."
