#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"
exec 9> .runtime/service.lock
flock 9
if [[ -f "$CONFIG" ]] && supervisorctl -c "$CONFIG" pid >/dev/null 2>&1; then
    supervisorctl -c "$CONFIG" stop comfyui
else
    echo 'ComfyUI supervisor is stopped.'
fi
