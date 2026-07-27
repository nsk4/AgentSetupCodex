#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${CODEX_HOME:-$HOME/.codex}"

mkdir -p -- "$target_dir"
cp -R -- "$script_dir/.codex/." "$target_dir/"
