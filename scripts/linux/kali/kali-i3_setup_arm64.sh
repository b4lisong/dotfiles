#!/usr/bin/env bash

## Core
# Enable strict mode for safer execution
set -euo pipefail

# Define package list file
PACKAGE_LIST="$HOME/dotfiles/packages/linux/kali/kali-i3.txt"

# Check if package list exists
if [[ ! -f "$PACKAGE_LIST" ]]; then
    echo "❌ Package list not found: $PACKAGE_LIST"
    exit 1
fi

# Update apt package list and install packages from kali.txt
echo "🔄 Updating system and installing packages from $PACKAGE_LIST..."
sudo apt update && sudo apt install -y $(grep -vE '^\s*#' "$PACKAGE_LIST")

## Headless
# install lazygit
go install github.com/jesseduffield/lazygit@latest
