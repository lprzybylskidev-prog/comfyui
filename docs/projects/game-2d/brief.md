# Gra 2D — brief i spójność

Status: ustalony kierunek oraz role pierwszego zestawu referencji; brak prób generacji.

## Potwierdzony kierunek projektu

- Strategia 2D inspirowana Civilization V, w świecie fantasy.
- Zamiast państw historycznych: rasy, m.in. ludzie, krasnoludy i elfy.
  Każda rasa ma mieć kilku przywódców do wyboru.
- Estetyka: brudne dark fantasy w ziarnistym pixel arcie, o umiarkowanej ilości
  szczegółów. Kolorystyka i sposób renderowania według plików `Untitled*`; portrety
  według `Rhx6QY.png` i `qDamVf.png`. Dokładna paleta i technika wymagają prób.
- Większość assetów: sprite’y i tilesety. Zakres obejmuje też interfejs,
  ilustracje do menu, portrety postaci i inne grafiki potrzebne grze.
- Wstępny rozmiar sprite’ów/kafelków: 64×64 px. Użytkownik obawia się, że 128×128 px
  da zbyt gładki efekt. Nie jest to ustalony rozmiar portretów, UI ani ilustracji menu.
- Siatka mapy: heksy albo kwadraty, decyzja otwarta. Teren powstaje jako osobna
  warstwa, a siatka jest nakładana na niego. Grafiki terenu nie odpowiadają pojedynczym
  polom gry i nie mają być wycinane w kształt heksów; wybór siatki nie określa
  kształtu pojedynczego assetu terenu.
- W zakładanym wariancie heksowym na jedno pole gry przypadają cztery sprite’y terenu.
  Dokładny układ i sposób łączenia pozostają do określenia; nie zakładaj automatycznie 2×2.
- Zabudowa pola jest kompozycją od jednego do czterech obrazków, zależnie od stopnia
  rozbudowy. Nie przygotowuj jednego gotowego obrazka całego pola dla każdego budynku.
  Moduły i ich warianty mają umożliwiać losowe zróżnicowanie, aby np. pola uprawne
  i tartaki nie wyglądały wszędzie identycznie. Celem jest naturalniejszy wygląd mapy.
- Pełne 2D, widok top-down, bez izometrii i pseudo-3D. Obiekty lekko stylizowane;
  budynki mogą pokazywać fragmenty ścian, zachowując konwencję top-down.
  Dokładny sposób projekcji obiektów wymaga próby wizualnej.
- Silnik gry i wymagania eksportu nie zostały określone.

Pierwszy zestaw referencji i uzupełniający opis z ChatGPT zostały dostarczone.
W razie rozbieżności wcześniejsze ustalenia i wskazana przez użytkownika rola obrazów
mają pierwszeństwo przed tym opisem. Wybór modelu pozostaje wstrzymany do osobnego
ustalenia. Użytkownik zatwierdził commit i push zebranych ustaleń.

## Dodatkowe wymagania wizualne

- Pixel art czytelny, z widocznymi grupami pikseli, bez przesadnego wygładzania
  i bez efektu realistycznego obrazu przepuszczonego przez filtr. Poziom detalu
  pozostaje umiarkowany, według `Untitled*`; określenie „dość szczegółowy”
  z dodatkowego opisu nie podnosi go ponad wcześniej zaakceptowany kierunek.
- Świat ponury, surowy, średniowieczny, zużyty, niebezpieczny i zamieszkany.
  Mało heroiczności i kolorowego high fantasy.
- Materiały: stare drewno, ciemny kamień, błoto, ziemia, rdza i zużyty metal;
  popękane mury, zniszczone dachy, mokre i zabrudzone drogi.
- Paleta przygaszona: brązy, szarości, oliwkowe i ciemne zielenie, ciemny granat,
  czerń, miejscami rdzawe czerwienie i pomarańcze. Mocniejsze kolory jako akcenty.
  To opis kierunku, nie zamknięty zestaw kolorów; wzorcem pozostają `Untitled*`.
- Biomy wyraźnie zróżnicowane przez kolory, grunt, roślinność, dekoracje,
  architekturę i atmosferę. Mapa nie może sprowadzać się do zielonych lasów i łąk.
  Przykładowe obszary (nie zamknięta lista wymaganych assetów): ciemne lasy,
  mokradła, skaliste wyżyny, góry, martwe pustkowia, spalona ziemia, tereny
  skorumpowane, obszary wulkaniczne, stare ruiny, wybrzeża i tereny rolnicze.
- Architektura ciężka, brudna, użytkowa. Zamki i fortece mogą być monumentalne;
  mniejsze budynki praktyczne i surowe. Bez estetyki eleganckiego fantasy MMO,
  nadmiaru złotych ornamentów, błyszczących zbroi i czystych bajkowych miast.
  Nie usuwa to detali wyposażenia zaakceptowanych w referencjach portretów.
- Warianty obejmują nie tylko zabudowę i uprawy, ale też ruiny, domy, drogi,
  dekoracje, elementy lasu i skały. Wspólny styl przy ograniczeniu widocznych
  powtórzeń tych samych sprite’ów.

## Ustalenia do uzupełnienia z użytkownikiem

Przy pierwszym konkretnym zadaniu ustal tylko to, co wpływa na wynik:

- doprecyzowanie dark fantasy przez zaakceptowane przykłady, paletę, kontury,
  cieniowanie i kierunek światła;
- dopracowanie projekcji top-down, skala postaci względem świata i docelowa czytelność;
- potwierdzenie wstępnych 64×64 px, siatka, pivot/punkt oparcia, marginesy;
- tło/alpha, format eksportu, filtrowanie i sposób skalowania;
- dla tilemap: reguły krawędzi, warianty i powtarzalność;
- dla postaci: kierunki, klatki/animacje i zgodność sylwetki/wyposażenia.

## Akceptacja i referencje

Użytkownik dostarczył 15 obrazów w lokalnym, ignorowanym `examples/1/`.
Celem jest połączenie wybranych cech w jeden spójny styl; żaden obraz nie jest
w całości zatwierdzonym wzorcem. Poniższy podział wynika z oceny użytkownika:

| Referencje | Co wykorzystać | Czego nie przejmować |
|---|---|---|
| `Untitled.png`, `Untitled1.png`, `Untitled2.png` | Główne wzorce kolorystyki i stylu grafiki: lekko ziarnisty pixel art, bez nadmiernej szczegółowości | Izometrii |
| `Rhx6QY.png`, `qDamVf.png` | Mocno zaakceptowany kierunek portretów, zwłaszcza ziarnisty pixel art | Nie ustalono jeszcze szczegółowych ograniczeń |
| Sześć plików `lucid-origin_*.jpg` | Orientacyjny widok terenu i sposób jego prezentacji; obrazy wygenerowane przez AI | Nie traktować ich jako głównego wzorca renderowania; projekcję dopracować w ramach ustalonego top-down |
| `mqlw4Z.jpg` | Pomysły na elementy fantastycznego świata | Styl pixel artu nie odpowiada użytkownikowi; nie kopiować zagęszczenia obiektów ani ograniczać świata do szkieletów/nieumarłych |
| `yHpmKF.png`, `bBb1a6.png`, `fLU2Oq.png` | Pomijać — użytkownik wycofał te referencje | Nie czerpać z nich UI, palety, renderowania ani geometrii |

Styl GUI pozostaje otwarty po wycofaniu obu przykładów interfejsu.
Izometria i osobne grafiki terenu w kształcie heksów pozostają wykluczone.
Brak bazowej recepty i modelu. Referencje służą do syntezy stylu, bez kopiowania
konkretnych elementów 1:1.

### Identyfikacja aktywnych referencji

Lokalizacja: `examples/1/` (poza Git). Pochodzenie poza informacją o generowaniu
plików `lucid-origin` przez AI nie zostało ustalone. Sumy SHA256 identyfikują
obejrzane pliki; nie są weryfikacją autora ani praw do wykorzystania.

- `Rhx6QY.png`: `956bd1a3c144029f0722ab3e381be2b9eb213e0c119b6ec06a092963c5955dec`
- `Untitled.png`: `4e487707b0938ca0ad213be8e73d7d6b590f63a4ecc1e6ce563e176b8cd43bf1`
- `Untitled1.png`: `05e3059cfed31f2a60e7776a462011252c9d4905181538f47a4de8b7f9fb215c`
- `Untitled2.png`: `ef69983e48943912e30f891b67f1a2ed8d9cac089ae581f29217b2b1446a0c24`
- `lucid-origin_Strict_2D_top-down_pixel_art_dark_fantasy_strategy_map._Camera_directly_above._N-0.jpg`: `46aed9d6c39541ee1fc30b932af3660ee1ecc8364354110e51f3ff5946732210`
- `lucid-origin_Strict_2D_top-down_pixel_art_dark_fantasy_strategy_map._Camera_is_directly_above-0.jpg`: `fb689c82b22578c1228b2d0f3f91def322d5810f4965f047cfc8657e343b8e5b`
- `lucid-origin_Strict_2D_top-down_pixel_art_dark_fantasy_strategy_map._Camera_is_directly_above-1.jpg`: `eef1673a9c8a9c36d0dff1ced56d13555184a28f7ca8a8bf015006fec23edd2e`
- `lucid-origin_Strict_2D_top-down_pixel_art_dark_fantasy_strategy_map._Camera_is_directly_above-2.jpg`: `2802fc260ec98f349332cfee32f5ccb1fccc8b30d2511d7d9f21d2388f191682`
- `lucid-origin_Strict_2D_top-down_pixel_art_strategy_game_map_built_visually_from_64x64_square_-0.jpg`: `d05a340e48bf960d9e89600905d10b58842dd1f22b35f1b851e9cc7520e338b0`
- `lucid-origin_Strict_2D_top-down_pixel_art_strategy_game_map_built_visually_from_64x64_square_-1.jpg`: `9407f02f58db36e74a6d9f58b538206d77d8766caa871642cab611cdb82cc6b5`
- `mqlw4Z.jpg`: `4b1c8ba18006a4ef44f70032ebc3cc93a88eb761cf01bc8a0014682bcb403597`
- `qDamVf.png`: `78b2cb03ac48435743f1889059db3f74523ea5092affb44263cfd2832b537ef3`

Po akceptacji użytkownika zapisz identyfikatory obrazów wzorcowych, dostępne ścieżki
(np. `input/references/game-2d/`), sumy i źródła. Referencje mają być dostępne w kolejnej
sesji; jeśli ich brakuje, zgłoś to zamiast odtwarzać styl z domysłu.

Zapisuj tutaj zaakceptowane decyzje i ich krótkie uzasadnienie. Większe biblioteki
promptów/recept wydzielaj dopiero, gdy powstaną. Odrzucone warianty opisuj tylko wtedy,
gdy zapobiegnie to powtórzeniu istotnego błędu. Eksperyment nie zmienia stylu projektu.
