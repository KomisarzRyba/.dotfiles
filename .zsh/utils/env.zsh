#!/bin/zsh

source "${0:a:h}/require-gum.zsh"

ENV_VARS_FILE="${ZSH_ENV_VARS_FILE:?ZSH_ENV_VARS_FILE not set - does your env vars file set ZSH_ENV_VARS_FILE?}"

_add_env() {
    local name=$(gum input --placeholder "variable name (e.g. PATH)")
    [[ -z "$name" ]] && gum log --level error "Variable name cannot be empty." && return 1

    local value=$(gum input --header "Setting $(gum style --bold "$name")" --placeholder "value (e.g. /usr/local/bin)")
    [[ -z "$value" ]] && gum log --level error "Variable value cannot be empty." && return 1

    gum confirm "Are you sure you want to set $(gum style --bold "$name") to $(gum style --bold "$value")?" \
	&& _append_env $name $value || gum log --level warn "Aborted setting variable."
}

_append_env() {
    local name="$1" value="$2"

    # if value contains a dollar sign, user expects it to be wrapped in double quotes
    # else it should be wrapped in single quotes
    if [[ "$value" == *'$'* ]]; then
	value="\"$value\""
    else
	value="'$value'"
    fi

    echo "\nexport ${name}=${value}" >> "$ENV_VARS_FILE"
    gum log --level info "Added: ${name} -> ${value}"
    source "$ENV_VARS_FILE"
}

main() {
    local action="${1:-$(gum choose --header "Env var manager" "add")}"
    case "$action" in
	add) _add_env ;;
    esac
}

main "$@"
