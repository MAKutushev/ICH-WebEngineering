-- Подключиться к базе данных world (которая находится на удаленном сервере). 
USE world;

-- Посмотреть на таблицы city, country из базы world.
-- В каждой таблице есть поле название (Name) и население (Population). 
-- Поле Name в одной таблице означает название города, а в другой - название страны. 
-- Написать запрос с помощью UNION, который выводит список названий всех городов и стран с их населением. 
-- Итоговая выборка должна содержать два столбца: Name, Population. 
SELECT * FROM city;
SELECT * FROM country;

SELECT Name, Population FROM city
UNION
SELECT Name, Population FROM country;

-- Посмотреть на таблицы в базе world и объяснить ограничения нескольких столбцов - ответить 1 предложением.
SHOW TABLES;
DESCRIBE city;
DESCRIBE country;

-- в таблице  city у id (у которых тип данных INT - целые числа) есть ограничение ввиде PRIMARY KEY, 
-- который являеться уникальным параметром, и также не содержить значение Null, 
-- а также и auto_increment который автоматически заполняет значения в id.
-- ------------
-- Далее работаем на локальном сервере. 
-- Создать новую таблицу citizen, которая содержит следующие поля:
-- уникальное автоинкрементное, номер соц страхования, имя, фамилию и емейл. 

USE 090924_Kutushev;

CREATE TABLE citizen(
 id INT PRIMARY KEY AUTO_INCREMENT,
 SSN INT UNIQUE,
 firstname VARCHAR(50) NOT NULL,
 lastname VARCHAR(50) NOT NULL,
 email VARCHAR(150) CHECK(email LIKE '%_@_%._%')
);

SELECT * FROM citizen;
DESCRIBE citizen;

ALTER TABLE citizen
MODIFY COLUMN SSN INT NOT NULL;

-- На вашем локальном сервере в любой базе создать таблицу без ограничений (любую, можно взять с урока).
SHOW TABLES;
CREATE TABLE HW5(
id INT,
firstname VARCHAR(50),
lastname VARCHAR(50)
);
-- DROP TABLE HW5;
SELECT * FROM HW5;

-- Добавить в таблицу 5 значений. Добавить 3 человека с одинаковыми именами и 2 человека без lastname
INSERT INTO HW5(firstname, lastname)
VALUES
("Albert","Einstein"),
("Albert","Einstein"),
("Albert","Einstein"),
("Onlyname",""),
("Onlyname","");

-- Использовать оператор alter table … modify , чтобы добавить ограничение not null на поле firstname и lastname.
ALTER TABLE HW5
MODIFY COLUMN firstname VARCHAR(50) NOT NULL;
ALTER TABLE HW5
MODIFY COLUMN lastname VARCHAR(50) NOT NULL;
DESCRIBE HW5;

-- Добавить ограничение unique для пары firstname\lastname. 
ALTER TABLE HW5
MODIFY COLUMN firstname VARCHAR(50) UNIQUE;
ALTER TABLE HW5
MODIFY COLUMN lastname VARCHAR(50) UNIQUE;
DESCRIBE HW5;
-- ne rabotaeitl, tak kak:
-- Error Code: 1062. Duplicate entry 'Albert' for key 'HW5.firstname'
-- Error Code: 1062. Duplicate entry 'Einstein' for key 'HW5.lastname'

-- Удалить таблицу из базы и пересоздать ее, модифицировав запрос add table так, 
-- чтобы он учитывал ограничения (см примеры из класса).
DROP TABLE HW5;

CREATE TABLE HW5(
id INT PRIMARY KEY AUTO_INCREMENT,
firstname VARCHAR(50) NOT NULL UNIQUE,
lastname VARCHAR(50) NOT NULL UNIQUE
);

SELECT * FROM HW5;
DESCRIBE HW5;

-- Добавить правильные и неправильные данные (нарушающие и не нарушающие ограничения).
-- pravilniy (hopefully)
INSERT INTO HW5(firstname, lastname)
VALUES
("Albert","Einstein"),
("NeAlbert","NeEinstein"),
("name","family");

SELECT * FROM HW5;

-- ne pravilniy
INSERT INTO HW5(firstname, lastname)
VALUES
("Albert","Einstein");
-- ERROR:
-- Error Code: 1062. Duplicate entry 'Albert' for key 'HW5.firstname'

INSERT INTO HW5(firstname, lastname)
VALUES
("Belfred","Einstein");
-- ERROR:
-- Error Code: 1062. Duplicate entry 'Einstein' for key 'HW5.lastname'


INSERT INTO HW5(firstname, lastname)
VALUES
("","");
-- tut sozdalos pustoye zvachenie.
-- 18:41:45	INSERT INTO HW5(firstname, lastname) VALUES ("","")	1 row(s) affected	0.031 sec

INSERT INTO HW5(firstname, lastname)
VALUES
();
-- ERROR:
-- Error Code: 1136. Column count doesn't match value count at row 1

SELECT * FROM HW5;