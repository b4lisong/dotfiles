#!/bin/bash

# Check if Xcode Command Line Tools are installed by querying the path.
if xcode-select -p > /dev/null 2>&1; then
    echo "Xcode Command Line Tools are already installed."
else
    echo "Xcode Command Line Tools not found. Initiating installation..."
    
    # Start the installation. Note that this command will pop up a GUI dialog.
    xcode-select --install

    # Optionally, wait until the installation is complete.
    # This loop checks every 5 seconds if the tools have been installed.
    echo "Waiting for installation to complete..."
    until xcode-select -p > /dev/null 2>&1; do
        sleep 5
    done

    echo "Xcode Command Line Tools installed successfully."
fi

# Check if Homebrew is installed by looking for the 'brew' command.
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed."
else
    echo "Homebrew is not installed. Installing Homebrew..."
    # This command downloads and runs the Homebrew installation script.
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Configure shell environment
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    
    # Optional: Check if the installation succeeded.
    if command -v brew >/dev/null 2>&1; then
        echo "Homebrew installed successfully."
    else
        echo "Homebrew installation failed. Please check the error messages above."
    fi
fi

# Install Homebrew packages in Bundle file
brew bundle
