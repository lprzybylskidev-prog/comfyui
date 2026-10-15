# Walidacja — 2026-10-15

- Host `nvidia-smi`: NVIDIA GeForce RTX 4070 Laptop GPU, sterownik 580.159.03.
- `docker run --rm --gpus all nvidia/cuda:12.8.1-runtime-ubuntu24.04 nvidia-smi`:
  **błąd hosta** `failed to discover GPU vendor from CDI: no known GPU vendor found`.
  Brak `nvidia-ctk`; dostępne sudo wymaga hasła. Nie instalowano niczego na hoście.
- Obraz developerski: zbudowany rzeczywiście lokalnym Dockerem, bez modeli.
- Python 3.12.3, torch 2.10.0+cu128, `torch.version.cuda == '12.8'`.
- `torch.cuda.is_available()`: **False** w kontenerze testowym bez przekazanego GPU.
  Test GPU ani obliczenia CUDA nie zostały zaliczone; wymagają konfiguracji Toolkit hosta.
- W jawnym trybie diagnostycznym `COMFYUI_CPU=1`: ComfyUI v0.40.0,
  HTTP 200 dla `/` oraz `/system_stats`.
- Supervisor: start, ponowny start, stop, status i restart sprawdzone;
  restart zmienia PID, zatrzymanie daje STOPPED i niezerowy status skryptu.
- `pip check` oraz `hf --version`: poprawne po przypięciu Typer 0.21.1.
- Prawa zapisu jako `vscode` UID/GID 1000: ComfyUI, models, input, output,
  workflows, custom_nodes, scripts; pliki próbne usunięte.
- Ścieżki modelu i custom nodes sprawdzone przez `folder_paths` z włączonym parserem
  i `--base-directory /workspaces/comfyui`; workflow symlink wskazuje katalog projektu.
- Końcowy obraz przebudowany z lockiem, następnie utworzono nowy kontener:
  bootstrap, automatyczny start i restart działają; `pip freeze` jest zgodny z lockiem.
- Pliki kontrolne w models, custom_nodes, input, output i workflows przetrwały
  wymianę kontenera na nowy obraz; po teście usunięto pliki kontrolne.
- Składnia wszystkich skryptów Bash, JSON devcontainera i reguły `.gitignore`: poprawne.

Nie wykonywano generacji obrazów (brak modeli). Nie testowano interfejsu VS Code;
cykl życia sprawdzono przez Docker i te same skrypty postCreate/postStart.
Pełny test po konfiguracji hosta: `./scripts/verify.sh` wewnątrz devcontainera.
