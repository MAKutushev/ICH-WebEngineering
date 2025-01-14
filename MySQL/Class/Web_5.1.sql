USE 090924_Kutushev;

SHOW TABLES;	-- Показывает названия всех таблиц в БД

DESCRIBE Customer;	-- Показывает метаданные таблицы

SHOW CREATE TABLE Customer;

DROP TABLE goods;

-- Создать таблицу goods с полями
-- id (первичный ключ)
-- title (cтрока максимум в 30 байт)
-- quantity (число больше 0)
-- in_stock (символ (Y/N)

CREATE TABLE goods(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(30) NOT NULL,
quantity INTEGER CHECK(quantity > 0),
in_stock CHAR(1) DEFAULT "-" CHECK(in_stock IN ("Y","N","-"))
);

SELECT * FROM goods;
DESCRIBE goods;

INSERT INTO goods(title, quantity, in_stock)
VALUES
('Laptop', 10, 'Y'),
('Mouse', 25, 'Y'),
('Keyboard', 15, 'Y'),
('Monitor', 5, 'Y'),
('Printer', 8, 'Y'),
('Smartphone', 20, 'Y'),
('Tablet', 12, 'N'),
('Headphones', 30, 'Y'),
('Camera', 7, 'N'),
('Gaming Console', 4, 'Y');

-- Создать таблицу goods_2 с полями:
-- id (уникальное значение)
-- title (cтрока максимум 30 символов)
-- quantity (число больше 0)
-- price (целое число)
-- in_stock (символ (Y/N))

CREATE TABLE goods_2(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(30) NOT NULL,
quantity INTEGER CHECK(quantity > 0),
price INTEGER,
in_stock CHAR(1) DEFAULT "-" CHECK(in_stock IN ("Y","N","-"))
);

 INSERT INTO goods_2 (title, quantity, price, in_stock)
 VALUES 
 ('Laptop', 50,  1000, 'Y'), 
 ('Smartphone', 30, 800, 'Y'), 
 ('Tablet', 20, 50,'N'), 
 ('Monitor', 15, 1200, 'Y');
 
 
 SELECT * FROM goods_2;
 
SELECT title FROM goods
UNION
SELECT title FROM goods_2;

SELECT title, quantity FROM goods
UNION
SELECT title, quantity FROM goods_2;
 
 
SELECT title, quantity, in_stock, price FROM goods_2
UNION
SELECT title, quantity, in_stock, NULL FROM goods;