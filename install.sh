#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
agents_home="${AGENTS_HOME:-$HOME/.agents}"

mkdir -p -- "$codex_home" "$agents_home"
rm -rf -- \
    "$agents_home/skills/qwe-message-commit" \
    "$agents_home/skills/qwe-message-pr"
mkdir -p -- "$codex_home/agents" "$codex_home/templates" "$codex_home/rules"
cp -- "$script_dir/.codex/AGENTS.md" "$script_dir/.codex/principles.md" "$codex_home/"
cp -R -- "$script_dir/.codex/agents/." "$codex_home/agents/"
cp -R -- "$script_dir/.codex/templates/." "$codex_home/templates/"
if [[ ! -e "$codex_home/qwe-layout.toml" ]]; then
    cp -- "$script_dir/.codex/qwe-layout.toml" "$codex_home/"
fi
if [[ ! -e "$codex_home/rules/setup.md" ]]; then
    cp -- "$script_dir/.codex/rules/setup.md" "$codex_home/rules/"
fi
cp -R -- "$script_dir/.agents/." "$agents_home/"
