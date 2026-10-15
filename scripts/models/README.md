# Instalatory modeli

Nie pobieramy modeli podczas budowania ani inicjalizacji kontenera.

`./scripts/models/install-model.sh HTTPS_URL checkpoints model.safetensors`

Plik jest najpierw zapisywany jako `.part`. Sprawdź licencję, źródło i sumę SHA256.
Dla prywatnych modeli Hugging Face użyj `hf download OWNER/REPO FILE --local-dir models/KATEGORIA`;
CLI odczyta `HF_TOKEN` ze środowiska (np. `set -a; source .env; set +a`).
Nie umieszczaj tokenów w URL ani argumentach poleceń zapisywanych w historii.
Dedykowane instalatory FLUX/SDXL można dodać po wybraniu konkretnych modeli.
