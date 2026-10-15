#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"
exec 9> .runtime/service.lock
flock 9
cat > "$CONFIG" <<CONF
[unix_http_server]
file=$ROOT/.runtime/supervisor.sock
chmod=0600
[supervisord]
logfile=$ROOT/logs/supervisord.log
logfile_maxbytes=5MB
logfile_backups=2
pidfile=$ROOT/.runtime/supervisord.pid
childlogdir=$ROOT/logs
[rpcinterface:supervisor]
supervisor.rpcinterface_factory=supervisor.rpcinterface:make_main_rpcinterface
[supervisorctl]
serverurl=unix://$ROOT/.runtime/supervisor.sock
[program:comfyui]
command=/bin/bash "$ROOT/scripts/comfy-run.sh"
directory=$ROOT
startsecs=5
startretries=3
autostart=true
autorestart=unexpected
stopasgroup=true
killasgroup=true
stopwaitsecs=30
redirect_stderr=true
stdout_logfile=$ROOT/logs/comfyui.log
stdout_logfile_maxbytes=20MB
stdout_logfile_backups=3
CONF
if ! supervisorctl -c "$CONFIG" pid >/dev/null 2>&1; then
    rm -f .runtime/supervisor.sock .runtime/supervisord.pid
    supervisord -c "$CONFIG" 9>&-
else
    if [[ "$(supervisorctl -c "$CONFIG" status comfyui)" != *RUNNING* ]]; then
        supervisorctl -c "$CONFIG" start comfyui
    fi
fi
for ((i=0; i<120; i++)); do
    if [[ "$(supervisorctl -c "$CONFIG" status comfyui)" == *RUNNING* ]] && curl --fail --silent http://127.0.0.1:8188/system_stats >/dev/null; then
        bash scripts/comfy-status.sh
        exit 0
    fi
    sleep 1
done
echo 'ComfyUI did not become ready; see logs/comfyui.log' >&2
tail -n 40 logs/comfyui.log
exit 1
