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
  - [Oefening 04.06: Alle mediatypes van het type AAC](#oefening-0406-alle-mediatypes-van-het-type-aac)
  - [Oefening 04.07: Alle facturen voor België](#oefening-0407-alle-facturen-voor-belgië)
  - [Oefening 04.08: Alle werknemers die vóór 2004 zijn aangenomen](#oefening-0408-alle-werknemers-die-vóór-2004-zijn-aangenomen)
  - [Oefening 04.09: Alle nummers die groter dan zijn 580 MB](#oefening-0409-alle-nummers-die-groter-dan-zijn-580-mb)
  - [Oefening 04.10: Alle playlists waar NIET `Music` in de naam voorkomt](#oefening-0410-alle-playlists-waar-niet-music-in-de-naam-voorkomt)
  - [Oefening 04.11: Een aantal PlaylistTrack's](#oefening-0411-een-aantal-playlisttracks)

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

Soms is het gebruik van `BETWEEN` of `NOT BETWEEN` handig.
B.v. een getal van 2 t.e.m. 8 kan je op volgende manieren schrijven:

- `WHERE getal >= 2 AND getal <= 8`
- `WHERE getal BETWEEN 2 AND 8`

Een getal kleiner dan 2 of groter dan 9:

- `WHERE getal < 2 OR getal > 9`
- `WHERE getal NOT BETWEEN 2 AND 9`

Probeer zelf met [sql/between.sql](sql/between.sql).

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

Zie [sql/oef04/02.sql](sql/oef04/02.sql).

> TIP: Met `.schema Customer` kan je de naam v.d. velden achterhalen. Of je kan
> natuurlijk gewoon `SELECT * FROM Customer LIMIT 10` doen als de output zo
> ingesteld is dat ook de headers worden getoond. Controleer `.headers` of
> gebruik gewoon `.mode box` en alles staat meteen duidelijk.

Toon nu enkele belangrijke kolommen (maar niet allemaal) en voorzie de
kolomnamen van een Nederlandse vertaling. Zorg dat zowel Belgische als
Nederlandse klanten zichtbaar zijn.

Zie [sql/oef04/02b.sql](sql/oef04/02b.sql).

## Oefening 04.03: Alle artiesten die beginnen met de letter C

Zie [sql/oef04/03.sql](sql/oef04/03.sql).

## Oefening 04.04: Alle albums die een getal in hun titel hebben

Denk eraan dat het getal dat voorkomt in de titel een onderdeel v.d. tekst is.
We kunnen dus niet zomaar wiskundige operaties gaan uitvoeren en moeten de
getallen eigenlijk als *karakters* beschouwen.

Zie [sql/oef04/04.sql](sql/oef04/04.sql).

## Oefening 04.05: Alle albums die uit meer dan 1 CD bestaan

Zie [sql/oef04/05.sql](sql/oef04/05.sql).

We kunnen dit proberen te bekomen door in de titel te zoeken naar bepaalde
woorden die voorkomen maar helemaal waterdicht is deze query natuurlijk niet!

## Oefening 04.06: Alle mediatypes van het type AAC

De downloadbare muziekbestanden in de Chinook-database zijn allen geëncodeerd
met een bepaalde encoding. In de tabel `MediaTypes` worden alle gebruikte
mediatypes opgesomd en in de tabel `Track` wordt in een kolom `MediaTypeId`
aangeduidt welke encoding een bepaalde track heeft.

Controleer eerst *alle* media-types en schrijf vervolgens de query om enkel
diegenen te tonen die een variant van `AAC` te zijn.

Zie [sql/oef04/06.sql](sql/oef04/06.sql).

> AAC: Advanced Audio Coding (opvolger van MP3)
> MPEG / MP3 / MP4: codec van de *Moving Pictures Expert Group*

> Een (audio/video-)codec is een coder/decoder-algoritme dat muziek of video op
> een bepaalde manier codeert, meestal met de bedoeling zodat het minder plaats
> inneemt op schijf en dus ook minder bandbreedte vereist om te streamen.

## Oefening 04.07: Alle facturen voor België

Hoewel in de tabel `Customer` al het adres aanwezig is, wordt voor elke factuur
(`Invoice`) toch ook nog apart het `BillingAddress` bijgehouden.

Kijk b.v. naar klant 8:

```
SELECT *
  FROM Customer
 WHERE CustomerId = 8
;
```

Toon nu alle facturen die bestemd zijn voor `Belgium`. (Je zal trouwens zien dat
niet alle facturen van klant nummer 8 zijn.)

Zie [sql/oef04/07.sql](sql/oef04/07.sql).

## Oefening 04.08: Alle werknemers die vóór 2004 zijn aangenomen

Controleer met `.schema Employee` het type van deze velden:

- `BirthDate`
- `HireDate`

Je zal zien dat dit `DATETIME` is.

Voor kolommen van dit type, kunnen we de `BETWEEN`-operator gebruiken. We moeten
dus een voldoende kleine start-datum kiezen (b.v. `1900-01-01`).

Beschouw datums steeds als tekst-strings (zo wordt het eigenlijk ook opgeslagen
in SQLite) en gebruik dus single (`'`) of double (`"`) quotes, b.v.
`'1900-01-01'` of `"1900-01-01"`.

Laat nu enkele belangrijke velden zien van alle werknemers die zijn aangenomen
voor 2004.

Zie [sql/oef04/08.sql](sql/oef04/08.sql).

> Datums en tijden zijn in SQLite maar beperkt ondersteund. Toch zijn er enkele
> hulp-functies waar je al wel wat mee kan:
> https://www.sqlite.org/lang_datefunc.html. 
>
> Andere databases zoals PostgreSQL hebben hiervoor veel uitgebreidere
> mogelijkheden, zie b.v.
> https://www.postgresql.org/docs/current/datatype-datetime.html


## Oefening 04.09: Alle nummers die groter dan zijn 580 MB

Om grote getallen voor te stellen, kunnen we de `e`-notatie gebruiken.
B.v. `580000000` is duidelijker leesbaar als `580e6`.

> Gebruik:
> - `e3` voor kilo
> - `e6` voor mega
> - `e9` voor giga
> - `e12` voor tera
> - ...

Schrijf die query die alle nummers (`Track`) toont met een bestandsgrootte hoger
dan 580 MB.

Zie [sql/oef04/09.sql](sql/oef04/09.sql).

> Denk aan het verschil tussen kilo en kibi, mega en mebi, ...
> - MB: MEGA-byte (veelvoud van 10)
> - MiB: MEBI-byte (veelvoud van 2) (b.v. 2 MiB: `2*1024*1024`)
> - ...

## Oefening 04.10: Alle playlists waar NIET `Music` in de naam voorkomt

Zie [sql/oef04/10.sql](sql/oef04/10.sql).

## Oefening 04.11: Een aantal PlaylistTrack's

`PlaylistTrack` is een speciale tabel die eigenlijk een **veel-op-veel-relatie**
voorstelt. Later meer hierover...

Voor nu willen we een query die alle rijen toont waarvan het `PlaylistId`
kleiner is dan 10 en tegelijkertijd het `TrackId` groter is dan 3500.

Zie [sql/oef04/11.sql](sql/oef04/11.sql).
