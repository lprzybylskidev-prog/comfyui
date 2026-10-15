FROM nvidia/cuda:12.8.1-runtime-ubuntu24.04@sha256:ebef3c171eeef0298e4eb2e4be843105edf3b8b0ac45e0b43acee358e8046867
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-venv python3-dev build-essential git curl wget aria2 ffmpeg \
    ca-certificates sudo supervisor libgl1 libglib2.0-0 libsndfile1 pkg-config \
    && rm -rf /var/lib/apt/lists/*
# Ubuntu 24.04 includes an unused UID 1000 account.
RUN if id ubuntu >/dev/null 2>&1; then userdel -r ubuntu; fi \
    && groupadd --gid 1000 vscode && useradd --uid 1000 --gid 1000 -m -s /bin/bash vscode \
    && echo 'vscode ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode
RUN python3 -m venv /opt/venv && chown -R vscode:vscode /opt/venv
ENV PATH="/opt/venv/bin:${PATH}" \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONUNBUFFERED=1
COPY .devcontainer/versions.env .devcontainer/torch-constraints.txt /opt/config/
USER vscode
RUN pip install --no-cache-dir pip==25.3 \
    && pip install --no-cache-dir -c /opt/config/torch-constraints.txt torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
COPY .devcontainer/requirements.lock /opt/config/requirements.lock
RUN . /opt/config/versions.env \
    && git init /tmp/ComfyUI && git -C /tmp/ComfyUI remote add origin https://github.com/Comfy-Org/ComfyUI.git \
    && git -C /tmp/ComfyUI fetch --depth 1 origin "$COMFYUI_COMMIT" \
    && git -C /tmp/ComfyUI checkout --detach FETCH_HEAD \
    && pip install --no-cache-dir -c /opt/config/torch-constraints.txt -r /opt/config/requirements.lock -r /tmp/ComfyUI/requirements.txt --extra-index-url https://download.pytorch.org/whl/cu128 \
    && pip check && hf --version && rm -rf /tmp/ComfyUI
ENV PIP_CONSTRAINT=/opt/config/torch-constraints.txt
WORKDIR /workspaces/comfyui
CMD ["sleep", "infinity"]
