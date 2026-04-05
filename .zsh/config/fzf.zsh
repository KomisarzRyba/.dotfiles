eval "$(fzf --zsh)"

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

export FZF_DEFAULT_OPTS='--color=16'
