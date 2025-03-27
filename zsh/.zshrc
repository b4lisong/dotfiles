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
