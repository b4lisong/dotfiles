#!/bin/bash
# Script: macos_defaults.sh
# Purpose: Configure macOS Finder and Dock default settings.
# This script backs up current settings, applies new defaults, and restarts affected apps.
# Run under your user account. No elevated privileges are required.
# Reference: https://macos-defaults.com

# Exit immediately if a command exits with a non-zero status
set -e

# Backup current settings
echo "Backing up current Finder and Dock settings..."
if defaults read com.apple.finder > ~/.finder_defaults_backup.plist 2>/dev/null; then
    echo "Finder settings backed up to ~/.finder_defaults_backup.plist"
else
    echo "No Finder settings to backup."
fi

if defaults read com.apple.dock > ~/.dock_defaults_backup.plist 2>/dev/null; then
    echo "Dock settings backed up to ~/.dock_defaults_backup.plist"
else
    echo "No Dock settings to backup."
fi

# === Finder Settings ===
echo "Applying Finder settings..."

# Set default view style to Column view
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Show folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Default search scope: current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Allow quitting Finder via ⌘+Q (this also hides desktop icons)
defaults write com.apple.finder QuitMenuItem -bool true

# === Menu Bar Settings ===
echo "Applying Menu Bar settings..."

# 24-hour format w/seconds
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""

# === Mission Control Settings ===
echo "Applying Mission Control settings..."

# Don't reorder spaces based on most recent use
defaults write com.apple.dock "mru-spaces" -bool "false"

# === Time Machine Settings ===
echo "Applying Time Machine settings..."

# Don't ask to use new connected disks as backup volumes
defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool "true"

# === Dock Settings ===
echo "Applying Dock settings..."

# Do not show recently used applications in the Dock (using the correct domain)
defaults write com.apple.dock show-recents -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Restart affected applications to apply the changes
echo "Restarting Finder and Dock..."
killall Finder 2>/dev/null
killall Dock 2>/dev/null

echo "Settings applied successfully."

