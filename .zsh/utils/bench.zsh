#!/bin/zsh

source "${0:a:h}/require-gum.zsh"

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    gum format <<'EOF'
# bench

Benchmark zsh startup time by launching interactive shells.

## Options

* `-n`  Number of runs (default: **10**)
EOF
    return 0
fi

local n=10
while getopts "n:" opt; do
    case $opt in
        n) n=$OPTARG ;;
    esac
done
local total=0

for i in $(seq 1 $n); do
    t=$( { /usr/bin/time -p zsh -i -c exit; } 2>&1 )
    secs=$(echo "$t" | awk '/^real/ {print $2}')
    total=$(echo "$total + $secs" | bc)
    echo "run $i: $(gum style --bold "${secs}s")"
done

local avg=$(echo "scale=3; $total / $n" | bc)
gum format $'\n'"**average over ${n} runs: ${avg}s**"
