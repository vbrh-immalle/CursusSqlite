- [Hoofdstuk 01: CLI-tools en prompts](#hoofdstuk-01-cli-tools-en-prompts)
  - [Inleiding](#inleiding)
  - [Powershell-prompt](#powershell-prompt)
  - [CLI-Programma's en argumenten (vlaggen)](#cli-programmas-en-argumenten-vlaggen)
    - [Sqlite3](#sqlite3)
    - [Git](#git)
    - [Dotnet](#dotnet)
    - [Go](#go)
  - [SQLite-prompt: `sqlite` interactief gebruiken](#sqlite-prompt-sqlite-interactief-gebruiken)
  - [Werken met Git en deze repository](#werken-met-git-en-deze-repository)

# Hoofdstuk 01: CLI-tools en prompts

## Inleiding

In dit hoofdstuk geven we enkele praktische tips voor het werken op de CLI in
het algemeen.

Je moet immers:

- kunnen werken met mappen en bestanden in Powershell
- een **Git-repository** kunnen clonen van GitHub m.b.v. `git`
- `sqlite3` kunnen opstarten (met of zonder *argumenten* (*vlaggen*))

Omdat `sqlite3` ook een *interactief* CLI-toooltje is, 
zal je in deze cursus goed onderscheid maken tussen:

- de Powershell-prompt (`PS C:\>`)
- de prompt van sqlite zelf (`sqlite>` en soms `   ...>`)


## Powershell-prompt

Powershell zal meestal een prompt tonen die begint met `PS` gevolgd door de
huidige directory maar wij zullen dit meestal afkorten als `PS>`

```
PS C:\>
```

Als je Powershell opstart (liefst in Windows Terminal), is je **huidige
directory** meestal `C:\Users\username`. Je prompt ziet er dan zo uit:

```
PS C:\Users\username>
``` 

Je kan van schijf veranderen met b.v. `D:`. Je huidige map wordt per schijf
*onthouden*.

```
PS D:\>
```

Een nieuwe lege werkmap maken (b.v. `C:\ffsql`) doe je dus b.v. met deze
commando's:

```
c:
cd \
mkdir ffsql
cd ffsql
```

- `c:` verandert je huidige schijf naar de C-schijf
- `cd \` gaat naar de *root* van de huidige schijf, in dit geval `C:\`
- `mkdir ffsql` maakt een nieuwe directory (in dit geval `C:\ffsql`)
- `cd ffsql` gaat naar deze directory

Je prompt ziet er nu dus zo uit:

```
PS C:\ffsql>
```

En uiteraard kan je steeds met `dir` controleren welke bestanden aanwezig zijn!

## CLI-Programma's en argumenten (vlaggen)

Net zoals vele CLI-tools (en Powershell-commando's), kan je **argumenten**
meegeven bij het aanroepen.

Het argument `-h` of `-help` (soms `--help`) werkt bij de meeste tools en toont
je een overzicht van alle (of de belangrijkste) mogelijke argumenten die we
kunnen meegeven.

Probeer dit in `PS>`:

```
sqlite3 -h
sqlite3 -help
sqlite3 --help
sqlite3 --version
git --version
git --help
dotnet --version
dotnet -h
dotnet --help
go version
go help
```

> Je ziet dat sommimge argumenten een `-` of `--` hebben. We noemen deze
> argumenten ook wel **vlaggen** omdat ze door de streepjes lijken op een
> vlaggenstok. Vaak is er een *korte* en een *lange* versie van een vlag.

### Sqlite3

We zullen in [hoofdstuk 03](03_WerkenMetBestanden.md) enkele argumenten gebruiken om meteen bij het
opstarten van `sqlite3` al meteen `.sqlite3`-bestanden of `.sql`-scripts te
openen!

Op https://sqlite.org/download.html kan je `sqlite3` downloaden. Zoek op deze
webpagina naar het bestand met in de naam `sqlite-tools-win32-x86` (of een
variant die beter gepast is voor jou CPU en besturingssysteem).

Nadien zouden deze commando's moeten werken:

```
sqlite3 -h
sqlite3 -help
sqlite3 --help
sqlite3 --version
```

### Git

Een ander CLI-tooltje dat we gebruiken is `git`. Je kan dit vinden op
https://git-scm.com/downloads.

Nadien zouden deze commando's moeten werken:

```
git --version
git --help
```

`git` is een programma dat ook met de **vlaggenstok-argumenten** werkt maar ook
met zogenaamde *subcommando's*. B.v. bij het uitvoeren van `git status` roep je
eigenlijk het `status` subcommando aan. Je kan dan daarna nog extra argumenten
meegeven.

Met dit commando zie je welke vlaggen (argumenten) het subcommando `status` heeft:

```
git status -h
```

Je kan ook een langere versie v.d. help-pagina opvragen (misschien opent dit
zelfs een webbrowser) met

```
git status --help
```

### Dotnet

Wanneer je de dotnet-tools hebt geïnstalleerd (https://dotnet.microsoft.com/)
kan je o.a. C#-programma's compileren en de laatste nieuwe versie van Powershell
installeren (zie andere cursussen).

Nadien zouden deze commando's moeten werken:

```
dotnet --version
dotnet -h
dotnet --help
```

https://github.com/vbrh-immalle/DotnetSqliter is een voorbeeld van een
C#-repository die je met `dotnet` kan uitproberen.

### Go

https://golang.org/ is een programmeertaal die je misschien al bent
tegengekomen. Na installatie, zal je beschikken over het `go`-CLI-programma.

`go` werkt (net zoals `git`) met **sub**commando's.

Deze commando's zouden na installatie moeten werken:

```
go version
go help
go doc -h
```

> Voor deze cursus heb je `go` niet nodig. We geven het hier maar als voorbeeld
> van een CLI-applicatie.

## SQLite-prompt: `sqlite` interactief gebruiken

`sqlite3` kan dus zoals de meeste CLI-tools met bepaalde vlaggen opgestart
worden maar **het is ook een interactief tooltje**! Dit wil zeggen dat het de
gewone shell overneemt en we er rechtstreeks commando's aan kunnen geven.

Wanneer we in een (Power)shell `sqlite3` opstarten zonder argumenten, zal de
prompt op de terminal veranderen naar `sqlite>`. Dit betekent dat we nu in de
interactieve shell van sqlite zelf zitten!

```
sqlite>
```

Je kan hier nu dot-commando's geven, zoals:

```
.help
.mode
.tables
.dump
```

Soms toont de prompt `   ...>`. Later meer hierover.

Als **noodoplossing** kunnen we met `CTRL-C` (Cancel/Abort) steeds proberen om
terug in Powershell te geraken.

> Om Copy/Paste te gebruiken in b.v. Windows Terminal, moet je standaard
> `CTRL+SHIFT+C` en `+V` gebruiken!

De normale manier om de sqlite-prompt te verlaten is met het `.quit`-commando.
Meer hierover in het volgende hoofdstuk.

Een shell-sessie waarin je `sqlite3` opstart in de `c:\ffsql`-directory en
vervolgens weer verlaat, ziet er dus b.v. zo uit:

```
PS C:\ffsql> sqlite3
SQLite version 3.33.0 2020-08-14 13:23:32
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .quit
PS C:\ffsql>
```

## Werken met Git en deze repository

Een map op schijf *kan* een git-repository zijn. Om dit te controleren doe je

```
git status
```

Vanaf hoofdstuk 03 zal je met `.sql`- en `.sqlite3`-bestanden moeten werken.
Deze bestanden staan in de GitHub-repository
https://github.com/vbrh-immalle/CursusSqlite. Je moet deze repo dus **clone**'n!

Zorg dat je in een lege werkmap staat. Je Powershell-prompt ziet er dus b.v. zo
uit:

```
PS C:\ffsql>
```

Type nu

```
git clone https://github.com/vbrh-immalle/CursusSqlite
```

De repository wordt gedownload in een map met dezelfde naam als de repository.

Doe daarna

```
cd CursusSqlite
```

De Powershell-prompt wijzigt in:

```
PS C:\ffsql\CursusSqlite>
```

Probeer nu nogmaals de status op te vragen met `git`:

```
git status
```

Het kan gebeuren dat er nieuwe *commits* zijn toegevoegd op de GitHub-repository
die jij lokaal nog niet hebt. Om je lokale repo te updaten doe je

```
git pull
```

De nieuwste bestanden worden dan van de GitHub-repo gedownload.

Als je zelf bestanden hebt verandert, zal `git` hier een melding over geven. Je
kan steeds `git status` gebruiken om te kijken of bestanden veranderd zijn.

Je kan ook Visual Studio Code openen in een repository en de geïntegreerde
git-client gebruiken. Je opent gemakkelijk VSCode in de huidige directory met

```
code .
```

(De `.` zorgt ervoor dat de huidige directory als een **project** wordt
geopend.)

Een (Power)shell-sessie waarin je deze repo clone't en vervolgens de lokale repo
opent in VSCode, ziet er dus b.v. zo uit:

```
PS C:\ffsql> git clone https://github.com/vbrh-immalle/CursusSqlite
Cloning into 'CursusSqlite'...
remote: Enumerating objects: 63, done.
remote: Counting objects: 100% (63/63), done.
remote: Compressing objects: 100% (43/43), done.
remote: Total 63 (delta 31), reused 45 (delta 16), pack-reused 0
Unpacking objects: 100% (63/63), 22.67 KiB | 108.00 KiB/s, done.
PS C:\ffsql> cd .\CursusSqlite\
PS C:\ffsql\CursusSqlite> code .
PS C:\ffsql\CursusSqlite>
```

Dit is geen cursus over `git` maar hopelijk ken je minstens deze belangrijke
commando's:

- `git status`
- `git clone`
- `git pull`

Als je *vast* zit in een Git-repository (je begrijpt b.v. niet alle meldingen
dit `git status` of `git pull` geven) kan je als **noodoplossing** steeds de
lokale Git-repository verwijderen en opnieuw een repository van GitHub clonen.
