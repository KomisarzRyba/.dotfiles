# zinit dir setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit if not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load zinit
source "${ZINIT_HOME}/zinit.zsh"


# PLUGINS
# prompt: starship
zinit ice \
    as"command" \
    from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" \
    src"init.zsh"
zinit light starship/starship

# syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# completions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# autosuggestions
zinit light zsh-users/zsh-autosuggestions

# helper for adding oh-my-zsh plugins
function omzp() {
    local plugin_name=$1
    zinit snippet OMZP::${plugin_name}
}

# oh-my-zsh plugins
omzp asdf
omzp git
omzp gh
omzp brew
omzp eza
omzp cp
omzp command-not-found
omzp rust
omzp tmux

# KEYBINDINGS
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# SETTINGS
# history
HISTSIZE=5000
HISTFILE=${HOME}/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# SHELL INTEGRATION
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
source ${ASDF_DATA_DIR:-$HOME/.asdf}/plugins/golang/set-env.zsh

# COMPINIT
autoload -U compinit && compinit
zinit cdreplay -q

# ALIASES
alias c='clear'
alias tn='tmux new -s $(basename $PWD)'

export TUNE_ALIASES=$HOME/.tune/aliases
source $TUNE_ALIASES

# ENVIRONMENT
export FZF_DEFAULT_OPTS='--color=16'
export TINTED_TMUX_OPTION_STATUSBAR=1
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export GOROOT=$(asdf where golang)/go
