# Isolates - maturitní_aplikace

# Jak tato aplikace funguje
Tato aplikace se skladá ze čtyř dart kódů v lib.
Main.dart  - spustí aplikaci a přesměruje na home obrazovku
home_screen.dart - zobrazuje nadpisy, zda aplikace teď počita nebo ne a také tlačitka
spinner_box.dart - kód pro otačejicí se čtverec
prime_calculator.dart - vypočet všech prvočísel do 5 milionů, dá se spustit dvěma způsoby, přes primary vrstvu a s pomoci isolate vrstvy.

# Spuštění
Zadejte tyhle příkazy do terminalu ve složce maturita_project1
--flutter pub get
--flutter run

## Zapnutí testů
--flutter test

## Co testy ověřuji
- `prime_calculator_test.dart`: správné počty prvočísel pro známé limity
  (10 → 4, 100 → 25, 1000 → 168) a že výsledek z isolate je stejný
  jako z přímého volání.
- `home_screen_test.dart`: zobrazení tlačítek a výchozího textu,
  zobrazení výsledku po stisku „Isolate", a že se animace otáčí.
