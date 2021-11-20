# CursusSqlite

Een cursus SQL a.h.v. het `sqlite3`-command-line-tooltje van https://sqlite.org/.

Onmiddellijk beginnen? Ga naar `00_Installatie.md`.

# SQL en server-applicaties

SQL (Structured Query Language, https://nl.wikipedia.org/wiki/SQL) is een programmeertaal die we terugvinden in een aantal implementaties van database-software zoals:

- https://nl.wikipedia.org/wiki/Microsoft_SQL_Server
- https://nl.wikipedia.org/wiki/PostgreSQL
- https://nl.wikipedia.org/wiki/MySQL

Al deze implementaties zijn database-**servers**. Het zijn server-applicaties waar andere onderdelen van een applicatie (b.v. een front-end-applicatie geschreven in C#, Php, Java, ...) verbinding mee kan maken om gegevens op te vragen. 

> Sinds de jaren '90 zijn er b.v. zeer veel webapplicaties die geschreven zijn in **Php** en die als achterliggende database **MySQL** gebruiken, b.v. Wordpress en (aanvankelijk) Facebook.

 De database wordt b.v. gebruikt voor het opslaan van:

- gebruikers (en (hashes van) wachtwoorden)
- blog-posts
- informatie over (financiële) transacties
- forum-berichten
- punten v.d. rapporten van leerlingen (b.v. in de databases van Smartschool)
- ...

Een database-**server** heeft eigenlijk enkel zin als de applicatie door meerdere gebruikers tegelijkertijd gebruikt wordt (zoals bij web-applicaties).

# SQLite

https://nl.wikipedia.org/wiki/SQLite

SQLite is een bibliotheek (library) die met SQL-code overweg kan (een *SQL-engine*) en die gegevens **in één bestand** opslaat. SQLite is **geen netwerk-server** zoals de andere SQL-applicaties. 

SQLite wordt door zeer veel applicatie-ontwikkelaars gebruikt als een makkelijke en betrouwbare (en *relationele*) manier om gegevens op een lokale schijf op te slaan. 

Voorbeelden:
- instellingen en bookmarks in Chrome en Firefox
- SMS- en contactgegevens in Android en iOS
- ...

Je kan als applicatie-ontwikkelaar de SQLite-bibliotheek aan je project toevoegen. Dit is meestal makkelijker dan om zelf manieren te bedenken om informatie (even betrouwbaar) op de lokale schijf v.d. 
gebruiker op te slaan.

> Zie b.v. https://sqlite.org/fasterthanfs.html waar uitgelegd wordt hoe SQLite gebruiken meestal performanter is dat zelf bestanden op schijf te beheren.

Op https://github.com/vbrh-immalle/DotnetSqliter kan je zelf een simpel voorbeeld uittesten van een C#-applicatie die een SQLite-database gebruikt.

> Voor kleinere server-applicaties (b.v. minder dan 1000 gelijktijdige gebruikers) is SQLite soms meer dan voldoende. SQLite *kan* dus ook in een server-applicatie gebruikt worden maar het bevat zelf geen netwerk-server en slechts 1 (server-)applicatie kan gelijktijdig schrijven naar het sqlite-bestand.

## SQLite-CLI-tool

Het cursusmateriaal in deze repository maakt gebruik v.d. `sqlite3`-CLI-tool. Dit is een Command-Line-tooltje dat de makers van de `sqlite`-library hebben geschreven. Het is één van de manieren waarop je gemakkelijk met sqlite-databanken (die steeds maar uit één bestand bestaan) kan werken.

Als je dus ergens een sqlite-databank tegenkomt (b.v. in de instellingen van Chrome of Firefox of op een Android-toestel) kan je dit bestand simpelweg kopiëren en het openen/exploreren met `sqlite3`.

## DB Browser for SQLite

Sommige mensen werken liever met een grafisch programma zoals https://sqlitebrowser.org/ om sqlite-databanken te exploreren. Dit programma is *niet* van de makers van de SQLite-library. Het is echter ook een prima tool om te werken met SQLite-databank-bestanden of om SQL-commando's te oefenen.
