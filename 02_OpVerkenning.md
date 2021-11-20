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

   SQLite version 3.37.0 2021-09-28 10:44:54
   Enter ".help" for usage hints.
   Connected to a transient in-memory database.
   Use ".open FILENAME" to reopen on a persistent database.
   sqlite>

## Oefening 02.01: .quit

Verlaat de sqlite-CLI-tool. In `sqlite>`:

```
.quit
```

Start de tool daarna weer op. In `PS>`:

```
sqlite3
```

## Oefening 02.02: een eerste query en multi-line input

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

   sqlite> select
      ...>
      ...> 3
      ...>
      ...>
      ...> ;
   3
   sqlite>

Je krijg dus pas de `sqlite>`-prompt terug als je een **query** hebt afgesloten met `;`!

Wat gebeurt er als je **onzin** typt (of fouten maakt tegen de syntax van SQL)?

   sqlite> blabla
   blabla
      ...> 534
      ...> xyz
      ...> oeioei;
   Error: near "blabla": syntax error
   sqlite>

Dan krijg je letterlijk een **syntax error** die je pas te zien krijgt als je `;` hebt getypt!

## Oefening 02.03: nog enkele SELECT-queries

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

## Oefening 02.04: door de history scrollen

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

   sqlite> SELECT "hallo"
      ...> || " daar!"
      ...> ;
   hallo daar!

In je line-history staan nu immers 3 verschillende regels dus je moet zeker terug naar het begin v.d. query gaan!

## Oefening 02.05: Mooiere uitvoer van query-resultaten

Probeer deze query:

```
SELECT "Joske" as Naam, 16 AS Leeftijd;
```

Waarschijnlijk krijg je deze uitvoer:

   Joske|16

Dit kunnen we mooier maken.

> Deze uitvoer stelt eigenlijk een tabel voor met 2 kolommen (`Naam` en `Leeftijd`) en 1 rij gegevens. Later zullen we nog veel resultaten van queries in tabellen weergeven! Daarom willen we de uitvoer nu zo duidelijk mogelijk maken.

Met dot-commando's kunnen we de uitvoer van het `sqlite3`-tooltje configureren.

Toon de huidige uitvoer-modus:

```
.mode
```

Toon de mogelijke uitvoer-modi:

```
.help mode
```

Verander de uitvoer-modus naar `box` of `ascii`:

```
.mode box
.mode table
```

Voer de query opnieuw uit!

```
SELECT "Joske" as Naam, 16 AS Leeftijd;
```

De uitvoer zou er nu zo uit moeten zien:

   sqlite> SELECT "Joske" as Naam, 16 AS Leeftijd;
   +-------+----------+
   | Naam  | Leeftijd |
   +-------+----------+
   | Joske | 16       |
   +-------+----------+
   sqlite>


## Oefening 02.06: CSV-uitvoer met of zonder headers

`sqlite3` kan met CSV-bestanden (Comma-Separated-Value) werken. Dit maakt het een zeer krachtig tooltje om data uit te wisselen met andere programma's (b.v. Excel).

Zet de `.mode` op csv:

```
.mode csv
```

Probeer opnieuw de query uit de vorige oefening:

```
SELECT "Joske" as Naam, 16 AS Leeftijd;
```

Je krijgt nu 1 rij gegevens te zien, gescheiden door een komma.

Meestal willen we ook de kolomnamen weergeven. Dit kan met header dot-commando `.headers`. Controleer de help hiervan met

```
.headers
```

of

```
.help headers
```

 Zet de hoofdingen van de kolomnamen aan:

```
.headers on
```

En probeer opnieuw de query:

```
SELECT "Joske" as Naam, 16 AS Leeftijd;
```

Je zou nu deze uitvoer moeten krijgen:

   Naam,Leeftijd
   Joske,16

Desgewenst kan het tonen v.d. hoofdingen weer afgezet worden met

```
.headers off
```

Soms willen we een ander scheidingsteken dan een `,`. Bekijk de mogelijkheden van het `.separator`-dot-commando:

```
.separator
.help separator
.sep
.help sep
```

> Je kan de dot-commando's afkorten!

Je ziet volgende helptekst:

   .separator COL ?ROW?     Change the column and row separators


De vraagtekens rond `ROW` wil zeggen dat we optioneel een ander scheidingsteken voor elke rij willen. Wij zullen echter voldoende hebben met enkel het instellen van het kolom-scheidingsteken: `COL` (en we geven dus niets mee voor `?ROW?`):

```
.sep ';'
SELECT "Joske" as Naam, 16 AS Leeftijd;
.sep '-'
SELECT "Joske" as Naam, 16 AS Leeftijd;
```
