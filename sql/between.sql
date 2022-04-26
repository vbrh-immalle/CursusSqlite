DROP TABLE IF EXISTS getal;

CREATE TABLE getal(getal int);

INSERT INTO getal(getal) VALUES(1);
INSERT INTO getal(getal) VALUES(2);
INSERT INTO getal(getal) VALUES(3);
INSERT INTO getal(getal) VALUES(4);
INSERT INTO getal(getal) VALUES(5);
INSERT INTO getal(getal) VALUES(6);
INSERT INTO getal(getal) VALUES(7);
INSERT INTO getal(getal) VALUES(8);
INSERT INTO getal(getal) VALUES(9);
INSERT INTO getal(getal) VALUES(10);

.print 'Alle getallen:'
SELECT *
  FROM getal
;

.print 'Van 2 t.e.m. 8 met BETWEEN:'
SELECT *
  FROM getal
 WHERE getal BETWEEN 2 AND 8
;

.print 'Van 2 t.e.m. 8 met >= en <=:'
SELECT * 
  FROM getal
 WHERE getal >= 2 AND getal <= 8
;

.print 'Niet van 2 t.e.m. 8 met NOT BETWEEN:'
SELECT *
  FROM getal
 WHERE getal NOT BETWEEN 2 AND 8
;

.print 'Niet van 2 t.e.m. 8 met > en <:'
SELECT * 
  FROM getal
 WHERE getal < 2 OR getal > 8
;
