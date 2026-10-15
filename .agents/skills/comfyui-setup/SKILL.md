---
name: comfyui-setup
description: Dobieraj, pobieraj i konfiguruj modele oraz custom nodes dla lokalnego ComfyUI w tym repo; diagnozuj zgodność i błędy środowiska.
---

# Lokalne środowisko ComfyUI

Przeczytaj `AGENTS.md`, odpowiednie fragmenty `README.md` i `docs/models-and-nodes.md`.
Sprawdź rzeczywisty stan GPU, wolne miejsce, wersje pakietów i istniejące pliki przed
wyborem modelu. Dobieraj wariant do zadania i rzeczywiście dostępnego VRAM, uwzględniając
enkodery/VAE i narzut workflow; nie gwarantuj dopasowania na podstawie rozmiaru pliku.

Znajdź oficjalną kartę modelu/repo autora i bieżącą procedurę instalacji. Sprawdź
licencję pod planowane użycie, wymagane komponenty i kompatybilne nody. Pobieraj to,
co potrzebne zadaniu; nie dokładaj pakietów ani menedżera nodes na zapas. Jeśli wybrany
wariant wymaga brakującego tokena, zgody na licencję lub opłaty, poinformuj o konkretnej
przeszkodzie. Nie zastępuj samodzielnie lokalnego wykonania usługą cloud.

Instaluj modele pod `models/`, a node packi pod `custom_nodes/`. Do publicznych plików
użyj `scripts/models/install-model.sh URL KATEGORIA NAZWA`; dla repo Hugging Face można
użyć `hf download` z przypiętą rewizją. Sekrety czytaj ze środowiska, nie zapisuj ich
w poleceniach z tokenem, URL, logach ani dokumentacji. Zweryfikuj transfer i sumę,
jeśli autor ją udostępnia. Nie nadpisuj działającego modelu bez zachowania odtwarzalności.

Zależności instaluj przez Python venv kontenera, zachowując constraints PyTorch.
Przy node packu zapisz pełny commit i sposób odtworzenia. Po zmianie sprawdź `pip check`,
restart przez skrypt repo, logi i obecność nodów w `/object_info`. Gdy zadanie obejmuje
uruchomienie modelu, wykonaj małą rzeczywistą generację; samo HTTP 200 nie potwierdza
załadowania wag. Dla workflow można użyć lokalnego skill `comfyui-workflows`.

Przy błędzie ustal warstwę: host/Toolkit, importy Pythona, brakujący node/model,
walidacja grafu czy OOM. Dostosuj właściwy element, bez losowych aktualizacji całego
środowiska. CPU to jawna diagnostyka, nie dowód działania GPU.

Uzupełnij rejestr w `docs/models-and-nodes.md` oraz receptę odpowiedniego workflow.
Powtarzalną naprawę dokumentuj w temacie; do `AGENTS.md` awansuj tylko regułę całego repo.
Podaj wynik testu i ewentualne ograniczenia, nie przedstawiaj instalacji jako udanej
przed weryfikacją wymaganą zadaniem.
