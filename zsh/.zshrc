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


# vim-style keybindings
bindkey -v
bindkey "^R" history-incremental-search-backward

# Convenience options
setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# Aliases
source ~/.zsh_aliases_core # aliases common to all platforms
# Linux-only aliases
if [[ "$(uname -s)" == "Linux" ]]; then
    source ~/.zsh_aliases_linux
fi
# Arch Linux specific aliases
if [ -f /etc/arch-release ]; then
    source ~/.zsh_aliases_arch
fi

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'                                             
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] || \
   [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    else
        . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# enable syntax-highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] || \
   [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    else
        . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold                                                                         
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

# zsh-autocomplete
if [ -f /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ] || \
   [ -f /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
    if [ -f /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
        source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
    else
        source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
    fi
fi

# zsh-completions (add to fpath if not already present)
if [[ -d /usr/share/zsh/site-functions ]] || [[ -d /usr/share/zsh/plugins/zsh-completions ]]; then
    if [[ -d /usr/share/zsh/plugins/zsh-completions ]]; then
        fpath+=/usr/share/zsh/plugins/zsh-completions
    else
        fpath+=/usr/share/zsh/site-functions
    fi
fi

## PATH and exports
# Ensure $HOME/go/bin is in the PATH
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
  export PATH="$HOME/go/bin:$PATH"
fi

# Ensure $HOME/.cargo/bin is in the PATH
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Ensure $HOME/.dotnet is in the PATH
if [[ ":$PATH:" != *":$HOME/.dotnet:"* ]]; then
  export PATH="$HOME/.dotnet:$PATH"
fi

# Ensure $HOME/.dotnet/tools is in the PATH
if [[ ":$PATH:" != *":$HOME/.dotnet/tools:"* ]]; then
  export PATH="$HOME/.dotnet/tools:$PATH"
fi

export DOTNET_ROOT=$HOME/.dotnet
export XCURSOR_THEME=catppuccin-mocha-blue-cursors

# init zoxide (cd replacement)
# must be at the end of .zshrc
eval "$(zoxide init --cmd cd zsh)"
