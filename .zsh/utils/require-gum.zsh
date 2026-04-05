#!/bin/zsh

if ! command -v gum &>/dev/null; then
    echo "error: gum is not installed (https://github.com/charmbracelet/gum)" >&2
    return 1 2>/dev/null || exit 1
fi
