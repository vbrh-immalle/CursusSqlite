# Op verkenning

Zorg dat je in Powershell (bij voorkeur in een lege map) staat en start `sqlite3`.

In `PS>`:

```
c:
mkdir ffsql
cd ffsql
sqlite3
```

Als het goed is, kan je nu sqlite3 interactieve commando's geven en zie je de `sqlite>`-prompt.

```
SQLite version 3.37.0 2021-09-28 10:44:54
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite>
```

## Oefening 1: .quit

Verlaat de sqlite-CLI-tool. In `sqlite>`:

```
.quit
```

Start de tool daarna weer op. In `PS>`:

```
sqlite3
```

## Oefening 2: een eerste query en multi-line input

Onze eerste regel SQL is zeer eenvoudig en geeft simpelweg het getal `3` terug.

Type in `sqlite>`:

```
SELECT 3;
```

Maar wat als je vergeet de `;` te typen?
Dan verandert de prompt van `sqlite>` naar `   ...>`!

Dit wil zeggen dat er op meer input wordt gewacht. Je kan dan alsnog de `;` typen.

Wat gebeurt er als je het volgende doet:

- type `select` + <enter>
- type nogmaals <enter>
- type `3` + <enter>
- druk nogmaals 2 keer op <enter>
- type `;` + <enter>

en je ziet waarschijnlijk:

```
sqlite> select
   ...>
   ...> 3
   ...>
   ...>
   ...> ;
3
sqlite>
```

Je krijg dus pas de `sqlite>`-prompt terug als je een **query** hebt afgesloten met `;`!

Wat gebeurt er als je **onzin** typt (of fouten maakt tegen de syntax van SQL)?

```
sqlite> blabla
blabla
   ...> 534
   ...> xyz
   ...> oeioei;
Error: near "blabla": syntax error
sqlite>
```

Dan krijg je letterlijk een **syntax error** die je pas te zien krijgt als je `;` hebt getypt!

## Oefening 3: nog enkele SELECT-queries

Geef volgende queries in die verschillende types van waarden teruggeven en zelfs berekeningen doen!

In `sqlite>`:

```
SELECT 3;
SELECT 'hallo';
select "hallo";
SELECT 3.14;
SELECT 5 + 3;
SELECT 2 * 3;
SELECT 8 / 2;
SELECT 8 / 2.0;
SELECT "hallo" || " joske";
```

Je kan een aantal dingen vaststellen over SQLite, nl.

- de symbolen voor optellen (`+`), vermenigvuldigen (`*`) en delen (`/`)
- het symbool om 2 strings aan elkaar te plakken is `||`
- strings mogen zowel single (`'`) als double (`"`) quotes gebruiken (verkies echter single quotes voor compatibiliteit met andere SQL-implementaties)
- wanneer 1 van 2 getallen in een wiskundige operatie een komma-getal is, is het resultaat ook een komma-getal

## Oefening 4: door de history scrollen

De interactieve CLI-tool `sqlite3` is zeer goed geschikt om queries uit te testen. Je zal dus vaak fouten maken en deze willen corrigeren. Je moet dan niet altijd de hele regel opnieuw typen.

Type in `sqlite>`:

```
SELECT 3 + 5;
```

Je krijgt het antwoord (`8`) te zien.

Druk nu op de pijltjestoets naar boven. Vervolgens kan je met de pijltjestoetsen links en rechts de regel code bewerken en met `ENTER` weer uitvoeren.

Probeer volgende snelkoppelingen tijdens het bewerken van een eerdere regel:

- `HOME` of `CTRL-A` om naar het begin v.d. regel te gaan
- `END` of `CTRL-E` om naar het einde v.d. regel te gaan
- `CTRL-LINKS` of `ALT-B` om naar het begin v.h. vorige 'woord' te springen
- `CTRL-RECHTS` of `ALT-F` om naar het begin v.h. volgende 'woord' te springen
- `ENTER` om de regel opnieuw uit te voeren
- Pijltje omhoog of `CTRL-P` (previous) om de vorige lijn uit de history te tonen
- Pijltje omlaag of `CTRL-N` (next) om een recentere lijn uit de history te tonen

Let wel op als je eerder **multi-line** queries hebt ingegeven! B.v.

```
sqlite> SELECT "hallo"
   ...> || " daar!"
   ...> ;
hallo daar!
```

In je line-history staan nu immers 3 verschillende regels dus je moet zeker terug naar het begin v.d. query gaan!


