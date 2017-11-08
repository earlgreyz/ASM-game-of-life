# Programowanie w Asemblerze
## Zadanie zaliczeniowe 1

Naszym celem będzie napisanie funkcji realizujących symulację automatu komórkowego Conwaya, tzw. __gry w życie__. Gra odbywa się na prostokątnej planszy składającej się z kwadratowych komórek. Każda komórka może być żywa lub martwa.

__Czas jest dyskretny__, w każdym kroku symulacji:

* _Każda żywa komórka_, która ma _4 lub więcej żywych sąsiadów_ __umiera__ z powodu tłoku.
* _Każda żywa komórka_, która ma _mniej niż 2 sąsiadów_ __umiera__ z osamotnienia.
* Jeśli _martwa komórka_ ma dokładnie _3 żywych sąsiadów_, to __ożywa__.

_Przez sąsiadów komórki rozumiemy 8 komórek bezpośrednio otaczających ją._

## Interfejs
Część napisana w języku wewnętrznym powinna eksportować procedury wołane z C:
* `void start(int szer, int wys, char* T)` - Przygotowuje symulację
* `void run(int ile_kroków)` - __Przeprowadza podaną liczbę kroków symulacji__, po ich wykonaniu tablica `T` (przekazana przez `start`) zawiera stan końcowy.

Dokładna postać wewnętrzna tablicy `T` nie jest określona, powinno być jednak możliwe jej łatwe zainicjowanie w programie w C przez wczytanie początkowej zawartości z pliku zawierającego kolejno:

* liczbę kolumn _(szerokość)_ i wierszy _(wysokość)_ w pierwszym wierszu;
* W kolejnych wierszach wiersze tablicy `T` w postaci __zer__ _(martwa komórka)_ i __jedynek__ _(żywa komórka)_.
* Testowy program główny napisany w C powinien __zainicjować tablicę `T`__ i rozpocząć symulację. Po każdym wywołaniu procedury `run` powinno się wyświetlić aktualną sytuację -- może być tekstowo, czyli gwiazdki i spacje lub tp.

__Rozwiązania nie zawierające pliku Makefile nie będą sprawdzane.__

## Oddawanie rozwiązań
Rozwiązania (procedury w asemblerze i program w C wraz z przykładowymi testami) należy wysłać do dnia 23 listopada (23:59) pocztą na zbyszek@mimuw.edu.pl jako pojedynczy załącznik -- archiwum o nazwie wskazującej na autora (np. ab123456-zad1.tgz), spakowane z osobnego katalogu o tej samej nazwie (ale bez tgz). Program ma działać w środowisku zainstalowanym w laboratoriach w trybie 64-bitowym.
