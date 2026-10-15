# Źródła i skills

Sprawdzone 2026-10-15; sprawdzaj aktualny stan przy zmianach narzędzi.

- [Skills ComfyUI](https://docs.comfy.org/agent-tools/skills) wskazują oficjalne repo
  [Comfy-Org/comfy-skills](https://github.com/Comfy-Org/comfy-skills).
  Jego obecny README opisuje integrację Comfy Cloud i plugin Claude Code.
- Skills lokalnego CLI są rozwijane w
  [comfy-cli/comfy_cli/skills](https://github.com/Comfy-Org/comfy-cli/tree/main/comfy_cli/skills).
  Zakładają dostęp do polecenia `comfy` i jego konkretnego API. CLI nie jest obecnie
  instalowany w tym repo; nie traktuj opisanych tam narzędzi jako dostępnych.
- Lokalne skills w `.agents/skills/` są napisane dla tego repo, a nie skopiowane
  ani oznaczone jako oficjalne. Wykorzystują istniejące skrypty i lokalne API.
- [Wykrywanie skills przez Codex](https://learn.chatgpt.com/docs/build-skills):
  `.agents/skills/<nazwa>/SKILL.md`, jawne wywołanie `$nazwa` lub dobór automatyczny.
  Jeśli nowe skills nie są widoczne, uruchom ponownie sesję Codexa w repo.

Źródłem schematów nodów jest `/object_info` uruchomionej lokalnej instancji.
Dla semantyki API sprawdzaj kod przypiętego `ComfyUI/server.py` i przykłady w
`ComfyUI/script_examples/`; dokumentacja nowszego upstream może wyprzedzać nasz pin.
Oficjalny punkt wejścia: [docs.comfy.org](https://docs.comfy.org/).
