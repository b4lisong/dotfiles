# Actions to take when running headless
# Start by setting fbterm as default terminal on Linux (term) only
#     i.e. NOT X11, macOS, non-interactive shells etc.
if [[ "$(uname -s)" == "Linux" ]]; then
    # Safer way to autostart fbterm to avoid infinite loops/recursion
    if [[ "$TERM" = "linux" && -z "$DISPLAY" && -t 0 ]]; then
        if command -v fbterm &>/dev/null && [[ -z "$FBTERM_STARTED" ]]; then
            export FBTERM_STARTED=1
            export TERM=tmux-256color  # needed to prevent partial redraws and other weird shit
            exec fbterm
        fi
    fi
fi

# Starship prompt
# https://starship.rs/guide/
eval "$(starship init zsh)"

# Aliases
source ~/.zsh_aliases_core # aliases common to all platforms

# Ensure $HOME/go/bin is in the PATH
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
  export PATH="$HOME/go/bin:$PATH"
fi

# Ensure $HOME/.cargo/bin is in the PATH
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
