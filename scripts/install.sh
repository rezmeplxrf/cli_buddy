#!/bin/bash

set -e

REPO_URL="https://github.com/rezmeplxrf/cli_buddy"
INSTALL_DIR="$HOME/.cli_buddy"

# Determine OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "Unsupported operating system"
    exit 1
fi

# Create installation directory
mkdir -p "$INSTALL_DIR"

# Get latest version
LATEST_VERSION=$(curl -s "$REPO_URL/tree/main/release" | grep -oP '(?<=title=")[0-9]+\.[0-9]+\.[0-9]+(?=")' | sort -V | tail -n1)

if [ -z "$LATEST_VERSION" ]; then
    echo "Failed to determine latest version"
    exit 1
fi

echo "Latest Version: $LATEST_VERSION"

# Download the executable
DOWNLOAD_URL="$REPO_URL/raw/main/release/$LATEST_VERSION/$OS/buddy"
# curl -L "$DOWNLOAD_URL" -o "$INSTALL_DIR/buddy"

echo "Download Link: $DOWNLOAD_URL"

# # Make it executable
# chmod +x "$INSTALL_DIR/buddy"

# # Add alias to shell configuration
# SHELL_CONFIG="$HOME/.bashrc"
# if [[ "$SHELL" == *"zsh"* ]]; then
#     SHELL_CONFIG="$HOME/.zshrc"
# fi

# echo "alias buddy='$INSTALL_DIR/buddy'" >> "$SHELL_CONFIG"

# echo "Installation complete. Please restart your terminal or run 'source $SHELL_CONFIG' to use the 'buddy' command."
