#!/bin/zsh

source "${0:a:h}/require-gum.zsh"

ALIAS_FILE="${ZSH_ALIAS_FILE:?ZSH_ALIAS_FILE not set - does your alias file set ZSH_ALIAS_FILE?}"

_alias_list() {
    if [[ ! -s "$ALIAS_FILE" ]]; then
        gum log --level warn "No aliases defined."
        return 1
    fi
    local names=() cmds=() maxlen=0
    while IFS= read -r line; do
        local name="${line%%=*}"
        name="${name#alias }"
        local cmd="${line#*=}"
        cmd="${cmd#\'}"; cmd="${cmd%\'}"
        names+=("$name"); cmds+=("$cmd")
        (( ${#name} > maxlen )) && maxlen=${#name}
    done < <(grep '^alias ' "$ALIAS_FILE")
    local md=""
    for ((i=1; i<=${#names[@]}; i++)); do
        local pad=$(( maxlen - ${#names[$i]} ))
        local spaces=$(printf '%*s' "$pad" '')
        md+="**${names[$i]}**${spaces} → \`${cmds[$i]}\`"$'\n'
    done
    gum format "$md"
}

_alias_add() {
    local name=$(gum input --placeholder "alias name (e.g. gs)")
    [[ -z "$name" ]] && return 1

    if grep -q "^alias ${name}=" "$ALIAS_FILE" 2>/dev/null; then
        gum log --level error "Alias '$name' already exists. Use edit to change it."
        return 1
    fi

    local cmd=$(gum input --header "Aliasing $(gum style --bold "$name")" --placeholder "command (e.g. git status)")
    [[ -z "$cmd" ]] && return 1

    echo "alias ${name}='${cmd}'" >> "$ALIAS_FILE"
    gum log --level info "Added: ${name} → ${cmd}"
    source "$ALIAS_FILE"
}

_alias_edit() {
    local aliases=("${(@f)$(grep '^alias ' "$ALIAS_FILE" | sed 's/^alias //' | sed "s/=/ → /" | sed "s/'//g")}")
    [[ ${#aliases[@]} -eq 0 ]] && { gum log --level warn "No aliases to edit."; return 1; }

    local choice=$(printf '%s\n' "${aliases[@]}" | gum filter --placeholder "Select alias to edit")
    [[ -z "$choice" ]] && return 1

    local name="${choice%% →*}"
    local old_cmd=$(grep "^alias ${name}=" "$ALIAS_FILE" | head -1 | sed "s/^alias ${name}='//" | sed "s/'$//")

    local new_cmd=$(gum input --header "Editing $(gum style --bold "$name")" --value "$old_cmd" --placeholder "new command")
    [[ -z "$new_cmd" || "$new_cmd" == "$old_cmd" ]] && return 0

    sed -i '' "s|^alias ${name}=.*|alias ${name}='${new_cmd}'|" "$ALIAS_FILE"
    gum log --level info "Updated: ${name} → ${new_cmd}"
    source "$ALIAS_FILE"
}

_alias_remove() {
    local aliases=("${(@f)$(grep '^alias ' "$ALIAS_FILE" | sed 's/^alias //' | sed "s/=/ → /" | sed "s/'//g")}")
    [[ ${#aliases[@]} -eq 0 ]] && { gum log --level warn "No aliases to remove."; return 1; }

    local choice=$(printf '%s\n' "${aliases[@]}" | gum filter --placeholder "Select alias to remove")
    [[ -z "$choice" ]] && return 1

    local name="${choice%% →*}"

    gum confirm "Remove alias '$name'?" || return 0

    sed -i '' "/^alias ${name}=/d" "$ALIAS_FILE"
    unalias "$name" 2>/dev/null
    gum log --level info "Removed: ${name}"
}

main() {
    local action="${1:-$(gum choose --header "Alias Manager" "list" "add" "edit" "remove")}"
    case "$action" in
        list)   _alias_list ;;
        add)    _alias_add ;;
        edit)   _alias_edit ;;
        remove) _alias_remove ;;
    esac
}

main "$@"
