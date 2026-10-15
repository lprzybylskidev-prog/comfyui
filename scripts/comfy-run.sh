#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"
args=()
# Explicit diagnostic mode; never silently fall back when GPU is unavailable.
if [[ "${COMFYUI_CPU:-0}" == 1 ]]; then args+=(--cpu); fi
exec /opt/venv/bin/python "$ROOT/ComfyUI/main.py" \
    --base-directory "$ROOT" --listen 0.0.0.0 --port 8188 "${args[@]}"
