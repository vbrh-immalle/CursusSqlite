- [Hoofdstuk 05: Select-queries met meerdere tabellen in een 1-op-veel-relatie](#hoofdstuk-05-select-queries-met-meerdere-tabellen-in-een-1-op-veel-relatie)
  - [Inleiding](#inleiding)
  - [Oefening 05.01: de entiteiten `Album` en `Artist`](#oefening-0501-de-entiteiten-album-en-artist)
  - [Oefening 05.01: Laat de eerste 10 albums zien samen met de artiest](#oefening-0501-laat-de-eerste-10-albums-zien-samen-met-de-artiest)
  - [Oefening 05.02: De vertegenwoordiger van elke klant](#oefening-0502-de-vertegenwoordiger-van-elke-klant)

# Hoofdstuk 05: Select-queries met meerdere tabellen in een 1-op-veel-relatie

## Inleiding

Uit het vorige hoofdstuk moet duidelijk geworden zijn dat we voor het opvragen
van de meest nuttige informatie verschillende tabellen zullen moeten
**combineren**. Dit kan met **`JOIN`**'s.

Denk b.v. aan volgende situaties:

- Een klant wil op de website een overzicht tonen van zijn facturen
- Elke klant is toegewezen aan één werknemer die de klant vertegenwoordigd
  (representeert, *rep*). Wanneer een klant dus b.v. vragen heeft over een
  factuur, kan hij terecht bij deze vertegenwoordiger van de muziekwinkel. Een
  vertegenwoordiger zou dus b.v. een lijst kunnen opvragen van alle klanten waar
  hij verantwoordelijk voor is.
- Een album bestaat uit meerdere tracks. Elke track heeft een bepaalde lengte
  (uitgedrukt in milli-seconden). We zouden van elk album dus een tracklijst
  kunnen opvragen met de lengte van elke track. (In een volgend hoofdstuk zullen
  we zelfs query schrijven waarmee we ook de totale afspeeltijd van een album
  kunnen berekenen.)
- Een artiest heeft misschien meerdere albums gemaakt. We zouden een lijst
  kunnen opvragen van alle albums van een bepaalde artiest.
- ...

In het algemeen kunnen we zeggen dat een database bestaat uit:

- **entiteiten**
- **relaties**

Dit wordt schematisch voorgesteld met een **Entity-Relation**-diagramma
(ER-diagramma).

Op deze website kan je een ER-diagramma terugvinden v.d. Chinook-database:
https://www.sqlitetutorial.net/sqlite-sample-database/

> Uiteraard zou je ook zelf dit ER-diagramma kunnen tekenen, b.v. met
> https://app.diagrams.net/.

Elke **entiteit** moet op een unieke manier te bepalen zijn met een **PK**
(Primary Key = primaire sleutel).

Om een relatie te leggen tussen 2 entiteiten moeten we een **FK** (Foreign Key =
refererende sleutel) hebben die altijd verwijst naar een **PK van een andere
entiteit**.

De tabellen die deel uitmaken van een relatie kunnen we met een **`JOIN`** aan
elkaar plakken. We spreken steeds over een **linker**- (**LEFT**) en
**rechter**- (**RIGHT**) tabel.

Bij elke `JOIN` moeten we zeggen welke **FK** bij welke **PK** hoort! 

## Oefening 05.01: de entiteiten `Album` en `Artist`

We kijken eerst even naar enkele albums en artiesten:

```
SELECT * FROM Album LIMIT 3;
SELECT * FROM Artist LIMIT 3;
```

Er kan op een **unieke** manier gerefereerd worden naar de entiteiten:

- Elk album heeft een `AlbumId`.
- Elke artiest heeft een `ArtistId`.

Tussen deze 2 entiteiten is in de databank een **1-op-veel-relatie**
gedefinieerd:

- Elk album is steeds slechts van 1 artiest (in deze muziekwinkel komen dus geen
  verzamelalbums voor)
- Elke artiest kan meerdere albums gemaakt hebben.

In een ER-diagramma staat dus:

- de entiteit `Artist` aan de **1**-kant v.d. relatie
- de entiteit `Album` aan de **veel**-kant v.d. relatie

De informatie over de entiteit `Artist` vinden we terug in de tabel `Artist`. We
zien dat van de artiesten enkel de **naam** in deze tabel wordt bijgehouden.

De informatie over de entiteit `Album` vinden we terug in de tabel `Album`. In
de kolom `Title` wordt de titel van het album bijgehouden. De kolom `ArtistId`
is een kolom waarmee de relatie naar de artiest wordt gelegd.

> `ArtistId` is een **FK** die verwijst naar de **PK** van de tabel `Artist`!

Bij een 1-op-veel-relatie zullen we altijd zien dat de **FK** een kolom is in de
tabel v.d. entiteit die aan de **veel**-kant v.d. relatie staat.

Wanneer we een kolom tegenkomen die verwijst naar een **PK** van een andere
tabel, noemen we deze kolom **altijd** een **FK**.

> **Even vooruitblikken**: Als we in tabel een **FK** tegenkomen, weten we
> eigenlijk met zekerheid dat we te maken hebben met de **veel**-kant van een
> relatie. We zullen in een volgend hoofdstuk nog zien dat sommige **FK**'s deel
> uit maken van een **veel-op-veel-relatie**. Wanneer we in een tabel echter ook
> informatie zien over een entiteit (zoals hier bij het `Album` waarvan we in
> dezelfde tabel ook de `Title` terugvinden), is de kans groot dat deze entiteit
> (`Album`) deel uitmaakt van een **1-op-veel-relatie**.

Soms wordt in een database **expliciet** vermeld dat bepaalde velden PK's en
FK's zijn. Dit is uiteraard het beste want hoe meer de database weet over de
data, hoe beter de database-engine foutmeldingen kan geven als gebruikers op een
verkeerde manier zouden willen invoegen.

Kijk met volgende commando's naar de *schema-definities* v.d. 2 tabellen:

```
.schema Artist
.schema Album
```

Kan je uit de syntax v.d. `CREATE TABLE`-statements bepalen welke kolommen PK's
en FK's zijn?

> `.schema` toont ook zogenaamde `INDEX`'es die je op een tabel kan definiëren.
> **Je mag deze negeren!** Indexen zijn een manier om zoekopdrachten/queries in
> de databank sneller te maken. Dit speelt voor ons nu geen rol omdat we geen
> belang hechten aan de snelheid waarmee de queries worden uitgevoerd. Voor een
> echte muziekwinkel met zeer veel data, kunnen deze `INDEX`'s natuurlijk wel
> belangrijk worden. Men gaat dan meestal kijken welke queries het vaakst worden
> uitgevoerd (b.v. een zoekopdracht op basis v.d. *artiest* v.e. album) om te
> bepalen van welke kolommen er *index*es gemaakt kunnen worden op de database
> performanter te maken.

## Oefening 05.01: Laat de eerste 10 albums zien samen met de artiest 

De relatie tussen `Album` en `Artist` is een 1-op-veel-relatie die wordt gelegd
via de PK `Artist.ArtistId` en de FK `Album.ArtistId`.

> Omdat we onderscheid moeten maken tussen 2 kolommen met dezelfde naam
> (`ArtistId`), moeten we in de query ook de naam v.d. tabel gebruiken om de
> 2 kolommen uit de verschillende tabellen van elkaar te onderscheiden!

```
SELECT *
  FROM Album
  JOIN Artist
    ON Artist.ArtistId = Album.ArtistId
LIMIT 10;
```

Merk op dat als we de volgorde v.d. tabellen omdraaien (linkertabel: `Artist`),
we dezelfde rijen (in dezelfde volgorde) terugkrijgen maar dat de **kolommen** wel
in een andere **volgorde** staan: 

```
SELECT *
  FROM Artist
  JOIN Album
    ON Artist.ArtistId = Album.ArtistId
LIMIT 10;
```

Wanneer we bezorgd zijn over de **volgorde v.d. rijen**, is het altijd best om
een `ORDER BY`-statement toe te voegen:

```
SELECT *
  FROM Artist
  JOIN Album
    ON Artist.ArtistId = Album.ArtistId
ORDER BY Artist.Name
LIMIT 10;
```

We krijgen uiteraard andere rijen te zien als we sorteren op een andere kolom en
slechts de eerste 10 resultaten tonen:

```
SELECT *
  FROM Artist
  JOIN Album
    ON Artist.ArtistId = Album.ArtistId
ORDER BY Album.Title
LIMIT 10;
```

Logischerwijs verwachten we wel dat (tenminste als we geen `LIMIT` gebruiken) al
deze queries hetzelfde aantal rijen moeten teruggeven.

We blikken even vooruit naar een volgend hoofdstuk door de *aggregatie-functie*
`COUNT` te gebruiken om dit te controleren.

Beide queries (waarbij we enkel de linker- en rechtertabel hebben omgewisseld)
zouden evenveel rijen moeten opleveren:

```
SELECT COUNT(*)
  FROM Artist
  JOIN Album
    ON Artist.ArtistId = Album.ArtistId;
```

```
SELECT COUNT(*)
  FROM Album
  JOIN Artist
    ON Artist.ArtistId = Album.ArtistId;
```

## Oefening 05.02: De vertegenwoordiger van elke klant

Elke `Customer` heeft een `SupportRepId`. Dit is een FK die verwijst naar de
`Employee` die deze klant vertegenwoordigt (waar de klant dus terecht kan bij
vragen).

Laat de naam en het land van elke `Customer` zien met daarnaast telkens de naam
en het land v.d. `Employee` die voor deze klant verantwoordelijk is. Sorteer op
de achternaam v.d. vertegenwoordiger.

```
SELECT 
          Customer.FirstName, Customer.LastName, Customer.Country,
          Employee.FirstName, Employee.LastName, Employee.Country
    FROM Customer
    JOIN Employee
      ON Employee.EmployeeId = Customer.SupportRepId
ORDER BY Employee.LastName;
```
