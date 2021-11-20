# Installatie

Op sommige Linux- en op macOS-systemen is `sqlite3` al standaard geïnstalleerd.

Op Windows kan je het zelf installeren met een package manager of je kan het rechtstreeks downloaden van https://www.sqlite.org.

Om te controleren of je het programma hebt (en het reeds in je `PATH` aanwezig is), kan je een aantal dingen doen.

## Uitproberen

Je kan het programma meteen uitvoeren en kijken of het werkt

```
sqlite3
```

Als je nu de sqlite3-prompt te zien krijgt, kan je verder!

````
SQLite version 3.37.0 2021-09-28 10:44:54
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
```

Om terug naar de shell te gaan, type `.quit` of `.exit`.

> Hier zie je we blijkbaar versie 3.37.0 gebruiken en hoe dat we verbonden zijn met een **in-memory database**. Dat wil zeggen dat we niet verbonden zijn met een database op schijf.


## Windows / Powershell

In Powershell kan je controleren of `Get-Command` het programma vindt

```powershell
Get-Command sqlite3
```

## macOS / Linux

In Linux/macOS kan je met `which` controleren of het programma gevonden wordt:

```bash
which sqlite3
```

## ASK4HELP!

Vraag assistentie als het je niet lukt om `sqlite3` op te starten!
