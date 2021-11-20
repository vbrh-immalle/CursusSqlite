# CLI-tools en prompts

In deze cursus moeten we goed onderscheid maken tussen:

- de Powershell-prompt (`PS>`)
- de prompt van sqlite zelf (`sqlite>` en soms `   ...>`)

## Powershell-prompt

Powershell zal meestal een prompt tonen die begint met `PS` gevolgd door de huidige directory maar wij zullen dit meestal afkorten als `PS>`

```
PS C:\>
```

## SQLite-prompt

`sqlite3` is een **interactief** CLI-tooltje. Dit wil zeggen dat het de gewone shell overneemt en we er rechtstreeks commando's aan kunnen geven.

Wanneer de terminal `sqlite>` als prompt toont, zitten we in de interactieve shell van sqlite zelf!

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

Als **noodoplossing** kunnen we met `CTRL-C` (Cancel/Abort) steeds proberen om terug in Powershell te geraken.

> Om Copy/Paste te gebruiken in b.v. Windows Terminal, moet je standaard `CTRL+SHIFT+C` en `+V` gebruiken!

# CLI-Programma's en argumenten

Net zoals vele CLI-tools (en Powershell-commando's), kan je **argumenten** meegeven bij het aanroepen.

Het argument `-h` of `-help` (soms `--help`) toont je alle mogelijk argumenten die we kunnen meegeven.

Probeer dit in `PS>`:

```
sqlite3 -h
sqlite3 -help
sqlite3 --help
```

We zullen later enkele argumenten gebruiken om meteen bij het opstarten al `.sqlite3`-bestanden of `.sql`-scripts te openen!
