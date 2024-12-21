/*solution pour la premier TP*/


/*Q1*/

/*Creer La Base des donnee*/
CREATE  DATABASE  BD_BANQUE;
/*choisir la Base des donnee */
USE BD_BANQUE;

/*Q2*/

/*Creer Les Tableau*/
/*Attetion  CIN n'est pas un entiere */
CREATE TABLE CLIENT(CIN VARCHAR(10) ,nomC VARCHAR(10),prenomC  VARCHAR(10),villeC VARCHAR(20), PRIMARY KEY(CIN));

/*ajouter  Les Valeur dans   la Tableau*/
INSERT  INTO CLIENT(CIN,nomC,prenomC,villeC)
VALUES ('A145','El Balouki','Hassan','Rabat'),
('F7854','Oumani','Soukaina','Fes'),
('S458','Zarood','Wafaa','Casablanca');

/*Creer Les Tableau*/
CREATE TABLE AGENT(numA INT ,nomA VARCHAR(20),villeA VARCHAR(20), PRIMARY KEY(numA));


/*ajouter  Les Valeur dans   la Tableau*/
INSERT  INTO AGENT(numA,nomA,villeA)
VALUES (011,'Attijariwafa Bank','Rabat'),
(102,'Banque populaire','Rabat'),
(120,'BMCI','Casablanca'),
(144,'Banque populaire','Casablanca');

/*Creer Les Tableau*/
CREATE TABLE OPERATION(numOp INT AUTO_INCREMENT ,typeOp VARCHAR(10),dateOp DATE,solde INT ,CIN VARCHAR(10), numA INT, PRIMARY KEY(numOp), CONSTRAINT FOREIGN KEY(CIN) REFERENCES CLIENT(CIN) , CONSTRAINT FOREIGN KEY(numA) REFERENCES  AGENT(numA));

/*ajouter  Les Valeur dans   la Tableau*/
/*numOp est AUTO incrementation alors , c'est facultive a rempli manuelle,  attention pour la date en utilise les griffes '' */
INSERT  INTO OPERATION(typeOp,dateOp,solde,CIN,numA)
VALUES ('retrait','2019-10-01',1000,'F7854',120),
('depot','2019-10-22',9500,'S458',144),
('retrait','2019-12-11',1500,'S458',102);


/*Q3*/
/*Modification du tableu et ajouter le contraint par la mot cle CHECK( Condition ici)*/
ALTER TABLE OPERATION
ADD CONSTRAINT   solde CHECK(solde >= 0) ;

/*Q4*/
SELECT nomC, SUM(solde) as Somme
FROM CLIENT NATURAL JOIN OPERATION
WHERE villeC = 'Rabat'
GROUP BY nomC ;

/*Q5*/

SELECT nomC,prenomC
FROM CLIENT NATURAL JOIN OPERATION 
WHERE typeOp <> 'depot';

/*Q6*/
/*On peut utilise la sous requet*/
SELECT nomA
FROM AGENT 
WHERE  numA in (
                                SELECT  numA
                                FROM OPERATION 
                                WHERE dateOp <  '2019-10-03' and CIN in (
                                                           SELECT CIN
                                                           FROM CLIENT
                                                           WHERE  nomC  like '%i'
                                   
                                )
);
