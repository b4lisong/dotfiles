#!/usr/bin/env bash

# Enable strict mode for safer execution
set -euo pipefail

# Define package list file
PACKAGE_LIST="$HOME/dotfiles/packages/kali.txt"

# Check if package list exists
if [[ ! -f "$PACKAGE_LIST" ]]; then
    echo "❌ Package list not found: $PACKAGE_LIST"
    exit 1
fi

# Update apt package list and install packages from kali.txt
echo "🔄 Updating system and installing packages from $PACKAGE_LIST..."
sudo apt update && sudo apt install -y $(grep -vE '^\s*#' "$PACKAGE_LIST")

