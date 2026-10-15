# Workflow i recepty generacji

Zapisuj działające workflow w `workflows/<projekt>/` lub `workflows/shared/`.
JSON edytora (`*.ui.json`) zachowuje układ grafu; JSON API (`*.api.json`) służy do
`POST /prompt`. Nie są wymienne. Przechowuj oba, gdy są potrzebne; nie wymyślaj
konwertera bez sprawdzenia formatu bieżącej wersji. Sam poprawny JSON nie dowodzi,
że nody, modele i połączenia działają.

Obok workflow przechowuj krótki opis/receptę obejmującą:

- przeznaczenie, projekt i status: eksperymentalny / sprawdzony / zaakceptowany;
- model i jego rewizję/sumę, node packi/commity oraz wersję ComfyUI;
- prompty pozytywne i negatywne (jeśli model je obsługuje), seed, wymiary,
  sampler/scheduler, kroki, guidance i inne istotne ustawienia;
- referencje i wejścia: pochodzenie, lokalną ścieżkę i sumę pliku;
- sposób uruchomienia, ostatni wynik testu i lokalizację outputu;
- obróbkę, parametry eksportu oraz wersję ustaleń artystycznych/commit Git.

Nie zapisuj nieobsługiwanych parametrów na siłę. Dane konkretnej generacji mogą trafić
do pliku obok outputu, ale zaakceptowana recepta musi być wersjonowana: output jest
ignorowany i może zniknąć. Prywatne prompty/referencje pozostaw w ignorowanych danych;
w wersjonowanym opisie użyj neutralnego identyfikatora, bez sekretów i osadzonych obrazów.
