-- Sélectionnez tous les champs de `categ` ordonnés par `name` ascendant
SELECT * FROM categ ORDER BY name ASC;


-- Séléctionnez `idcateg` et `name` de `categ` quand `idcateg` vaut 4
SELECT idcateg, name FROM categ WHERE idcateg = 4;

-- Séléctionnez `idcateg` et `name` de `categ` quand `idcateg` se trouve entre 2 et 4
SELECT idcateg, name FROM categ WHERE idcateg BETWEEN 2 AND 4;

-- Séléctionnez `idcateg` et `name` de `categ` quand `idcateg` est 1, 3 ou 5  ordonné par `name` descendant
SELECT idcateg, name FROM categ where idcateg IN (1, 3, 5) ORDER BY name DESC;

-- Séléctionnez tous les champs de `categ` quand `desc` contient 'et' n'importe où dans la chaîne
SELECT * FROM categ where `desc` LIKE '%et%'

-- Séléctionnez tous les champs de `categ` dont l' `idcateg` vaut 5 ainsi que les `idnews` et  `title` de la table `news` qui se trouvent dans cette catégorie, même si il n'y en a pas (présence de `categ` dans tous les cas, 17 lignes de résultats) , ordonnés par `news`.`title` ASC
SELECT * 
FROM categ c 
LEFT JOIN news_has_categ nhc ON c.idcateg = nhc.categ_idcateg 
LEFT JOIN news n ON nhc.news_idnews = n.idnews 
WHERE c.idcateg = 5 
ORDER BY n.title ASC;


-- Séléctionnez tous les champs de `categ` dont l' `idcateg` vaut 5 ainsi que les `idnews` et  `title` de la table `news` qui se trouvent dans cette catégorie, même si il n'y en a pas (présence de `categ` dans tous les cas, 6 lignes de résultats) , ordonnés par `news`.`title` ASC ET que `news`.`visible` vaut 1 !
SELECT *
FROM categ c
LEFT JOIN news_has_categ nhc ON c.idcateg = nhc.categ_idcateg
LEFT JOIN news n ON nhc.news_idnews = n.idnews
WHERE c.idcateg = 5
AND n.visible = 1
ORDER BY n.title ASC;


-- Séléctionnez tous les champs de `categ` dont l' `idcateg` vaut 5 ainsi que les `idnews` (concaténés sur une seul ligne avec la ',' comme séparateur) et  `title` (concaténés sur une seul ligne avec '|||' comme séparateur) de la table `news` qui se trouvent dans cette catégorie, même si il n'y en a pas (présence de `categ` dans tous les cas, 1 ligne de résultats) ,  ET que `news`.`visible` vaut 1 !
SELECT c.*, GROUP_CONCAT(n.idnews) as idnews, GROUP_CONCAT(n.title SEPARATOR '|||') as title
FROM categ c
LEFT JOIN news_has_categ nhc ON c.idcateg = nhc.categ_idcateg
LEFT JOIN news n ON nhc.news_idnews = n.idnews
WHERE c.idcateg = 5
AND n.visible = 1
ORDER BY n.title ASC;


-- Séléctionnez `idnews` et `title` de la table `news` lorsque le `title` commence par 'c' (7 résultats)
SELECT idnews, title FROM news WHERE title LIKE 'c%';
-- Séléctionnez `idnews` et `title` de la table `news` lorsque le `title` commence par 'a' et `visible` vaut 1 (10 résultats)
SELECT idnews, title FROM news WHERE title LIKE 'a%' AND visible = 1;
-- Séléctionnez `idnews` et `title` de la table `news`, ainsi que les `iduser` et `login` de la table `user` (seulement si il y a une jointure)  lorsque le `title` commence par 'a' et `visible` vaut 1 (10 résultats)
SELECT n.idnews, n.title, u.iduser, u.login
FROM news n
LEFT JOIN user u ON n.user_iduser = u.iduser
WHERE n.title LIKE 'a%' AND n.visible = 1;

-- Séléctionnez  `idnews` et `title` de la table `news`, ainsi que les `iduser` et `login` de la table `user` (seulement si il y a une jointure)  lorsque le `title` commence par 'a' et `visible` vaut 1 , classés par `user`.`login` ascendant (10 résultats)
SELECT n.idnews, n.title, u.iduser, u.login
FROM news n
LEFT JOIN user u ON n.user_iduser = u.iduser
WHERE n.title LIKE 'a%' AND n.visible = 1
ORDER BY u.login ASC;

-- Séléctionnez  `idnews` et `title` de la table `news`, ainsi que les `iduser` et `login` de la table `user` (seulement si il y a une jointure)  lorsque le `title` commence par 'a' et `visible` vaut 1 , classés par `user`.`login` ascendant en ne gardant que les 3 premiers résultats (3 résultats)
SELECT n.idnews, n.title, u.iduser, u.login
FROM news n
LEFT JOIN user u ON n.user_iduser = u.iduser
WHERE n.title LIKE 'a%' AND n.visible = 1
ORDER BY u.login ASC
LIMIT 3;
-- Séléctionnez  `idnews` et `title` de la table `news`, ainsi que les `iduser` et `login` de la table `user` (seulement si il y a une jointure)  lorsque le `title` commence par 'a' et `visible` vaut 1 , classés par `user`.`login` ascendant en ne gardant que les 3 derniers résultats (3 résultats)
SELECT n.idnews, n.title, u.iduser, u.login
FROM news n
LEFT JOIN user u ON n.user_iduser = u.iduser
WHERE n.title LIKE 'a%' AND n.visible = 1
ORDER BY u.login ASC
LIMIT 3 OFFSET 7; 


--VERSION 2
/* SELECT * FROM (
  SELECT n.idnews, n.title, u.iduser, u.login
  FROM news n
  LEFT JOIN user u ON n.user_iduser = u.iduser
  WHERE n.title LIKE 'a%' AND n.visible = 1
  ORDER BY u.login DESC
  LIMIT 3
) sub
ORDER BY login ASC; */

-- Sélectionnez `iduser` et `login` de la table `user`, avec le nombre d'articles écrit par chacun renommé `nbarticles`, classés par `nbarticles` descendant et en n'en gardant que les 5 premiers (5 résultats)

SELECT u.iduser, u.login, COUNT(n.idnews) AS nbarticles
FROM user u
LEFT JOIN news n ON u.iduser = n.user_iduser
GROUP BY u.iduser, u.login
ORDER BY nbarticles DESC
LIMIT 5;

