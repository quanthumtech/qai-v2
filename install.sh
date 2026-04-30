#!/bin/sh
set -e

REPO="quanthumtech/qai-v2"
BRANCH="master"
BIN_DIR="${QAI_INSTALL:-/usr/local/bin}"

# Detect OS and arch
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$OS" in
  linux)  PLATFORM="linux-x64" ;;
  darwin)
    case "$ARCH" in
      arm64) PLATFORM="macos-arm64" ;;
      *)     PLATFORM="macos-x64" ;;
    esac
    ;;
  *) echo "Unsupported OS: $OS" && exit 1 ;;
esac

# Get latest release tag
TAG=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name"' | sed 's/.*"tag_name": *"\(.*\)".*/\1/')

# Fallback to latest commit if no release
if [ -z "$TAG" ]; then
  TAG=$(curl -fsSL "https://api.github.com/repos/$REPO/commits/$BRANCH" | grep '"sha"' | head -1 | sed 's/.*"sha": *"\([a-f0-9]*\)".*/\1/')
fi

URL="https://github.com/$REPO/releases/download/$TAG/qaicli"

echo "Installing qaicli $TAG..."
curl -fsSL "$URL" -o /tmp/qaicli
chmod +x /tmp/qaicli

# Install (try sudo if needed)
if [ -w "$BIN_DIR" ]; then
  mv /tmp/qaicli "$BIN_DIR/qaicli"
  cp "$BIN_DIR/qaicli" "$BIN_DIR/qai"
else
  sudo mv /tmp/qaicli "$BIN_DIR/qaicli"
  sudo cp "$BIN_DIR/qaicli" "$BIN_DIR/qai"
fi
chmod +x "$BIN_DIR/qai"

echo "✓ qaicli installed to $BIN_DIR/qaicli"
echo "✓ qai installed to $BIN_DIR/qai"
echo "  Run: qai"