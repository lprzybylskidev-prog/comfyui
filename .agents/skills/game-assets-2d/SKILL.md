---
name: game-assets-2d
description: Projektuj prompty i spójne serie sprite’ów, postaci, itemów i tilemap 2D do gry; sprawdzaj referencje i techniczne wymagania eksportu.
---

# Spójne assety gry 2D

Przeczytaj `docs/projects/game-2d/brief.md` lub brief projektu wskazanego przez użytkownika.
Styl, perspektywę i skalę czerp z zatwierdzonych ustaleń i obejrzanych referencji.
Gdy kierunek nie jest wybrany, zaproponuj małą serię prób i zapytaj tylko o decyzje
wpływające na rezultat. Nie zakładaj pixel artu, izometrii, dark fantasy ani wielkości
kafelka. Zadanie o logo czy stockowej ilustracji nie przejmuje reguł gry.

Buduj prompt z części stałej (uzgodniony styl, paleta, światło, perspektywa i render)
oraz zmiennej (obiekt, poza, materiał, wariant). Zachowaj sprawdzony model, receptę
i referencje; sam identyczny seed nie zapewnia spójności postaci i różnych obiektów.
Dobieraj image conditioning/LoRA/inne techniki dopiero, gdy uzasadnia to wynik i zgodność
z modelem. Nie zmieniaj bazowego stylu w środku serii bez uzgodnienia.

Zacznij od kilku reprezentatywnych assetów oglądanych razem i w docelowej skali.
Po akceptacji traktuj je jako wzorzec; dopiero wtedy rozszerz serię. Lokalną generację
przeprowadzaj przez `comfyui-workflows`; outputy pozostają w ignorowanym `output/`.
Oddziel generowany surowy obraz od wersji po obróbce i finalnego eksportu.

Sprawdź stosownie do typu assetu:

- sprite/item: sylwetkę, czytelność, rozmiar, pivot, marginesy i kanał alpha;
- postać: proporcje, wyposażenie, kierunki i zgodność klatek, bez obietnicy animacji
  na podstawie pojedynczego renderu;
- tilemapa: zgodność siatki i skali, krawędzie w złożonym podglądzie co najmniej 3×3,
  narożniki/przejścia, jeśli wymagane, i widoczną powtarzalność wzoru;
- pixel art, jeśli wybrany: spójny rozmiar piksela, paletę, interpolację i przypadkowe
  rozmycie/antyaliasing; nie skaluj automatycznie metodą rozmywającą piksele.

Narysowana szachownica nie jest przezroczystością. Po usuwaniu tła sprawdź alpha,
krawędzie i halo na jasnym i ciemnym tle. Wymiary pliku i rozszerzenie nie dowodzą
spełnienia tych wymagań. Jeśli narzędzia nie pozwalają czegoś zweryfikować, zaznacz to.

Zachowaj odtwarzalną receptę i opis obróbki. Akceptację użytkownika oraz ważne decyzje
zapisuj w briefie bez proszenia o „zapisz”. Reguły konkretnej gry pozostaw w jej
katalogu dokumentacji, nie w głównym `AGENTS.md`.
