# NVIDIA GPU na hoście — brak Toolkit

Objaw: obraz buduje się, ale `docker run --gpus all` i Dev Containers kończą się
`failed to discover GPU vendor from CDI: no known GPU vendor found`.

Potwierdzone 2026-10-15: host widzi RTX 4070 Laptop GPU, sterownik 580.159.03;
nie ma `nvidia-ctk` ani pakietu `nvidia-container-toolkit`, a Docker ma tylko runtime’y
`runc` i `io.containerd.runc.v2`. To blokuje start przed bootstrapem ComfyUI.
Ostrzeżenia `InvalidDefaultArgInFrom` i deprecated lockfile w tym logu nie są przyczyną.

## Jednorazowa instalacja na hoście Ubuntu / Pop!_OS / Debian

Uruchom poniższy blok w terminalu **hosta**, poza devcontainerem.
To konfiguracja dostępu Dockera do istniejącego sterownika; nie instaluje Pythona,
PyTorch ani sterownika GPU. Restart Dockera może przerwać działające kontenery.
Agent nie wykonał instalacji: `sudo` wymaga hasła użytkownika. Nie podawaj hasła w czacie.

Procedura według [oficjalnej instrukcji NVIDIA](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html):

```bash
# Przerwij przy błędzie któregokolwiek kroku.
(
set -euo pipefail
sudo apt-get update
sudo apt-get install -y --no-install-recommends ca-certificates curl gnupg2

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey |
  sudo gpg --dearmor --yes -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -fsSL https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list |
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list >/dev/null

sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

docker run --rm --gpus all nvidia/cuda:12.8.1-runtime-ubuntu24.04 nvidia-smi
)
```

Gdy test pokazuje GPU, ponownie wybierz w VS Code
**Dev Containers: Rebuild and Reopen in Container**, a w terminalu kontenera uruchom:

```bash
./scripts/verify.sh
```

Nie usuwaj `--gpus=all` i nie włączaj CPU, aby ukryć ten błąd. W tym przypadku
nie trzeba zmieniać obrazu ani instalować CUDA na hoście. Jeśli test nadal nie działa,
zachowaj wynik `nvidia-ctk --version`, `docker info` i pełny komunikat testu GPU;
nie kasuj istniejącej konfiguracji Dockera. Powyższa procedura dotyczy zwykłego,
systemowego Dockera; rootless wymaga osobnej konfiguracji z dokumentacji NVIDIA.
