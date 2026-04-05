FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit
compinit -d "$ZSH_DIR/.zcompdump"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
