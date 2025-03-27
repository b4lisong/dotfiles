#!/bin/bash

# Helper script to set the cap_sys_tty_config capability in fbterm
# Needed to use all shortcuts (change kernel keymap table)
# Safer than running as root or (worse) setting seuid 0

# Get full path to fbterm
FBTERM_BIN=$(command -v fbterm)

if [[ -z "$FBTERM_BIN" ]]; then
    echo "Error: fbterm is not installed or not in PATH."
    exit 1
fi

# Check current capabilities
CURRENT_CAPS=$(getcap "$FBTERM_BIN")

if echo "$CURRENT_CAPS" | grep -q 'cap_sys_tty_config=ep'; then
    echo "fbterm already has cap_sys_tty_config=ep capability."
else
    echo "Granting cap_sys_tty_config=ep to $FBTERM_BIN..."
    sudo setcap cap_sys_tty_config=ep "$FBTERM_BIN"

    # Verify
    if getcap "$FBTERM_BIN" | grep -q 'cap_sys_tty_config=ep'; then
        echo "Success: Capability granted."
    else
        echo "Error: Failed to set capability. Check filesystem and permissions."
        exit 1
    fi
fi

