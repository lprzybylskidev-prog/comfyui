#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
bash scripts/comfy-stop.sh
bash scripts/comfy-start.sh
