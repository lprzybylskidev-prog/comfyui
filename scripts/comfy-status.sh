#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"
echo "Address: http://localhost:8188; log: $ROOT/logs/comfyui.log"
if [[ ! -f "$CONFIG" ]]; then echo 'ComfyUI is stopped.'; exit 1; fi
supervisorctl -c "$CONFIG" status comfyui
curl --fail --silent http://127.0.0.1:8188/system_stats >/dev/null
