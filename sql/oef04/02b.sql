SELECT
       LastName   AS Achternaam,
       FirstName  AS Voornaam,
       Company    AS Bedrijf,
       City       AS Stad,
       Country    AS Land
  FROM Customer
 WHERE 
       Country = "Belgium" OR
       Country = "Netherlands"
;