bindkey -M viins '^p' history-search-backward
bindkey -M viins '^n' history-search-forward

bindkey -M viins '^y' autosuggest-accept

bindkey -v '^?' backward-delete-char
bindkey -v '^h' backward-delete-char
bindkey -v '^w' backward-kill-word

export KEYTIMEOUT=1
