---
name: comfyui-workflows
description: Twórz, modyfikuj i uruchamiaj workflow lokalnego ComfyUI przez API w tym repo, także gdy użytkownik nie chce obsługiwać edytora nodów.
---

# Workflow lokalnego ComfyUI

Przeczytaj `docs/workflows.md` i brief właściwego projektu. Przejmij pracę nad grafem:
użytkownik ma opisać efekt, a nie wybierać porty i ręcznie łączyć nody.
Sprawdź status usługi, dostępne modele i `/object_info`. Zaczynaj od pasującego,
sprawdzonego workflow z repo albo oficjalnego przykładu zgodnego z zainstalowanymi nodami.
Nie zgaduj `class_type`, nazw wejść, indeksów wyjść ani nazw plików modeli.

Rozróżniaj JSON edytora i JSON API; endpoint `/prompt` oczekuje grafu API.
Semantykę żądania i odpowiedzi potwierdź w przypiętym `ComfyUI/server.py` lub przykładach
`ComfyUI/script_examples/`. Nie zakładaj istnienia comfy CLI ani MCP. Wystarczy lokalne
HTTP i niewielki skrypt klienta dopasowany do zadania.

Wybieraj najprostszy graf realizujący cel. Zapisz prompty i parametry z jawnie ustawionym
seedem do testu; korzystaj tylko z parametrów obsługiwanych przez model. Zanim wyślesz
zadanie, sprawdź schematy, połączenia i pliki. Przy brakującym modelu/node dobierz
instalację w zakresie polecenia użytkownika, korzystając z `comfyui-setup`.

Prześlij małą próbę do lokalnego API, sprawdź błędy walidacji i zachowaj `prompt_id`.
Śledź historię tego konkretnego zadania (`/history/{prompt_id}`); zaakceptowanie do
kolejki nie oznacza ukończenia. Ustal limit oczekiwania i liczbę prób odpowiednie do
zadania. Po błędzie odczytaj przyczynę, popraw ją i unikaj nieograniczonych ponowień.
Nie kasuj cudzej kolejki ani nie przerywaj wszystkich zadań, by anulować własne.

Po ukończeniu ustal faktyczne pliki outputu, obejrzyj je dostępnym narzędziem i sprawdź
wymagania briefu. Jeśli nie masz możliwości obejrzenia, powiedz o tym; nie zatwierdzaj
jakości wizualnej na podstawie samej odpowiedzi API. Wskaż użytkownikowi wyniki.

Zapisz działający workflow i receptę zgodnie z `docs/workflows.md`. Zapisuj istotne
ustalenia samodzielnie; status „zaakceptowany” wymaga akceptacji użytkownika.
Nie utrwalaj prywatnych wejść lub tokenów w wersjonowanym JSON. Nie deklaruj sukcesu
pełnej generacji, jeżeli wykonałeś tylko walidację grafu lub healthcheck.
