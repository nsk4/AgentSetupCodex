#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
agents_home="${AGENTS_HOME:-$HOME/.agents}"

mkdir -p -- "$codex_home" "$agents_home"
cp -R -- "$script_dir/.codex/." "$codex_home/"
cp -R -- "$script_dir/.agents/." "$agents_home/"
