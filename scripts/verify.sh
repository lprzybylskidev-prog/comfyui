#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"
for dir in ComfyUI models input output workflows custom_nodes scripts; do
    probe=$(mktemp "$ROOT/$dir/.permission-test.XXXXXX")
    rm "$probe"
done
nvidia-smi
python - <<'PY'
import torch
print('PyTorch:', torch.__version__)
print('CUDA:', torch.version.cuda)
assert torch.cuda.is_available(), 'GPU is unavailable; check host NVIDIA Container Toolkit'
print('GPU:', torch.cuda.get_device_name(0))
assert torch.cuda.get_device_name(0) == 'NVIDIA GeForce RTX 4070 Laptop GPU'
x = torch.ones(16, device='cuda')
assert (x + x).sum().item() == 32
PY
bash scripts/comfy-status.sh
curl --fail --silent http://127.0.0.1:8188/system_stats
