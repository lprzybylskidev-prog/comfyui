# ComfyUI — VS Code Dev Container

Jedno środowisko developerskie z ComfyUI, CUDA i PyTorch. Bez modeli na start.

## Requirements

Host: Linux x86_64, Docker, VS Code, rozszerzenie Dev Containers, sterownik NVIDIA
oraz NVIDIA Container Toolkit skonfigurowany dla Dockera. Zalecany sterownik >=570.26
(CUDA 12.8); lokalnie wykryto 580.159.03. CUDA ani Python nie są potrzebne na hoście.
Budowanie wymaga internetu i kilkunastu GB wolnego miejsca.

Oficjalna instrukcja Toolkit:
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
Po instalacji pakietów na hoście skonfiguruj runtime:

```bash
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

### Test GPU hosta

```bash
nvidia-smi
docker run --rm --gpus all nvidia/cuda:12.8.1-runtime-ubuntu24.04 nvidia-smi
```

Ten drugi test musi przejść przed otwarciem devcontainera. Błąd `no known GPU vendor
found` oznacza brak konfiguracji Toolkit/CDI na hoście, a nie brak PyTorch.
Pełna procedura instalacji brakującego Toolkit na hoście i diagnoza błędu:
[GPU Dockera — konfiguracja hosta](docs/nvidia-host.md).
Nie instaluj sterownika NVIDIA w kontenerze.

## Installation

```bash
git clone https://github.com/lprzybylskidev-prog/comfyui
cd comfyui
code .
```

Wybierz **Dev Containers: Rebuild and Reopen in Container**. Obraz instaluje zależności,
`postCreateCommand` pobiera przypięty ComfyUI, a `postStartCommand` uruchamia usługę
i czeka do 120 sekund na API. Otwórz http://localhost:8188.
Rozszerzenie Codex zainstaluj ręcznie wewnątrz kontenera.

Użytkownik `vscode` ma venv `/opt/venv`, sudo i zapisywalny workspace.
Dev Containers dopasowuje UID/GID do użytkownika hosta; klonuj repo jako swój użytkownik.
Port jest forwardowany przez VS Code. ComfyUI słucha na `0.0.0.0:8188` wewnątrz
kontenera; konfiguracja nie publikuje portu przez Docker na interfejsach hosta.

## Wersje i źródła

- NVIDIA CUDA **12.8.1 runtime**, Ubuntu **24.04**, obraz przypięty przez SHA256.
- Python **3.12** z Ubuntu (poprawki bezpieczeństwa dostarcza apt).
- PyTorch **2.10.0+cu128**, torchvision **0.25.0+cu128**, torchaudio **2.10.0+cu128**.
- ComfyUI **v0.40.0**, commit w `.devcontainer/versions.env`.
- Hugging Face CLI `hf` z `huggingface-hub 1.13.0`.

Dobór oparty o oficjalne źródła:
[ComfyUI](https://docs.comfy.org/installation/manual_install),
[PyTorch — zgodne zestawy wersji](https://pytorch.org/get-started/previous-versions/),
[NVIDIA CUDA 12.8](https://docs.nvidia.com/cuda/archive/12.8.0/cuda-toolkit-release-notes/).
Wybrano stabilny zestaw cu128 obsługujący RTX 4070, zamiast nightly.
Zależności Pythona przypina `.devcontainer/requirements.lock` (Python 3.12, Linux x86_64).
Typer 0.21.1 pozostaje przypięty ze względu na zgodność CLI `hf` z Click.
Apt dostarcza aktualizacje systemu; pełna identyczność binarna kolejnych buildów nie jest gwarantowana.

## GPU test

W terminalu kontenera:

```bash
nvidia-smi
python - <<'PY'
import torch
print(torch.__version__)
print(torch.version.cuda)
assert torch.cuda.is_available()
print(torch.cuda.get_device_name(0))
assert torch.cuda.get_device_name(0) == 'NVIDIA GeForce RTX 4070 Laptop GPU'
PY
curl --fail http://127.0.0.1:8188/system_stats
```

Pełna kontrola GPU, HTTP i praw zapisu: `./scripts/verify.sh`.

## Directory structure

Workspace zawsze montowany jest jako `/workspaces/comfyui`.

| Katalog | Zawartość | Git |
|---|---|---|
| `ComfyUI/` | Automatyczny checkout oficjalnego kodu | ignorowany |
| `models/` | Jedyne główne miejsce modeli, np. checkpoints, loras, vae, diffusion_models, text_encoders | ignorowany |
| `custom_nodes/` | Repozytoria custom nodes | ignorowany |
| `workflows/` | Workflow projektu; symlink z `user/default/workflows` | wersjonowany |
| `input/`, `output/` | Pliki wejściowe i wyniki | ignorowane |
| `user/` | Ustawienia i baza ComfyUI | ignorowany |
| `logs/`, `.runtime/`, `temp/`, `previews/` | Logi, socket/PID i dane tymczasowe | ignorowane |
| `scripts/` | Zarządzanie i instalatory | wersjonowany |

ComfyUI uruchamia się z `--base-directory /workspaces/comfyui`; oficjalny mechanizm
kieruje modele, custom nodes i dane poza checkout. Rebuild nie usuwa danych w bind
mount. Usunięcie repozytorium na hoście usuwa też te dane — wykonuj własne kopie.
Modele nie trafiają do kontekstu budowania ani do obrazu.

## Service management

```bash
./scripts/comfy-start.sh
./scripts/comfy-status.sh
./scripts/comfy-stop.sh
./scripts/comfy-restart.sh
tail -f logs/comfyui.log
```

Supervisor działa jako `vscode`, utrzymuje proces po zamknięciu terminala,
restartuje go po awarii i rotuje logi. Status pokazuje PID, adres i log, sprawdza API.
Zatrzymanie obejmuje grupę procesów; restart czeka na gotowość HTTP.
Wyłącznie do diagnostyki bez GPU można ustawić `COMFYUI_CPU=1` w `.env`.
Domyślnie GPU jest wymagane; nie ma automatycznego fallbacku na CPU.
Po zmianie `.env` wykonaj restart. `.env` zawiera składnię powłoki i jest ignorowany.

## Custom nodes i modele

```bash
git clone https://github.com/AUTOR/NODE custom_nodes/NODE
python -m pip install -r custom_nodes/NODE/requirements.txt
./scripts/comfy-restart.sh
```

Instaluj tylko zaufany kod. Bootstrap odtwarza `requirements.txt` istniejących nodes
po rebuildzie. Constraints chronią zestaw torch; konflikt wymaga świadomej zmiany
wersji w obrazie. Zanotuj repo i commit każdego dodanego node w wersjonowanym pliku,
żeby móc odtworzyć je na nowym klonie. Nie instalujemy Managera ani dodatkowych nodes.

Narzędzia: `curl`, `wget`, `aria2c`, `hf`. Szczegóły w `scripts/models/README.md`.
Sekrety podawaj przez środowisko lub ignorowany `.env` utworzony z `.env.example`.
Nie zapisuj ich w workflow, URL, skryptach ani commitach.

## Updating ComfyUI

1. Zatrzymaj usługę i zabezpiecz lokalne zmiany w `ComfyUI/` (commit/stash).
2. Wybierz oficjalny tag, sprawdź release notes i ustal jego pełny SHA.
3. Zmień `COMFYUI_COMMIT` w `.devcontainer/versions.env`. Jeśli wymagane, zaktualizuj
   zestaw PyTorch w constraints i Dockerfile na podstawie oficjalnej tabeli.
4. Przy zmianie wersji ComfyUI zaktualizuj też `requirements.lock` w czystym środowisku
   bez custom nodes, rozwiązując zależności z constraints PyTorch. Zapisz `python -m pip freeze`
   i sprawdź `python -m pip check`. Konflikt starego locka z nowymi requirements wymaga
   ponownego rozwiązania wersji, a nie usuwania kontroli zależności.
5. Wybierz **Rebuild and Reopen in Container** — obraz i workspace użyją tego samego SHA.
6. Sprawdź GPU, HTTP, workflow i logi; commituj zmiany konfiguracji.

Powrót: przywróć poprzednie piny i przebuduj. Modele, nodes i dane pozostają
w workspace; nowe wersje mogą migrować bazę `user/`, więc przed aktualizacją zrób jej kopię.

Wyniki rzeczywistych testów i ograniczenia: [VALIDATION.md](VALIDATION.md).

## Praca z Codexem

Instrukcje projektu: [AGENTS.md](AGENTS.md). Mapa wiedzy: [docs/README.md](docs/README.md).
Codex ma sam aktualizować dokumentację przy trwałych ustaleniach; główny plik zasad
pozostaje krótki, a szczegóły modeli, workflow i stylu gry trafiają do dokumentów tematycznych.
Lokalne skills w `.agents/skills/` obejmują środowisko ComfyUI, workflow przez API
i spójne assety gry 2D. Możesz wywołać np. `$game-assets-2d`; zwykle wystarczy opisać zadanie.
Styl gry ustalimy osobno — obecny brief nie narzuca estetyki.
