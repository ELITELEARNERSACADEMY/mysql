/*solution pour la Quatrieme TP*/

/*Examen TP*/

/*CREER BASE DES DONNEES*/
CREATE DATABASE BD_Banque;
USE BD_Banque;

CREATE TABLE Banque(ID_Banc INT AUTO_INCREMENT,Nom_Banc VARCHAR(20), Ville_Banc VARCHAR(15), PRIMARY KEY(ID_Banc))

INSERT INTO Banque(Nom_Banc, Ville_Banc )
VALUES('EL Barid Banque','Rabat'),
('Banque Populaire','Casablanca'),
('AttiJari Wafa Banque','Casablanca'),
('BMCE','Rabat')

CREATE TABLE  Client(CIN VARCHAR(10), Nom_Cli VARCHAR(15),Prenom_Cli VARCHAR(10), Ville_Cli VARCHAR(15),PRIMARY KEY(CIN))

INSERT INTO Client(CIN , Nom_Cli ,Prenom_Cli, Ville_Cli )
VALUES('A123','Mohammed','Amine','Casablanca'),('B123','Elgharbooui','Miloud','Rabat'),('C123','Essbaii','Driss','Mohammedia'),('D123','Ennafati','Ayoub','Mohammedia')

CREATE TABLE Operation(ID_Op INT AUTO_INCREMENT,CIN VARCHAR(10) ,ID_Banc INT,Type_Operation VARCHAR(15),Date_Operation DATE,Solde INT,PRIMARY KEY(ID_Op), CONSTRAINT FOREIGN KEY(CIN) REFERENCES Client(CIN), CONSTRAINT FOREIGN KEY(ID_Banc) REFERENCES Banque(ID_Banc))

INSERT INTO Operation(CIN ,ID_Banc ,Type_Operation ,Date_Operation ,Solde )
VALUES('B123',1,'Depot','2017-11-27',2000),
('A123',3,'Emprunt','2017-10-15',2500),
('A123',2,'Emprunt','2017-11-10',1000),
('C123',3,'Depot','2017-09-01',3000),
('B123',2,'Emprunt','2017-10-25',1500)

/*Q3*/
SELECT *
FROM Client
ORDER BY Ville_Cli ASC

/*Q4*/
SELECT  Nom_Cli, COUNT(Nom_Cli)
FROM Client 
WHERE Ville_Cli = 'Mohammedia'
Group By Nom_Cli

/*avec JOIN , la selection c'est strictment a identification identique qui existe dans les  deux tableau (comme le intersection des ensemble distinct)*/
/*Q5*/
SELECT Nom_Banc 
FROM Banque 
WHERE  Nom_Banc NOT IN  (
                              SELECT Nom_Banc
                              FROM Banque JOIN Operation 
                              on Banque.ID_Banc = Operation.ID_Banc
                              JOIN Client 
                              on Operation.CIN =  Client.CIN
                              )

/* vous pouvez repond soient par JOIN ou Sous requet*/
/*en vers Client ---> Operation ----> Banque*/

/*Q6*/
SELECT Nom_Cli 
FROM Client
WHERE CIN IN (
                            SELECT CIN 
                            FROM Operation
                            WHERE  ID_Banc in (
                                              SELECT ID_Banc 
                                              FROM Banque
                                              where Nom_Banc = 'EL Barid Banque'
                            ) or (Type_Operation ='emprunt' and ID_BanC in  (
                                                      SELECT ID_Banc 
                                                      FROM Banque
                                                      where Nom_Banc = 'Banque populaire'
                                               
                                           ) 
                            )

)


/*Q7*/
SELECT MIN(Solde) as Min_solde,MAX(Solde) as MAX_solde, AVG(Solde) as Moy_solde
FROM  Operation 
WHERE  Type_Operation = 'emprunt' 

/*Q8*/
UPDATE  Operation
set Solde = Solde -  Solde * 0.5
where Type_Operation = 'emprunt'

/*Q9*/
SELECT Type_Operation,COUNT( Distinct Type_Operation) AS COMPTE
FROM Operation
WHERE Date_Operation like '2017%'
GROUP BY Type_Operation

/*Q10*/
SELECT Nom_Cli,AVG(DISTINCT solde) AS MOY_solde
FROM Operation  JOIN Client
ON Operation.CIN = Client.CIN
GROUP BY Nom_Cli 




