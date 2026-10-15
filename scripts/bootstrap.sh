#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"
source .devcontainer/versions.env
# Dev Containers may remap vscode to a different host UID after image build.
if [[ ! -w /opt/venv/lib/python3.12/site-packages ]]; then
    sudo chown -R "$(id -u):$(id -g)" /opt/venv
fi
mkdir -p models input output custom_nodes workflows user/default temp previews
if [[ ! -d ComfyUI/.git ]]; then
    if [[ -e ComfyUI ]]; then echo 'ComfyUI exists but is not a Git checkout; refusing to overwrite.' >&2; exit 1; fi
    git init ComfyUI
    git -C ComfyUI remote add origin https://github.com/Comfy-Org/ComfyUI.git
fi
if [[ -n "$(git -C ComfyUI status --porcelain)" ]]; then
    echo 'ComfyUI has local changes; commit or stash them before bootstrap.' >&2; exit 1
fi
if [[ "$(git -C ComfyUI rev-parse HEAD 2>/dev/null || true)" != "$COMFYUI_COMMIT" ]]; then
    git -C ComfyUI fetch --depth 1 origin "$COMFYUI_COMMIT"
    git -C ComfyUI checkout --detach "$COMFYUI_COMMIT"
fi
python -m pip install -c "$ROOT/.devcontainer/requirements.lock" -r ComfyUI/requirements.txt
# Restore custom-node dependencies after image rebuild, without installing any nodes.
while IFS= read -r -d '' req; do python -m pip install -r "$req"; done < <(find custom_nodes -mindepth 2 -maxdepth 2 -name requirements.txt -print0)
python -m pip check
if [[ -e user/default/workflows && ! -L user/default/workflows ]]; then
    echo 'user/default/workflows exists; move its contents to workflows/ before bootstrap.' >&2; exit 1
fi
ln -sfn ../../workflows user/default/workflows
