#!/usr/bin/env bash
source "$(dirname "$0")/../common.sh"
if [[ $# -ne 3 ]]; then echo "Usage: $0 HTTPS_URL MODEL_SUBDIRECTORY FILENAME" >&2; exit 2; fi
url=$1
category=$2
filename=$3
[[ "$url" == https://* ]] || { echo 'HTTPS URL required' >&2; exit 2; }
[[ "$category" =~ ^[a-zA-Z0-9_-]+$ && "$filename" =~ ^[a-zA-Z0-9_][a-zA-Z0-9_.-]*$ ]] || exit 2
mkdir -p "$ROOT/models/$category"
target="$ROOT/models/$category/$filename"
[[ ! -e "$target" ]] || { echo 'Destination already exists' >&2; exit 1; }
curl --fail --location --retry 3 --proto '=https' --proto-redir '=https' --output "$target.part" "$url"
mv "$target.part" "$target"
echo "Saved: $target"
