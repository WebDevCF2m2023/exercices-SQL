-- Sélection de tous les champs de la table categ
SELECT
  *
FROM
  categ;
-- Sélection de toutes les news
SELECT
  *
FROM
  news;
-- Sélection de toutes les news lorsque 'news.visible' vaut 1
SELECT
  *
FROM
  news
WHERE
  news.visible = 1;
-- Sélection de toutes les permissions
SELECT
  *
FROM
  permission;

-- Sélection de tous les champs d'utilisateurs
SELECT
  *
FROM
  `user`;

-- Sélection de tous les champs d'utilisateurs avec le champs 'name' venant de permission
  -- En jointure interne ! 'name' étant présent 2x, il faut utiliser un alias 'AS permission_name'
SELECT
  `user`.*,
  `permission`.`name` AS permission_name
FROM
  `user`
  INNER JOIN `permission` ON `user`.`permission_idpermission` = `permission`.`idpermission`;

  
-- Sélection de tous les champs d'utilisateurs sauf permission_idpermission et pwd
  -- avec le champs 'name' venant de permission renommé en 'permission_name'
  -- En jointure interne !
SELECT
  `user`.`iduser`,
  `user`.`login`,
  `user`.`name`,
  `permission`.`name` AS permission_name
FROM
  `user`
  INNER JOIN `permission` ON `user`.`permission_idpermission` = `permission`.`idpermission`;
-- Sélectionner 'name' des permissions et le nombre d'auteurs qui se trouvent dans chacune 'nb_user', dans ce cas une permission sans utilisateur ne fonctionnera pas
SELECT
  p.name,
  COUNT(u.permission_idpermission) AS nb_user
FROM
  user u
  INNER JOIN permission p ON p.idpermission = u.permission_idpermission
GROUP BY
  u.permission_idpermission;
-- Sélectionner 'name' des permissions et le nombre d'auteurs qui se trouvent dans chacune 'nb_user' et que l'on souhaite avoir les permissions qui n'ont pas d'auteurs,
SELECT
  p.name,
  COUNT(u.permission_idpermission) AS nb_user
FROM
  user u
  RIGHT JOIN permission p ON p.idpermission = u.permission_idpermission
GROUP BY
  u.permission_idpermission;
-- Sélectionner le title et publication de la table news lorsqu'elles sont sorties entre 1-1-2019 et le 1-1-2020
SELECT
  title,
  publication
FROM
  news
WHERE
  publication BETWEEN '2019-01-01'
  AND '2020-01-01';
SELECT
  title,
  publication
FROM
  news
WHERE
  publication BETWEEN '2019-01-01 00:00:00'
  AND '2020-01-01 00:00:00';
-- Sélectionner le title et publication de la table news lorsqu'elles sont sorties entre 1-1-2019 et le 1-1-2020 et qu'elles sont publiées
SELECT
  title,
  publication
FROM
  news
WHERE
  publication BETWEEN '2019-01-01 00:00:00'
  AND '2020-01-01 00:00:00'
  AND visible = 1;
-- Sélectionner le title et publication de la table news, en récupérant le login de l'auteur lorsqu'elles sont sorties entre 1-1-2019 et le 1-1-2020 et qu'elles sont publiées
SELECT
  n.title,
  n.publication,
  u.login
FROM
  news n
  INNER JOIN user u ON n.user_iduser = u.iduser
WHERE
  n.publication BETWEEN '2019-01-01 00:00:00'
  AND '2020-01-01 00:00:00'
  AND n.visible = 1;
-- Sélectionner le title et publication de la table news, en récupérant le login de l'auteur lorsqu'elles sont sorties entre 1-1-2019 et le 1-1-2020 et qu'elles sont publiées ordonnés par la date ascendante
SELECT
  n.title,
  n.publication,
  u.login
FROM
  news n
  INNER JOIN user u ON n.user_iduser = u.iduser
WHERE
  n.publication BETWEEN '2019-01-01 00:00:00'
  AND '2020-01-01 00:00:00'
  AND n.visible = 1
ORDER BY
  n.publication ASC;
-- Sélectionner l'idnews, le title et publication de la table news, en récupérant l'iduser et le login de l'auteur lorsqu'elles sont sorties entre 1-1-2019 et le 1-1-2020 et qu'elles sont publiées, ordonnés par la date ascendante
SELECT
  n.idnews,
  n.title,
  n.publication,
  u.iduser,
  u.login
FROM
  news n
  INNER JOIN user u ON n.user_iduser = u.iduser
WHERE
  n.publication BETWEEN '2019-01-01 00:00:00'
  AND '2020-01-01 00:00:00'
  AND n.visible = 1
ORDER BY
  n.publication ASC;
-- Sélectionner l'idnews, le title et publication de la table news, en récupérant l'iduser et le login de l'auteur lorsqu'elles sont sorties entre 1-1-2019 et le 1-1-2020 et qu'elles sont publiées, et tous les idcateg et name de categ lorsque les articles sont dedans (jointure externe, un article sans catégorie doit apparaître), ordonnés par la date ascendante
SELECT
  n.idnews,
  n.title,
  n.publication,
  u.iduser,
  u.login,
  c.idcateg,
  c.name
FROM
  news n
  INNER JOIN user u ON n.user_iduser = u.iduser
  LEFT JOIN news_has_categ h ON n.idnews = h.news_idnews
  LEFT JOIN categ c ON h.categ_idcateg = c.idcateg
WHERE
  n.publication BETWEEN '2019-01-01 00:00:00'
  AND '2020-01-01 00:00:00'
  AND n.visible = 1
ORDER BY
  n.publication ASC;
-- Sélectionner l'idnews, le title et publication de la table news, en récupérant l'iduser et le login de l'auteur lorsqu'elles sont sorties entre 1-1-2019 et le 1-1-2020 et qu'elles sont publiées, et tous les idcateg et name de categ lorsque les articles sont dedans (jointure externe, un article sans catégorie doit apparaître), ordonnés par la date ascendante - En groupant le tout pour n'avoir qu'un article par ligne, idcateg étant séparé par des ',' et c.name séparé par '|||' nommé categname
SELECT
  n.idnews,
  n.title,
  n.publication,
  u.iduser,
  u.login,
  GROUP_CONCAT(c.idcateg) AS idcateg,
  GROUP_CONCAT(c.name SEPARATOR '---') AS categname
FROM
  news n
  INNER JOIN user u ON n.user_iduser = u.iduser
  LEFT JOIN news_has_categ h ON n.idnews = h.news_idnews
  LEFT JOIN categ c ON h.categ_idcateg = c.idcateg
WHERE
  n.publication BETWEEN '2019-01-01 00:00:00'
  AND '2020-01-01 00:00:00'
  AND n.visible = 1
GROUP BY
  n.idnews
ORDER BY
  n.publication ASC;
-- Insérer un utilisateur avec le login "Zoup", le pwd "pouz", le name "Jojo" la permission Admin (1)
INSERT INTO
  user (
    login,
    pwd,
    name,
    permission_idpermission
  )
VALUES
  ('Zoup', 'pouz', 'Jojo', 1);