- [Hoofdstuk 04: Select-queries met 1 tabel](#hoofdstuk-04-select-queries-met-1-tabel)
  - [Inleiding](#inleiding)
    - [Alle rijen](#alle-rijen)
    - [Rijen filteren](#rijen-filteren)
    - [Volgorde bepalen](#volgorde-bepalen)
    - [Slechts een gedeelte van de rijen opvragen](#slechts-een-gedeelte-van-de-rijen-opvragen)
  - [Oefening 04.01: Chinook verkennen](#oefening-0401-chinook-verkennen)
  - [Oefening 04.02: Alle klanten uit België](#oefening-0402-alle-klanten-uit-belgië)
  - [Oefening 04.03: Alle artiesten die beginnen met de letter C](#oefening-0403-alle-artiesten-die-beginnen-met-de-letter-c)
  - [Oefening 04.04: Alle albums die een getal in hun titel hebben](#oefening-0404-alle-albums-die-een-getal-in-hun-titel-hebben)
  - [Oefening 04.05: Alle albums die uit meer dan 1 CD bestaan](#oefening-0405-alle-albums-die-uit-meer-dan-1-cd-bestaan)

# Hoofdstuk 04: Select-queries met 1 tabel


## Inleiding

Algemeen ziet een query met 1 tabel er zo uit:

```
   SELECT      kolom1, kolom2
     FROM      tabel1
    WHERE      voorwaarden
 ORDER BY      kolom3       ASC/DESC
    LIMIT      max_aantal   OFFSET      offset_getal;
```
 
### Alle rijen

Dit toont simpelweg **alle** rijen uit de tabel:

```
SELECT kolom1, kolom2
  FROM tabel1
```

### Rijen filteren

Met `WHERE` kunnen voorwaarden toegevoegd worden waaraan rijen moeten voldoen om
getoond te worden.

```
   WHERE kolom1 = 'een_string'
   WHERE kolom2 = 14     AND     kolom1 = 'een_string'
   WHERE kolom2 = 123
```

Een voorwaarde is steeds een **booleaanse expressie** dus iets dat `true` of
`false` is.

Met de Booleaanse operatoren `AND` en `OR` kunnen we verschillende expressies
aan elkaar koppelen.

Expressies hangen af van het datatype van elke kolom. Als de kolom een **getal** is
kunnen we b.v. **wiskundige vergelijksoperatoren** gebruiken, zoals:

- groter dan: `WHERE kolom2 > 10`
- kleiner dan: `WHERE kolom2 < 10`
- groter of gelijk aan: `WHERE kolom2 >= 10`
- kleiner of gelijk aan: `WHERE kolom2 <= 10`
- gelijk aan: `WHERE kolom2 = 10` (Opgelet: geen dubbele `==`!)

Wanneer de een kolom v.h. type **string** is kunnen we b.v. volgende
vergelijkingensexpressies gebruiken:

- gelijk aan: `WHERE kolom1 = 'abc'`
- begint met hoofdletter A: `WHERE kolom1 LIKE 'A%'`
- eindigt met een A: `WHERE kolom1 LIKE '%A'`
- bevat een A: `WHERE kolom1 LIKE '%A%'`

> De `LIKE`-operator is een interessante operator waarbij we dankzij het
> **jokerteken `%`** interessante zoekopdrachten voor `string`-/tekstkolommen kunnen
> schrijven. 

### Volgorde bepalen

De standaard volgorde v.d. rijen hangt af van in welke volgorde de rijen
oorspronkelijk met `INSERT INTO` werden toegevoegd.

Meestal willen we zelf de volgorde kiezen.

```
 ORDER BY kolom1
 ORDER BY kolom1 DESC
 ORDER BY kolom1 DESC, kolom2
 ORDER BY kolom1 DESC, kolom2 DESC
```

Per kolom kan gekozen worden of de sortering van klein naar groot of omgekeerd
moet gebeuren.

`ASC`: ascending of oplopend (de standaard-instelling die daarom mag weggelaten
worden)

`DESC`: descending of aflopend

### Slechts een gedeelte van de rijen opvragen

*pagination*

```
  LIMIT 10
  LIMIT 10 OFFSET 10
  LIMIT 10 OFFSET 20
```

Met `LIMIT 10` tonen we enkel de eerste 10 resultaten (denk eraan dat we met
`ORDER BY` de volgorde bepalen!).

Met `OFFSET 10` zeggen we dat we moeten beginnen met de 10e rij.

`LIMIT 10 OFFSET 20` toont dus 10 resultaten, beginnende vanaf de 20e rij.

## Oefening 04.01: Chinook verkennen

`dbs/Chinook.sqlite3` is een database van een fictieve online muziekwinkel waar
muziek-albums van verschillende artiesten in allerlei muziek-genres kunnen
gedownload worden.

Open de database b.v. met `sqlite3 dbs/chinook.sqlite3`.

Kijk nu welke tabellen aanwezig zijn met `.tables`.

Je zou deze 11 tabellen moeten tegenkomen:

1. Album
2. Artist
3. Customer
4. Employee
5. Genre
6. Invoice
7. InvoiceLine
8. MediaType
9. Playlist
10. PlaylistTrack
11. Track

We kunnen van elke tabel het schema bekijken en vervolgens naar alle (of enkele) rijen kijken.

> TIP: zorg voor mooiere output met `.mode box`!

```
.schema Album
SELECT * FROM Album;
SELECT * FROM Album LIMIT 10;
```

Wanneer je de gegevens van alle tabellen even bekeken hebt, kan je dus vaststellen dat:

- er werknemers (`Employee`) zijn 
- er klanten (`Customer`) zijn
- klanten soms albums (`Album`) kopen dewelke worden opgeslagen in facturen (`Invoice`) en
  elke factuur kan bestaan bestaan uit meerdere aankopen (`InvoiceLine`) 
- er verschillende bestandsformaten (`MediaType`) kunnen gedownload worden 
- er uiteraard albums zijn (`Album`) waarop verschillende nummers staan
  (`Track`) en die door een bepaalde artiest (`Artist`) zijn gemaakt
- Elk nummer (`Track`) in een bepaalde muziekstijl (`Genre`) is gemaakt
- Elk nummer (`Track`) apart kan gekocht worden want er is per nummer een
  (eenheids)prijs in de tabel terug te vinden.
- De website van de muziekwinkel ook afspeellijsten (`Playlist`) bevat waar
  klanten vermoedelijk inspiratie kunnen opdoen voor hun aankopen.
- Elke afspeellijst (`Playlist`) een naam heeft en uiteraard uit verschillende
  nummers (`PlaylistTrack`) kan bestaan.

## Oefening 04.02: Alle klanten uit België

> TIP: Met `.schema Customer` kan je de naam v.d. velden achterhalen. Of je kan
> natuurlijk gewoon `SELECT * FROM Customer LIMIT 10` doen als de output zo
> ingesteld is dat ook de headers worden getoond. Controleer `.headers` of
> gebruik gewoon `.mode box` en alles staat meteen duidelijk.

```
SELECT *
  FROM Customer
 WHERE Country = "Belgium";
```

Toon nu enkele belangrijke kolommen (maar niet allemaal) en voorzie de
kolomnamen van een Nederlandse vertaling.

## Oefening 04.03: Alle artiesten die beginnen met de letter C

```
SELECT *
  FROM Artist
 WHERE Name LIKE 'C%';
```

## Oefening 04.04: Alle albums die een getal in hun titel hebben

Denk eraan dat het getal dat voorkomt in de titel een onderdeel v.d. tekst is.
We kunnen dus niet zomaar wiskundige operaties gaan uitvoeren en moeten de
getallen eigenlijk als *karakters* beschouwen.

```
SELECT *
  FROM Album
 WHERE 
         Title LIKE '%1%' OR
         Title LIKE '%0%' OR
         Title LIKE '%2%' OR
         Title LIKE '%3%' OR
         Title LIKE '%4%' OR
         Title LIKE '%5%' OR
         Title LIKE '%6%' OR
         Title LIKE '%7%' OR
         Title LIKE '%8%' OR
         Title LIKE '%9%'; 
```

## Oefening 04.05: Alle albums die uit meer dan 1 CD bestaan

We kunnen dit proberen te bekomen door in de titel te zoeken naar bepaalde
woorden die voorkomen maar helemaal waterdicht is deze query natuurlijk niet!

```
SELECT *
  FROM Album
 WHERE Title LIKE '%Disc%' OR Title LIKE '%CD%';
```
