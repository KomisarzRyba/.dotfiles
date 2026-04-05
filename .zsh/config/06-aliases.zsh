ZSH_ALIAS_FILE="${0:A}"

alias c='clear'
alias tn='tmux new -s $(basename $PWD)'
alias grep='rg --color=auto'
alias eza='eza --icons=auto --color=auto'
alias ls='eza'
alias ll='eza -l'
alias la='eza -la'
alias lt='eza --tree'
