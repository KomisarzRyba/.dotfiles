ZSH_DIR="$HOME/.zsh"
ZSH_CONFIG="$ZSH_DIR/config"
ZSH_UTILS="$ZSH_DIR/utils"

for conf in "$ZSH_CONFIG"/*.zsh(N); do
    source "$conf"
done

for util in "$ZSH_UTILS"/*.zsh(N); do
    local name="${${util:t}%.zsh}"
    eval "util-${name}() { source \"$util\" \"\$@\" }"
done
