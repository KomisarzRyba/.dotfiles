local brew_prefix
brew_prefix="$(brew --prefix)"

fpath=(
    "$brew_prefix/share/zsh/site-functions"
    "$brew_prefix/share/zsh-completions"
    $fpath
)
typeset -U fpath

autoload -Uz compinit
compinit -d "$ZSH_DIR/.zcompdump"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
