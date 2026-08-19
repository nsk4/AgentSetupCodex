#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
codex_home_explicit=false
[[ -n "${CODEX_HOME+x}" ]] && codex_home_explicit=true
codex_home="${CODEX_HOME:-$HOME/.codex}"
agents_home="${AGENTS_HOME:-$HOME/.agents}"

mkdir -p -- "$codex_home/agents" "$codex_home/templates" "$codex_home/hooks" "$agents_home/skills"

rm -rf -- "$agents_home/skills/qwe-message-commit" "$agents_home/skills/qwe-message-pr" "$agents_home/skills/qwe-worktree-add" "$agents_home/skills/qwe-worktree-collapse"

cp -- "$script_dir/.codex/AGENTS.md" "$script_dir/.codex/principles.md" "$script_dir/.codex/qwe-contract.md" "$script_dir/.codex/hooks.json" "$codex_home/"
cp -R -- "$script_dir/.codex/agents/." "$codex_home/agents/"
cp -R -- "$script_dir/.codex/templates/." "$codex_home/templates/"
cp -R -- "$script_dir/.codex/hooks/." "$codex_home/hooks/"

legacy_layout="$codex_home/qwe-layout.toml"
layout="$codex_home/qwe-layout.md"
fresh_machine_layout=false
if [[ ! -e "$layout" ]]; then
    if [[ -e "$legacy_layout" ]]; then
        if grep -Ev '^[[:space:]]*(#.*)?$|^[[:space:]]*(mode|plans|rules|logs|templates)[[:space:]]*=[[:space:]]*"[^"]+"[[:space:]]*$' "$legacy_layout" | grep -q .; then
            printf 'Cannot migrate malformed legacy layout: %s\n' "$legacy_layout" >&2
            exit 1
        fi
        sed -E 's/^[[:space:]]*([a-z]+)[[:space:]]*=[[:space:]]*"([^"]+)"[[:space:]]*$/\1: \2/' "$legacy_layout" > "$layout"
        rm -- "$legacy_layout"
        printf 'Migrated %s to %s\n' "$legacy_layout" "$layout"
    else
        cp -- "$script_dir/.codex/qwe-layout.md" "$layout"
        fresh_machine_layout=true
    fi
elif [[ -e "$legacy_layout" ]]; then
    printf 'Ignoring legacy layout because %s already exists: %s\n' "$layout" "$legacy_layout" >&2
fi

if [[ "$fresh_machine_layout" == true && "$codex_home_explicit" == false ]]; then
    mkdir -p -- "$codex_home/plans" "$codex_home/rules" "$codex_home/logs"
fi

cp -R -- "$script_dir/.agents/." "$agents_home/"