#!/usr/bin/env bash

# Enable strict mode for safer execution
set -euo pipefail

# Define package list file
PACKAGE_LIST="../packages/kali.txt"

# Check if package list exists
if [[ ! -f "$PACKAGE_LIST" ]]; then
    echo "❌ Package list not found: $PACKAGE_LIST"
    exit 1
fi

# Update apt package list and install packages from kali.txt
echo "🔄 Updating system and installing packages from $PACKAGE_LIST..."
sudo apt update && sudo apt install -y $(grep -vE '^\s*#' "$PACKAGE_LIST")

# Function to check if Git is using libsecret as credential helper
is_git_using_libsecret() {
    git config --global credential.helper | grep -q "git-credential-libsecret"
}

# Function to check if the libsecret binary exists
is_libsecret_installed() {
    command -v git-credential-libsecret &>/dev/null
}

# Install libsecret and configure Git to use it if not already set
if ! is_libsecret_installed; then
    echo "🚀 Configuring Git to use libsecret for credential storage..."

    # Install libsecret dependencies and build tools
    sudo apt install -y libsecret-1-0 libsecret-1-dev build-essential

    # Rebuild Git's credential helper for libsecret
    cd /usr/share/doc/git/contrib/credential/libsecret || exit
    sudo make
    sudo cp git-credential-libsecret /usr/local/bin

    # Verify the binary was installed correctly
    if is_libsecret_installed; then
        echo "✅ git-credential-libsecret successfully installed!"
    else
        echo "❌ Failed to install git-credential-libsecret"
        exit 1
    fi
fi

# Ensure Git is configured to use libsecret
if ! is_git_using_libsecret; then
    echo "🔧 Setting Git to use libsecret..."
    git config --global credential.helper /usr/local/bin/git-credential-libsecret
else
    echo "✅ Git is already configured to use libsecret."
fi

echo "🎉 All packages installed successfully!"

