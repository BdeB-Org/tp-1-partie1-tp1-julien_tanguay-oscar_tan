--1. r�digez les requ�tes qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_OUTIL;
DESC OUTILS_USAGER;
DESC OUTILS_EMPRUNT;
 
--2. r�digez la requ�te qui affiche la liste de tous les usagers, sous le format pr�nom ��espace�� nom de famille (indice�: concat�nation). /2
SELECT 
prenom AS "pr�nom",
nom_famille AS "nom"
FROM outils_usager;
 
--3. r�digez la requ�te qui affiche le nom des villes o� habitent les usagers, en ordre alphab�tique, le nom des villes va appara�tre seulement une seule fois. /2 
SELECT DISTINCT
ville AS "ville"
FROM outils_usager
ORDER BY ville ASC;
 
--4. r�digez la requ�te qui affiche toutes les informations sur tous les outils en ordre alphab�tique sur le nom de l�outil puis sur le code. /2
SELECT * 
FROM outils_outil
ORDER BY nom ASC;
 
--5. r�digez la requ�te qui affiche le num�ro des emprunts qui n�ont pas �t� retourn�s. /2
SELECT num_emprunt AS "numero" 
FROM outils_emprunt
WHERE date_retour IS NULL;
 
--6. r�digez la requ�te qui affiche le num�ro des emprunts faits avant 2014. /3
SELECT num_emprunt AS "numero" 
FROM outils_emprunt
WHERE SUBSTR(date_emprunt, 1, 2) < '14';
 
--7. r�digez la requ�te qui affiche le nom et le code des outils dont la couleur d�but par la lettre ��j�� (indice�: utiliser UPPER() et LIKE) /3
SELECT nom AS "nom",
code_outil AS "code"
FROM OUTILS_OUTIL
WHERE caracteristiques LIKE '%, j%';
 
--8. r�digez la requ�te qui affiche le nom et le code des outils fabriqu�s par Stanley. /2
SELECT nom,
code_outil
FROM outils_outil
WHERE fabricant = 'Stanley';

--9. r�digez la requ�te qui affiche le nom et le fabricant des outils fabriqu�s de 2006 � 2008 (ANNEE). /2
SELECT nom AS "nom",
fabricant AS "fabricant"
FROM OUTILS_OUTIL
WHERE annee >= 2006 AND annee <= 2008;

--10. r�digez la requ�te qui affiche le code et le nom des outils qui ne sont pas de ��20 volt��. /3
SELECT nom AS "nom",
code_outil AS "code"
FROM OUTILS_OUTIL
WHERE caracteristiques NOT LIKE '%20 volt%';
 
--11. r�digez la requ�te qui affiche le nombre d�outils qui n�ont pas �t� fabriqu�s par Makita. /2
SELECT COUNT(*) AS nombre
FROM OUTILS_OUTIL
WHERE fabricant <> 'Makita';

-- 12.  r�digez la requ�te qui affiche les emprunts des clients de vancouver et regina. il faut afficher le nom complet de l�usager, le num�ro d�emprunt, la dur�e de l�emprunt et le prix de l�outil (indice : n�oubliez pas de traiter le null possible (dans les dates et le prix) et utilisez le in). /5
SELECT u.nom_famille || ' ' || u.prenom AS "Nom complet", e.num_emprunt, (e.date_retour - e.date_emprunt) AS "Dur�e", o.prix
FROM outils_emprunt e
JOIN outils_usager u ON e.num_usager = u.num_usager
JOIN outils_outil o ON e.code_outil = o.code_outil
WHERE u.ville IN ('Vancouver', 'Regina');

-- 13.  r�digez la requ�te qui affiche le nom et le code des outils emprunt�s qui n�ont pas encore �t� retourn�s. /4
SELECT o.nom, o.code_outil 
FROM outils_outil o
JOIN outils_emprunt e ON o.code_outil = e.code_outil 
WHERE e.date_retour IS NULL;

-- 14.  r�digez la requ�te qui affiche le nom et le courriel des usagers qui n�ont jamais fait d�emprunts. (indice : in avec sous-requ�te) /3
SELECT nom_famille, courriel FROM outils_usager
WHERE num_usager NOT IN (SELECT DISTINCT num_usager FROM outils_emprunt);

-- 15.  r�digez la requ�te qui affiche le code et la valeur des outils qui n�ont pas �t� emprunt�s. (indice : utiliser une jointure externe � left outer, aucun null dans les nombres) /4
SELECT o.code_outil, o.prix FROM outils_outil o
LEFT OUTER JOIN outils_emprunt e ON o.code_outil = e.code_outil
WHERE e.num_emprunt IS NULL;

-- 16.  r�digez la requ�te qui affiche la liste des outils (nom et prix) qui sont de marque makita et dont le prix est sup�rieur � la moyenne des prix de tous les outils. remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT nom, NVL(prix, (SELECT AVG(prix) FROM outils_outil)) AS prix
FROM outils_outil
WHERE fabricant = 'Makita' AND prix > (SELECT AVG(prix) FROM outils_outil);

-- 17.  r�digez la requ�te qui affiche le nom, le pr�nom et l�adresse des usagers et le nom et le code des outils qu�ils ont emprunt�s apr�s 2014. tri�s par nom de famille. /4
SELECT u.nom_famille, u.prenom, u.adresse, o.nom, o.code_outil
FROM outils_emprunt e
JOIN outils_usager u ON e.num_usager = u.num_usager
JOIN outils_outil o ON e.code_outil = o.code_outil
WHERE e.date_emprunt > TO_DATE('2014-12-31', 'YYYY-MM-DD')
ORDER BY u.nom_famille;

-- 18.  r�digez la requ�te qui affiche le nom et le prix des outils qui ont �t� emprunt�s plus qu�une fois. /4
SELECT o.nom, o.prix FROM outils_outil o
JOIN outils_emprunt e ON o.code_outil = e.code_outil
GROUP BY o.nom, o.prix
HAVING COUNT(e.num_emprunt) > 1;

-- 19.  r�digez la requ�te qui affiche le nom, l�adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6
--  Une jointure
SELECT U.NOM_FAMILLE, U.ADRESSE, U.VILLE
FROM OUTILS_USAGER U
JOIN OUTILS_EMPRUNT E ON U.NUM_USAGER = E.NUM_USAGER;

--  IN
SELECT NOM_FAMILLE, ADRESSE, VILLE
FROM OUTILS_USAGER
WHERE NUM_USAGER IN (SELECT NUM_USAGER FROM OUTILS_EMPRUNT);

--  EXISTS
SELECT NOM_FAMILLE, ADRESSE, VILLE
FROM OUTILS_USAGER U
WHERE EXISTS (SELECT 1 FROM OUTILS_EMPRUNT E WHERE E.NUM_USAGER = U.NUM_USAGER);

-- 20.  r�digez la requ�te qui affiche la moyenne du prix des outils par marque. /3
SELECT fabricant, AVG(prix) AS "Prix Moyen"
FROM outils_outil
GROUP BY fabricant;

-- 21.  r�digez la requ�te qui affiche la somme des prix des outils emprunt�s par ville, en ordre d�croissant de valeur. /4
SELECT u.ville, SUM(o.prix) AS "Somme des prix"
FROM outils_emprunt e
JOIN outils_usager u ON e.num_usager = u.num_usager
JOIN outils_outil o ON e.code_outil = o.code_outil
GROUP BY u.ville
ORDER BY "Somme des prix" DESC;

-- 22.  r�digez la requ�te pour ins�rer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO outils_outil (code_outil, nom, fabricant, caracteristiques, annee, prix)
VALUES ('xx123', 'Nouvel Outil', 'Nouveau Fabricant', 'Description, couleur, etc.', 2024, 500);

-- 23.  r�digez la requ�te pour ins�rer un nouvel outil en indiquant seulement son nom, son code et son ann�e. /2
INSERT INTO outils_outil (code_outil, nom, annee)
VALUES ('yy456', 'Autre Outil', 2024);

-- 24.  r�digez la requ�te pour effacer les deux outils que vous venez d�ins�rer dans la table. /2
DELETE FROM outils_outil WHERE code_outil IN ('xx123', 'yy456');

-- 25.  r�digez la requ�te pour modifier le nom de famille des usagers afin qu�ils soient tous en majuscules. /2
UPDATE outils_usager SET nom_famille = UPPER(nom_famille);


