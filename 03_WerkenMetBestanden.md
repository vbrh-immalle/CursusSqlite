- [Hoofdstuk 03: Werken met bestanden](#hoofdstuk-03-werken-met-bestanden)
  - [Inleiding](#inleiding)
  - [Oefening 03.01: De bestanden verkennen](#oefening-0301-de-bestanden-verkennen)
    - [03.01.01 Inleiding](#030101-inleiding)
    - [03.01.02 Locatie v.d. bestanden](#030102-locatie-vd-bestanden)
    - [03.01.03 Inhoud v.d. bestanden](#030103-inhoud-vd-bestanden)
    - [03.01.04 VSCode en DB Browser for SQLite](#030104-vscode-en-db-browser-for-sqlite)
    - [03.01.05 Conclusie](#030105-conclusie)
  - [Oefening 03.02: `sqlite3` initialiseren met een `.sql`-script](#oefening-0302-sqlite3-initialiseren-met-een-sql-script)
    - [03.02.01 De help van `sqlite3` bekijken](#030201-de-help-van-sqlite3-bekijken)
    - [03.02.02 De `-init`-vlag gebruiken](#030202-de--init-vlag-gebruiken)
    - [03.02.03 Verder werken met de database](#030203-verder-werken-met-de-database)
    - [03.02.04 Conclusie](#030204-conclusie)
    - [03.02.05 Vraagjes](#030205-vraagjes)
  - [Oefening 03.03: `.sql`-scripts voor code-fragmenten](#oefening-0303-sql-scripts-voor-code-fragmenten)
    - [03.03.01 Inleiding](#030301-inleiding)
    - [03.03.02 Enkele queries in `.sql`-scripts verkennen](#030302-enkele-queries-in-sql-scripts-verkennen)
    - [03.03.03 Opgeslagen queries uitvoeren](#030303-opgeslagen-queries-uitvoeren)
    - [03.03.04 Conclusie](#030304-conclusie)
    - [03.03.05 Tip](#030305-tip)
  - [Oefening 03.04: Een `.sqlite3`-databank openen](#oefening-0304-een-sqlite3-databank-openen)
    - [03.04.01 Inleiding](#030401-inleiding)
    - [03.04.02 De help van `sqlite3` bekijken](#030402-de-help-van-sqlite3-bekijken)
    - [03.04.03 Een `.sqlite3`-bestand openen](#030403-een-sqlite3-bestand-openen)
    - [03.04.04 Gegevens toevoegen aan een bestaande databank](#030404-gegevens-toevoegen-aan-een-bestaande-databank)
    - [03.04.05 Conclusie](#030405-conclusie)
    - [03.04.06 Vraagjes](#030406-vraagjes)

# Hoofdstuk 03: Werken met bestanden




## Inleiding

In dit hoofdstuk zal je leren werken met

- `.sql`-bestanden: dit zijn tekst-bestanden met SQL-code
- `.sqlite3`-bestanden: dit zijn echte SQLite-databases, het zijn binaire
  bestanden

De voorbeeldbestanden die je nodig hebt, vind je in deze repository in de
mappen:

- `sql`: hierin staan de code-bestanden
- `dbs`: hierin staan de sqlite-databanken

Je zal in dit hoofdstuk zelf nog geen `.sql`-bestanden moeten schrijven maar wel
gebruik maken van een bestaande `.sql`-bestanden.








## Oefening 03.01: De bestanden verkennen


### 03.01.01 Inleiding

We vertrekken van een Terminal met Powershell waarin je in de map `C:\ffmysql`
deze repository (https://github.com/vbrh-immalle/CursusSqlite) geclone't hebt.
Lees [hoofdstuk 01](01_OverCLIs.md) opnieuw als je dit nog niet hebt.

Als het goed, heb je (minstens) deze hiërarchie van bestanden en mappen:

```
C:\ffsql
\---CursusSqlite
    |   00_Installatie.md
    |   01_OverCLIs.md
    |   02_OpVerkenning.md
    |   03_WerkenMetBestanden.md
    |   README.md
    |
    +---dbs
    |       school.sqlite3
    |
    \---sql
            student.sql
            ShowAllStudentsEN.sql
            ShowAllStudentsNL.sql
```

Voor de commando's die volgen, moet je je in de map van de lokale repository
bevinden, zodat de prompt er zo uit ziet:

```
PS C:\ffsql\CursusSqlite>
```

> Gebruik het (Power)shell-commando `cd` om in de juiste map terecht te komen!
> Denk eraan: `cd ..` brengt je één map hoger in de hiërarchie.
> Tips: 
>
> - `cd .` doet niet zoveel want `.`betekend simpelweg *de huidige map*
> - De `.` is wel nuttig om VSCode op te starten met de huidige map als projectmap: `code .`



### 03.01.02 Locatie v.d. bestanden

Kijk met één van deze Powershell-commando welke bestanden aanwezig zijn in de
huidige map en alle submappen:

```
dir -Recurse
dir -r
```

Met het `dir`-commando kan je ook enkel bestanden uit 1 map bekijken. Bekijk
welke bestande aanwezig zijn in de subdirectory `dbs` en `sql`:

```
dir dbs
dir sql
```

> We maken hier gebruik van **relatieve paden**. We zouden ook **absolute
> paden** kunnen gebruiken. De commando's worden dan:
>
> ```
> dir c:\ffsql\CursusSqlite\dbs
> dir c:\ffsql\CursusSqlite\sql
> ```
>
> Het is hopelijk duidelijk dat werken met relatieve paden makkelijker is dus
> dat zullen we doen in de rest v.d. cursus!


### 03.01.03 Inhoud v.d. bestanden

Met het commando `cat` (of `Get-Content` of `type`) kan je in Powershell de inhoud van
tekstbestanden tonen.

Controleer de inhoud van `sql/student.sql`:

```
cat sql/student.sql
Get-Content sql/student.sql
type sql/student.sql
```

Je ziet nu de inhoud van een script dat voor `sqlite3` bedoeld is met zowel
dot-commando's als SQL-code!

Wanneer je hetzelfde probeert met `dbs/school.sqlite3` zal de output niet zo
mooi zijn. Dit is immers een **binair** bestand. Je kan wel met `Format-Hex` de
precieze bytes van dit bestand bekijken. Het is wel eens nuttig om b.v. de
eerste 256 bytes weer te geven. We kunnen dan vaststellen dat de binaire
`.sqlite3`-bestanden eigenlijk beginnen met 16 specifieke bytes die zeer
herkenbaar zijn.

```
cat dbs/school.sqlite3                              # dit geeft vele rare tekens in de output -> het is geen tekstbestand
Format-Hex dbs/school.sqlite3                       # dit toont alle bytes van het bestand -> veel output
Format-Hex dbs/schooo.sqlite3 | Select -First 16    # dit toont enkel de eerste 16 regels oftewel de eerste 256 bytes v.h. bestand
```

We stellen dus vast dat elk `.sqlite3`-bestand begint met deze 16 bytes:

```
53 51 4C 69 74 65 20 66 6F 72 6D 61 74 20 33 00
```

Dit is eigenlijk gewoon de string `SQLite format 3` gevolgd door een byte met waarde `00`.

> Eigenlijk is de extensie `.sqlite3` van het bestand van geen belang. Dit is
> gewoon een afspraak die wij maken. SQLite-bestanden kunnen gerust andere
> extensies hebben zoals `.db` of `.sqlite` of zelfs helemaal geen extensie! De
> applicatie `sqlite3` herkent sqlite-databases o.a. aan deze eerste 16 bytes!


### 03.01.04 VSCode en DB Browser for SQLite

Denk er aan dat je de bestanden ook steeds kan bekijken vanuit VSCode! We zullen
later VSCode gebruiken om de `.sql`-bestanden te bewerken.

Je kan in VSCode ook extensies installeren die met de binaire
`.sqlite3`-bestanden overweg kunnen maar dat zullen wij niet doen. Als we met
een grafische tool willen werken, gebruiken we liever
https://sqlitebrowser.org/.


### 03.01.05 Conclusie

Je hebt nu duidelijk kunnen vaststellen dat we met 2 soorten bestanden gaan werken:

- `.sql`-codebestanden (die we handig kunnen bekijken en bewerken in VSCode)
- `.sqlite3`-databases (die we met `sqlite3` of **Db Browser for SQLite** kunnen openen)



## Oefening 03.02: `sqlite3` initialiseren met een `.sql`-script


### 03.02.01 De help van `sqlite3` bekijken

Wanneer de help-output van `sqlite3` bekijken ... (in `PS>`) ...

```powershell
sqlite3 -help
```

... zien we o.a.:

```
-init FILENAME       read/process named file
```

Met de `-init`-vlag kunnen we `sqlite3` opstarten en al meteen een `.sql`-script
laten uitvoeren.


### 03.02.02 De `-init`-vlag gebruiken

Laten we die doen (in `PS>`):

```powershell
sqlite3 -init sql/student.sql
```

> Merk op dat onze huidige directory de *root* v.d. *repository** is
> (`C:\ffsql\CursusSqlite`) en we een relatief pad gebruiken (`sql/student.sql`)
> om naar het script `student.sql` te verwijzen dat in de subdirectory `sql`
> staat! Het absolute pad van het script is eigenlijk
> `C:\ffsql\CursusSqlite\sql\student.sql`.)

Je ziet waarschijnlijk dit:

```
PS C:\ffsql\CursusSqlite> sqlite3 -init sql/student.sql
-- Loading resources from sql/student.sql                       # LET OP DEZE REGEL!
SQLite version 3.33.0 2020-08-14 13:23:32
Enter ".help" for usage hints.
sqlite>
```

> Let op de regel `-- Loading resources from sql/student.sql`. Als je deze niet
> ziet, kon `sqlite3` waarschijnlijk het `.sql`-script niet vinden!


### 03.02.03 Verder werken met de database

We hebben nu alle SQL-code uitgevoerd en aangezien we geen foutmeldingen kregen,
was alles blijkbaar in orde!

We controleren of we de `Student`-tabel hebben en of de gegevens aanwezig zijn
(in `sqlite>`):

```sql
.tables
SELECT * FROM Student;
```

Deze database bevindt zich (net zoals in het vorige hoofdstuk) in het
RAM-geheugen en nog niet in een database-bestand. We zijn alle gegevens dus weer
kwijt als we `sqlite3` verlaten met `.quit`.

> Met het dot-commando `.databases` kan je controleren of we in het RAM-geheugen
> aan het werken zijn of in een echt database-bestand.
>
> ```
> main: "" r/w
> ```
>
> Als je deze output ziet, wil dit zeggen dat we lezen en schrijven (read/write)
> in het RAM-geheugen


### 03.02.04 Conclusie

Proficiat! Je hebt zonet een `.sql`-script uitgevoerd!

Zie je dat we nu een soort van *zandbak* (in het RAM-geheugen) gemaakt hebben
waarin we kunnen *spelen* met SQL-commando's? We zijn begonnen met de *zandbak
te vullen* met code uit `student.sql` en vervolgens kunnen we er verder in
*spelen*, zonder dingen kapot te maken of bestanden op schijf te veranderen.

Als we in onze *zandbak* een mooie nieuwe query ontdekken die we willen opslaan,
slaan we deze dus liefst op in een (nieuw) `.sql`-bestand!


### 03.02.05 Vraagjes

Is het je opgevallen dat de output van de tabel al meteen werd weergegeven als
een (mooie) ASCII-art-tabel? Kan je verklaren hoe dat komt?




## Oefening 03.03: `.sql`-scripts voor code-fragmenten


### 03.03.01 Inleiding

Uit de vorige oefening kan je afleiden dat een groot `.sql`-bestand de ganse
broncode van een database kan bevatten.

Het is soms makkelijk om met kleinere `.sql`-bestandjes te werken:

- om fragmenten van de database-initialisatie in op te slaan
- om interessante queries in te bewaren

Met het dotcommando `.read` kunnen we deze code-fragmentjes makkelijk uitvoeren
in onze `sqlite>` *zandbak*.


### 03.03.02 Enkele queries in `.sql`-scripts verkennen

In de map `sql` vind je 2 bestanden waarin slechts 1 query is opgeslagen.

> Het zijn de queries uit het vorige hoofdstuk!

Toon in Powershell de inhoud van deze bestanden (in `PS>`):

```
cat sql/ShowAllStudentsEN.sql
cat sql/ShowAllStudentsNL.sql
```

> Je kan natuurlijk ook VSCode gebruiken (eigenlijk is dat misschien wel makkelijker).


### 03.03.03 Opgeslagen queries uitvoeren

We initialiseren opnieuw een sqlite-zandbak in het RAM-geheugen met het
`dbs/student.sql`-script (in `PS>`):

```powershell
sqlite3 -init dbs/student.sql
```

Met het dotcommando `.help` gaan we zoek naar een commando om sql-scripts in te
lezen (in `sqlite>`):

```sql
.help
```

We vinden o.a. deze regel:

```
.read FILE               Read input from FILE
```

Hoera! We hebben het commando gevonden om `.sql`-scripts vanaf de
`sqlite>`-shell in te lezen!

We kunnen de queries in de `.sql`-bestanden nu zo uitvoeren:

```
.read sql/ShowAllStudentEN.sql
.read sql/ShowAllStudentNL.sql
```

Door een goede naam te geven het `.sql`-bestand, hebben we meteen een
omschrijving voor de query.


### 03.03.04 Conclusie

Je ziet hopelijk stilaan hoe je op een bepaalde manier te werk kan gaan (een
*workflow*) waarbij je VSCode gebruikt om `.sql`-bestanden te bewerken en
`sqlite3` in de Terminal gebruikt om deze queries te testen!

Proficiat, je wordt nog een professionele DBA (DataBase-Administrator)!


### 03.03.05 Tip

We zullen proberen in deze cursus een consistente naamgeving te geven aan de
`.sql`-bestanden:

- scripts die beginnen met een hoofdletter (zoals `ShowAllStudentNL.sql`) zijn
  bedoeld om met `.read` uit te voeren
- scripts die beginnen met een kleine letter (zoals `student.sql`) zijn eerder
  bedoeld om met `sqlite3 -init ...` uit te voeren (maar kunnen natuurlijk ook
  met `.read` uitgevoerd worden)

Probeer deze vuistregel zelf ook toe te passen!




## Oefening 03.04: Een `.sqlite3`-databank openen


### 03.04.01 Inleiding

In de map `dbs` vinden we de SQLite-databank `school.sqlite3`. We zullen in deze
oefening deze databank gebruiken.

We gaan in deze oefening dus niet enkel in het RAM-geheugen werken!


### 03.04.02 De help van `sqlite3` bekijken

Wanneer de help-output van `sqlite3` bekijken ... (in `PS>`) ...

```powershell
sqlite3 -help
```

zien we bovenaan deze help-string:

```
Usage: sqlite3 [OPTIONS] FILENAME [SQL]
```

Van de **Usage**-help kunnen we afleiden dat onmiddellijk na het woord `sqlite3`
we `[OPTIONS]` kunnen meegeven.

> `-init` is zo'n optie die we gebruikt hebben.

Na de `[OPTIONS]` kunnen we een bestandsnaam (`FILENAME`) en nog extra `[SQL]`
meegeven.


### 03.04.03 Een `.sqlite3`-bestand openen

Voer deze code uit (in `PS>`):

```powershell
sqlite3 dbs/school.sqlite3
```

Voer nu dit dot-commando uit (in `sqlite>`):

```sql
.databases
```

Als het goed is zie je dit:

```
sqlite> .databases
main: C:\ffsql\CursusSqlite\dbs\school.sqlite3
sqlite>
```

Dit wil zeggen dat we nu niet in een **transient in-memory database** werken
zoals in alle vorige oefeningen maar dat we dit sqlite-bestand op schijf
gebruiken!

> De term **transient in-memory database** is hoe `sqlite3` dit noemt als we
> opstarten zonder een database mee te geven. Het gaat dus als het ware over een
> *vluchtige* database (in het RAM-geheugen).

We kunnen de tabellen (en het schema) in deze database controleren en queries
uitvoeren (je ziet dat de `Student`-tabel aanwezig is):

```sql
.tables
.schema
SELECT * FROM Student;
```

### 03.04.04 Gegevens toevoegen aan een bestaande databank

Alle queries die we nu uitvoeren, zullen opgeslagen worden op schijf.
We werken nu dus niet meer in een *zandbak* maar zullen effectief het bestand `school.sqlite3` kunnen aanpassen.

`SELECT`-queries vragen alleen maar gegevens op en wijzigen dus niets.

Maar als je jezelf toevoegt aan de leerlingen, zal je zien dat het bestand gewijzigd is!

Probeer deze query om jezelf toe te voegen aan de `Student`-tabel:

```sql
INSERT INTO Student(Name, Age) VALUES ('Ikke', 16);
```

Controleer:

```sql
SELECT * FROM Student;
```

Verlaat nu `sqlite3`:

```sql
.quit
```

> We kunnen nu ook even `git status` proberen. Git zou moeten detecteren dat
> `school.sqlite3` gewijzigd is t.o.v. de laatste keer dat we de repository
> geclone'd hebben!

Start `sqlite3` opnieuw op met dezelfde database (in `PS>`):

```
sqlite3 dbs/school.sqlite3
```

Controleer:

```sql
SELECT * FROM Student;
```

### 03.04.05 Conclusie

Proficiat! Je kan nu echte SQLite-databases openen en exploreren en zelfs aanpassen!

TIPS: 

- Gebruik het dot-commando `.databases` om te controleren in welke database je
  aan het werken bent.
- Je kan een `in-memory-database` ook opslaan naar een bestand. Het
  `.save`-commando kan zeer handig zijn als je al heel wat werk hebt verricht in
  het RAM-geheugen en dit wil opslaan op schijf!

> Denk eraan: je werkt in een git-repository dus als je de originele bestanden
> overschrijft, kan je toch nog steeds de originele bestanden terughalen.

### 03.04.06 Vraagjes

1. Kan je met `sqlite3 blabla.sqlite3` een nieuwe databank maken ook al bestaat
   het bestand `blabla.sqlite3` nog niet?

2. Probeer de commando's `.save`, `.schema` en `.dump` uit en omschrijf het nut
   van elk van deze commando's.

3. Kan je uitleggen wat er gebeurt als we `sqlite3 -init bla.sql blabla.sqlite3`
   uitvoeren?
