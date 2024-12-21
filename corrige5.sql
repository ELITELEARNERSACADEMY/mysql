/*solution pour la Cinquieme TP*/

CREATE  DATABASE BD_Voyage;

USE  BD_Voyage;

CREATE  TABLE Pilote(Num_Pil INT AUTO_INCREMENT,Nom_Pil VARCHAR(15),Prenom VARCHAR(15),Ville_Domicile VARCHAR(15) ,Salaire INT , PRIMARY KEY(Num_Pil));

INSERT INTO Pilote(Nom_Pil,Prenom,Ville_Domicile,Salaire)
VALUES('Zitouni','Ibrahim','Casablanca',25000),
('Brada','Sami','Rabat',30000),
('Karroum','Khalid','Casablanca',18000),
('Midaoui','Mohammed','Rabat',28000),
('Taghmaouti','Ahmed','Marrakech',18500)

CREATE  TABLE Avion(Num_Av INT AUTO_INCREMENT ,Nom_Av VARCHAR(15),Capacite INT ,Localisation VARCHAR(15), PRIMARY KEY(Num_Av));

INSERT INTO Avion(Nom_Av,Capacite,Localisation)
VALUES('A300',300,'Rabat'),
('A310',250,'Rabat'),
('Concorde129',150,'Casablanca'),
('Boeing200',350,'Agadir'),
('Boeing370',400,'Rabat')

CREATE  TABLE  Vol(Num_Vol INT AUTO_INCREMENT ,Num_Pil INT ,Num_Av INT ,Ville_Depart VARCHAR(15),Ville_Arrivee VARCHAR(15),Date_depart DATE  , Date_arrivee DATE, PRIMARY KEY(Num_Vol),CONSTRAINT FOREIGN KEY(Num_Pil) REFERENCES Pilote(Num_Pil), CONSTRAINT FOREIGN KEY(Num_Av)  REFERENCES Avion(Num_Av))



INSERT INTO Vol(Num_Pil,Num_Av,Ville_Depart,Ville_Arrivee,Date_depart, Date_arrivee)
VALUES(2,4,'Agadir','Rome','2017-11-03 11:00','2017-11-03 15:00'),
(4,2,'Rabat','Madrid','2017-09-15 02:30','2017-09-15 05:00'),(3,3,'Casablanca','Rome','2017-09-17 18:00','2017-09-17 23:00'),(1,1,'Rabat','Paris','2017-09-27 03:00','2017-09-27 07:00')

/*Q3*/
SELECT Nom_Pil , Prenom
FROM Pilote
WHERE Salaire > 20000
ORDER BY Nom_Pil ASC

/*Q4*/
ALTER TABLE Pilote 
ADD CONSTRAINT Salaire Check(  Salaire > 14000 )

/*Q5*/
SELECT Localisation, COUNT(*) AS Nombre_Avions, MIN(Capacite) AS Capacite_Min, MAX(Capacite) AS Capacite_Max, SUM(Capacite) AS Capacite_Totale
FROM Avion
GROUP BY Localisation;

/*Q6*/
SELECT Num_Av,Nom_Av
FROM Avion 
WHERE Localisation = 'Rabat' and Num_Av NOT IN (
                                                                       SELECT Num_Av 
                                                                       FROM Vol
                                                                      )

/*Q7*/
SELECT Num_Av 
FROM Avion NATURAL JOIN Vol 
WHERE Ville_Depart = 'Rabat' and Ville_Arrivee = 'Madrid'

/*Q8*/
SELECT Nom_Av
FROM Avion
WHERE Nom_Av LIKE 'Boeing%' and Capacite > (SELECT  AVG(Capacite) FROM Avion)

/*Q9*/
UPDATE Pilote 
SET Salaire = Salaire - Salaire*0.05
WHERE Num_Pil IN (   SELECT  Num_Pil
                                       FROM Vol
                                        GROUP BY  Num_Pil 
                                        HAVING COUNT(*) < 2 
                                   )


/*Q10*/

SELECT Ville_Domicile 
FROM  Pilote 
WHERE Salaire = (SELECT MIN(Salaire) FROM Pilote)

