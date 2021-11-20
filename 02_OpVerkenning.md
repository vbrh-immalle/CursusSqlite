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

- type `select` + `<enter>`
- type nogmaals `<enter>`
- type `3` + `<enter>`
- druk nogmaals 2 keer op `<enter>`
- type `;` + `<enter>`

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
   ...> 534
   ...> xyz
   ...> oeioei;
Error: near "blabla": syntax error
sqlite>
```

Dan krijg je letterlijk een **syntax error** die je pas te zien krijgt als je `;` hebt getypt!

> Let er dus steeds op of de prompt `sqlite>` of `   ...>` bevat. De laatste prompt betekent dat er meer invoer verwacht wordt. De query wordt pas uitgevoerd na de `;`.

## Oefening 02.03: nog enkele SELECT-queries

Probeer deze queries. Ze geven verschillende *types* (`int`, `string`, ...) van waardes terug. Sommige van deze queries doen zelfs een berekening!

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
SELECT 'hallo' || ' joske';
```

Je kan een aantal dingen vaststellen over SQLite, nl.

- de symbolen voor optellen (`+`), vermenigvuldigen (`*`) en delen (`/`)
- het symbool om 2 strings aan elkaar te plakken (`||`)
- strings mogen zowel single (`'`) als double (`"`) quotes gebruiken (verkies echter single quotes voor compatibiliteit met andere SQL-implementaties)
- wanneer 1 van de 2 getallen in een wiskundige operatie een komma-getal is, is het resultaat ook een komma-getal

## Oefening 02.04: door de history scrollen

De interactieve CLI-tool `sqlite3` is zeer goed geschikt om queries uit te testen. Je zal dus vaak fouten maken en deze willen corrigeren. Je moet dan niet altijd de hele regel opnieuw typen.

Type in `sqlite>`:

```
SELECT 3 + 5;
```

Je krijgt het antwoord (`8`) te zien.

Druk nu op de **pijltjestoets naar boven**. Vervolgens kan je met de pijltjestoetsen links en rechts de regel code bewerken en met `ENTER` weer uitvoeren.

Probeer volgende snelkoppelingen tijdens het bewerken van een regel:

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

In je line-history staan nu immers 3 verschillende regels dus let hiermee op als je naar een eerdere multi-line-query terug gaat!

> Omdat de geschiedenis iets moeilijker is om mee te werken bij multi-line queries, zal je waarschijnlijk meestal query's uittesten op 1 regel. Pas als de query 'klaar' is, zal je deze opslaan in een `.sql`-bestand en voor de code een mooiere syntax op verschillende regels gebruiken. (Zie later als je `.sql`-scripts zult aanmaken en uitvoeren!)

## Oefening 02.05: Mooiere uitvoer van query-resultaten

Probeer deze query:

```
SELECT "Joske" as Naam, 16 AS Leeftijd;
```

Waarschijnlijk krijg je deze uitvoer:

```
Joske|16
```

Dit kunnen we mooier maken.

> Deze uitvoer stelt eigenlijk een tabel voor met 2 kolommen (`Naam` en `Leeftijd`) en 1 rij gegevens. Later zullen we nog veel resultaten van queries in tabelvorm weergeven! Daarom wil je nu eerst even oefenen en experimenteren met de verschillende manieren om de resultaten van queries op verschillende manieren weer te geven.

Met dot-commando's kunnen we de uitvoer van het `sqlite3`-tooltje configureren.

Toon de huidige uitvoer-modus:

```
.mode
```

Toon de mogelijke uitvoer-modi:

```
.help mode
```

Verander de uitvoer-modus naar `box` of `table`:

```
.mode box
.mode table
```

Voer de query opnieuw uit!

```
SELECT "Joske" as Naam, 16 AS Leeftijd;
```

De uitvoer zou er nu zo uit moeten zien:

```
sqlite> SELECT "Joske" as Naam, 16 AS Leeftijd;
+-------+----------+
| Naam  | Leeftijd |
+-------+----------+
| Joske | 16       |
+-------+----------+
sqlite>
```

> Merk op dat de **dot-commando's** **GEEN** `;` op het einde hebben. Enkel SQL-code moet je afsluiten met een `;`.

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

```
Naam,Leeftijd
Joske,16
```

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

```
.separator COL ?ROW?     Change the column and row separators
```

Hiermee kunnen we zowel tussen de **kolommen** als tussen de **rijen** een ander scheidingsteken kiezen. Het scheidingstekens voor nieuwe rijen laten we best op *een nieuwe regel* staan. (De vraagtekens van `?ROW?` in de helptekst betekenen dat dit een optioneel argument voor het `.separator`-commando is.)

Wij hebben dus voldoende aan enkel het instellen van het kolom-scheidingsteken: `COL` (en we geven dus niets mee voor `?ROW?`):

```
.sep ';'
SELECT "Joske" as Naam, 16 AS Leeftijd;
.sep '-'
SELECT "Joske" as Naam, 16 AS Leeftijd;
```

Je ziet dus dat je `sqlite3` kan gebruiken om data op te maken in verschillende CSV-varianten!

## Oefening 02.07: Een eerste tabel

SQL is een taal om met relationele databanken te werken.
Relationele databanken slaan informatie op in tabellen.

Met dit dotcommando kunnen we alle huidige tabellen weergeven:

```
.tables
```

Momenteel zijn er waarschijnlijk geen tabellen dus krijg je niets terug.

Laten we dus een tabel maken!

Kopieer deze SQL-code en plak ze in ze in de `sqlite>`-prompt (of type over):

```
CREATE TABLE Student(
   Name TEXT,
   Age INTEGER
);
```
Nu zou deze tabel wel gekend moeten zijn:

```
.tables
```

Laten we nu alle rijen uit deze tabel opvragen:

```
SELECT * FROM Student;
```

Er zijn echter nog geen **rijen** aanwezig in deze tabel, dus krijgen we weer niets terug.

Laten we dus 2 rijen toevoegen:

```
INSERT INTO Student(Name, Age) VALUES('Joske', 16);
INSERT INTO Student(Name, Age) VALUES('Mieke', 15);
```

> Zet de modus liefst op iets moois, zoals `.mode box` of `.mode table`.

Wanneer we nu deze query uitvoeren, zien we de 2 rijen!

```
SELECT * FROM Student;
```

We hebben nu dus:

- een databank met 1 tabel: `Student`
- de tabel `Student` heeft 2 kolommen:
    - `Name` van type `TEXT`
    - `Age` van type `INTEGER`
- de tabel heeft 2 rijen (of *records*), nl de 2 leerlingen: *Joske* en *Mieke*

Deze databank zit nu in het RAM-geheugen (de *transient in-memory database* die `sqlite3` bij het opstarten vermeldt). Als we `sqlite3` afsluiten, zijn we de gegevens (en het *schema*) dus weer kwijt!

We zullen in het volgende hoofdstuk zien hoe we kunnen werken met databases op schijf (*persistent databases*) en hoe we `.sql`-scripts kunnen uitvoeren zodat we niet steeds onze SQL-code kwijt zijn.

## Oefening 02.08: Kolommen hernoemen met SELECT ... AS ...

In deze cursus gebruiken we voor tabel- en kolomnamen steeds Engelse woorden.

> Het idee hierachter is dat onze code misschien door internationale programmeurs zal moeten worden aangepast.

Stel dat we gegevens uit de databank willen opvragen voor Nederlandstalige gebruikers. Het kan dan interessant zijn om de kolomnamen te vertalen.

Laten we dit stapsgewijs doen...

Normaal vraag je alle kolommen van een tabel gemakkelijk op met het `*`-jokerteken.

```
SELECT * FROM Student;
```

Maar nu zullen we eerst expliciet elke kolom moeten vermelden:

```
SELECT Name, Age FROM Student;
```

De uitvoer ziet er hetzelfde uit als met de vorige query (in het geval van `.mode table`):

```
+-------+-----+
| Name  | Age |
+-------+-----+
| Joske | 16  |
| Mieke | 15  |
+-------+-----+
```

Nu kunnen we pas de kolomnamen anders weergeven, b.v. voor een Nederlandse vertaling. We gebruiken het SQL-sleutelwoord `AS`:

```
SELECT Name AS Naam, Age AS Leeftijd FROM Student;
```

Zo zou dit er uit moeten zien:

```
+-------+----------+
| Naam  | Leeftijd |
+-------+----------+
| Joske | 16       |
| Mieke | 15       |
+-------+----------+
```

> Merk op dat de kolomnamen v.d. oorspronkelijk tabel **niet** veranderd zijn! Dit kan je controleren door opnieuw `SELECT * FROM Student;` uit te voeren.
> We zouden dit *kunnen* doen met de `ALTER TABLE`-opdracht maar deze SQL-opdracht zullen we in deze cursus niet gebruiken. Dat zou bovendien strijdig zijn met ons principe dat we het design van de database ook toegankelijk willen maken voor anderstalige ontwikkelaars. (De gegevens in de rijen kunnen natuurlijk wel gewoon in het Nederlands.)

## Oefening 02.09: Over schema's en de TAB-toets

Wanneer we kolomnamen moeten opgeven achter `SELECT`, is het wel zo handig als we de kolomnamen kennen zodat we weten wat te typen.

> Wanneer we `.sql`-scripts schrijven, is dit probleem niet zo groot omdat we dan het ganse script hebben om naar terug te kijken.

Met dit commando krijg je het **schema** van de tabel `Student` te zien:

```
.schema Student
```

Je kan ook het schema van de ganse database opvragen maar dat zal nu hetzelfde geven aangezien we maar 1 tabel hebben.

```
.schema
```

> Eigenlijk zijn deze "schema's" gewoon de `CREATE TABLE`-code die we eerder ingaven.
> Hierin kunnen we de kolomnamen aflezen!

Denk er aan dat je alle tabellen kan opvragen met

```
.tables
```

> Met het `.schema`-commando kunnen we dus kolomnamen opzoeken voor we een query beginnen typen!

De `sqlite3`-tool ondersteunt ook de `<TAB>`-toets. Op elk moment kan je op `<TAB>` drukken en dan zal je enkele mogelijke aanvullingen voorgesteld krijgen. Er wordt hiervoor ook gezocht in alle kolomnamen van alle tabellen dus dit kan ook een goede hulp zijn!

Probeer volgende zaken te typen:

- `SEL<TAB>` (dit wordt aangevuld naar `SELECT`, tenzij je zelf iets gedefinieerd hebt dat met `SEL` begint)
- `SELECT Nam<TAB>` (dit wordt aangevuld naar `Name` omdat deze kolom ontdekt is in de `Student`-tabel)
- `SELECT Name FR<TAB>` (dit wordt aangevuld met `FROM` omdat dit ook een bekend SQL-woord is)
- `SELECT NAME FROM St<TAB>` (dit wordt aangevuld met `Student` omdat deze tabelnaam bekend is)

Zo kan je dus misschien sneller deze query typen:

```
SELECT Name FROM Student ;
```

Als je `<TAB>` drukt en er niet ondubbelzinnig kan vastgesteld worden wat je bedoelt, zal je een piepsignaal horen. Als je vervolgens nogmaals op `<TAB>` drukt, zal getoond worden welke mogelijkheden er allemaal zijn en kan je dus aflezen wat je nog verder moet typen. B.v.

- `S<TAB><TAB>` (je nog kiezen uit o.a. `SELECT`, `SET`, `Student` dus type verder en druk weer TAB tot je het woord hebt dat je moet hebben)

> TIP: Je hoeft je niet te beperken tot 1 terminal! Je kan `sqlite3` in 2 verschillende vensters openen en 1 venster gebruiken om dingen op te zoeken en het andere om je queries te testen!

## Oefening 02.10: Tabellen verwijderen (en weer opnieuw creëren)

Toon alle aanwezige tabellen:

```
.tables
```

Zelfs als de tabel `Student` al bestaat, kan je proberen deze opnieuw te maken:

```
CREATE TABLE Student(
   Name TEXT,
   Age INTEGER
);
```

Je krijgt dan de foutmelding:

```
Error: table Student already exists
```

In `.sql`-scripts zullen we daarom soms `IF NOT EXISTS` toevoegen aan `CREATE TABLE`.

Deze code zou je meerdere keren achter elkaar moeten kunnen uitvoeren zonder foutmeldingen of data-verlies:

```
CREATE TABLE IF NOT EXISTS Student(
   Name TEXT,
   Age INTEGER
);
```

Tabellen verwijderen kan met `DROP TABLE`.

Verwijder de tabel `Student`:

```
DROP TABLE Student;
```

Controleer of de tabel echt weg is:

```
.tables
```

Als je dit nogmaals probeert te doen, krijg je deze foutmelding:

```
Error: no such table: Student
```

Daarom kunnen we ook hier iets toevoegen: `IF EXISTS`.

```
DROP TABLE IF EXISTS Student;
```

Deze code kan je opnieuw meerdere malen uitvoeren zonder foutmeldingen te krijgen.
Het eindresultaat zal altijd zijn dat de ganse tabel (en alle gegevens!) verwijderd zijn.

> Voorlopig spelen we nog in de **transient in-memory database** ("zandbak") dus zouden alle tabellen ook weg zijn als we `.quit`'n (en `sqlite3` opnieuw opstarten).

> Je moet de `CREATE TABLE`- en `DROP TABLE`-commando's niet zelf kunnen schrijven maar je zal ze wel tegenkomen in opgaves of `.sql`-scripts dus is het belangrijk dat je begrijpt wat er gebeurt:
> - `DROP TABLE IF EXISTS Student` verwijdert de ganse tabel, dus zowel de schema-definitie als alle rijen
> - `CREATE TABLE IF NOT EXISTS` laat een bestaande tabel gewoon staan en deze zal dus de bestaande data blijven behouden

## Oefening 02.11: Kolommen meerdere keren gebruiken

Om dit hoofdstuk af te sluiten, willen we je blik op wat SQL kan nog even verruimen.

Wat denk je b.v. van deze query?

```
SELECT Name      AS Naam,
       Age       AS Leeftijd,
       100 - Age AS 'Hoeveel jaar tot 100?'
  FROM Student;
```

Copy/paste deze code in de voorgaande database om uit te proberen!

> Merk op dat het eigenlijk geen goed idee is om een leeftijd op te slaan als een vast getal. (Dit verandert namelijk elk jaar!)
> We zullen in volgende hoofdstukken **datums** en **tijdstippen** tegenkomen.

Enkele vaststellingen:

- het query-resultaat heeft 3 kolommen terwijl de oorspronkelijke tabel maar 2 kolommen heeft
   - We gebruiken de kolom `Age` 2 keer!
- een kolomnaam met spaties KAN als we `'` gebruiken (maar is meestal niet zo'n goed idee)

# Conclusie

Je hebt in dit hoofdstuk kennis gemaakt met de `sqlite3`-tool.

Je weet dat `sqlite3` vanaf Powershell (`PS>`-prompt) kan opstarten:

- `sqlite3` start een nieuwe sqlite-sessie met een database in het RAM-geheugen
- `sqlite3 -help` toont je een overzicht van alle mogelijke argumenten (waarvan we er enkele zullen gebruiken in het volgende hoofdstuk)

Je kent ook een aantal nuttige dot-commando's:

- `.help` toont je alle dot-commando's met een uitleg
- `.help mode` geeft je alleen de uitleg van het `.mode`-commando
- `.mode box` en `.mode table` maken de uitvoer duidelijker leesbaar en tonen kolomnamen
- `.mode csv` en `.header on` zorgt voor CSV-output met hoofdingen
- `.quit` verlaat `sqlite3`

Je weet nu ook dat bepaalde toetsen(combinaties) (zoals `TAB` of de pijltjestoetsen) nuttig zijn bij het ingeven van nieuwe commando's of het bewerken van eerdere commando's.

Je hebt enkele SQL-commando's tegengekomen:

- `SELECT ... FROM ...;`
- `SELECT ... AS ...;` 
- `CREATE TABLE`
- `DROP TABLE`
- `INSERT INTO ...` (om rijen toe te voegen aan een tabel)

> Merk op dat je enkel de `SELECT`-queries zelf moet leren schrijven.
> Overige SQL-commando's mag je steeds opzoeken of hoef je enkel aan te passen.
> Voor de dot-commando's kan je natuurlijk altijd `.help` raadplegen!
