# Modele i custom nodes

Punkt startowy: konfiguracja nie instaluje modeli ani zewnętrznych custom nodes.
Bieżący stan sprawdzaj na dysku i w logach/API; nie uznawaj tego wpisu za skan instalacji.

Po instalacji lub aktualizacji uzupełniaj rejestr automatycznie. Dla modelu zapisz:
identyfikator, zastosowanie, oficjalne źródło i rewizję, nazwę/ścieżkę pliku względem
`models/`, rozmiar, SHA256 (zaznacz, czy porównano z sumą autora), licencję/link i istotne
ograniczenia, zależne enkodery/VAE/LoRA, sprawdzony workflow oraz wynik testu na tym GPU.
Nie oznaczaj pliku jako zweryfikowanego przez autora wyłącznie na podstawie lokalnej sumy.

Dla node packa zapisz URL repo, pełny commit, ścieżkę względem `custom_nodes/`, instalator
lub komendę odtworzenia, zależności i workflow potwierdzający działanie. Sam checkout
ignorowanego katalogu nie odtworzy instalacji na nowej maszynie.

Rozróżniaj statusy: pobrane, zainstalowane, sprawdzone generacją, wycofane.
Nie przechowuj tutaj tokenów ani podpisanych URL. Utrzymuj aktualny wpis zamiast
kumulowania listy wszystkich prób. Modele aktualizuj tak, by działająca recepta nadal
wskazywała konkretny plik; nie nadpisuj go nowym modelem pod tą samą nazwą.
