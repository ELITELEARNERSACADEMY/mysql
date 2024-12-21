/*solution pour la troisieme TP*/

/*Creer la Base des donnees*/

create database BD_VOL;

use  BD_VOL;
/*Creer les tableau*/
CREATE TABLE PILOTE(npil INT ,nompil VARCHAR(10),salaire  INT ,statut VARCHAR(10),PRIMARY KEY(npil))

ALTER TABLE PILOTE
DROP  COLUMN  statut

INSERT INTO PILOTE(npil,nompil,salaire)
VALUES(1,'Ali',20000),
(5,'Moussi',18000),
(7,'Peter',22000)

CREATE TABLE VOL(nvol INT AUTO_INCREMENT,villedep VARCHAR(15),villearr VARCHAR(15),depart DATE,arrive DATE ,npil INT ,nav INT,PRIMARY KEY(nvol),CONSTRAINT FOREIGN KEY(nav) REFERENCES  AVION(nav))

INSERT INTO VOL(villedep,villearr,depart,arrive,npil,nav)
VALUES('Rabat','Paris','2015-01-04 12:00','2015-01-04 14:30',1,20),
('Casablanca','Lyon','2015-06-26 09:15','2015-06-26 13:05',5,15),('Rabat','Dakar','2015-04-14 08:00','2015-04-14 16:10',1,6)

CREATE TABLE AVION(nav INT ,nomav VARCHAR(15),capacite INT, PRIMARY KEY(nav))
INSERT INTO AVION(nav,nomav,capacite)
VALUES(20,'RG 797',250),
(15,'MA 426',300),
(6,'BO 500',350)

/*Q4*/
SELECT nomav ,MIN(capacite)
FROM AVION
GROUP BY nomav

/*Q5*/
SELECT count(nvol)
FROM AVION NATURAL  JOIN VOL
WHERE nomav like 'M%'
GROUP BY nvol

/*Q6*/
SELECT nompil, SUM(salaire) AS s
FROM PILOTE
GROUP BY nompil
HAVING SUM(salaire) < (SELECT AVG(salaire)  FROM PILOTE)
ORDER BY s ASC;

/*Q7*/
SELECT nompil 
FROM PILOTE  
WHERE npil not in (
                  SELECT npil 
                  FROM VOL
)
 



