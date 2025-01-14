USE 090924_Kutushev;
CREATE TABLE Customer(
	customer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    street VARCHAR(100),
    postcode VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50),
    email VARCHAR(150) CHECK(email LIKE '%_@_%._%'),
	created_at DATE DEFAULT (CURDATE())
);

ALTER TABLE Customer
ADD COLUMN last_modified DATE DEFAULT(CURDATE());

ALTER TABLE Customer
ADD COLUMN gender CHAR(1) AFTER lastname;

ALTER TABLE Customer
MODIFY COLUMN gender CHAR(1) DEFAULT "M" CHECK(gender IN ("M","F"));

ALTER TABLE Customer
DROP COLUMN gender;

CREATE TABLE Orders(
	order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    customer_id INTEGER NOT NULL,
	created_at DATETIME DEFAULT (NOW()),
    item_title VARCHAR(100) NOT NULL,
    item_description TEXT,
    item_photo VARCHAR(255),
    total NUMERIC(6,2) NOT NULL
);

ALTER TABLE Orders
ADD COLUMN discounted_price NUMERIC(6,2) DEFAULT (total * 0.9);


-- DROP TABLE Customer;
-- DROP TABLE Orders;

SELECT * FROM Customer;
SELECT * FROM Orders;

-- Вставка данных в таблицу Customer
INSERT INTO Customer (firstname, lastname, street, postcode, city, country, email)
VALUES 
('John', 'Doe', '123 Main St', '10001', 'New York', 'USA', 'johndoe@example.com'),
('Jane', 'Smith', '456 Maple St', '20002', 'Los Angeles', 'USA', 'janesmith@example.com'),
('Alice', 'Johnson', '789 Oak St', '30003', 'Chicago', 'USA', 'alicejohnson@example.com'),
('Bob', 'Brown', '321 Pine St', '40004', 'Houston', 'USA', 'bobbrown@example.com'),
('Eve', 'Davis', '654 Cedar St', '50005', 'Phoenix', 'USA', 'evedavis@example.com');

-- Вставка данных в таблицу Orders
-- Заказы для John Doe (2 заказа)
INSERT INTO Orders (customer_id, item_title, item_description, item_photo, total)
VALUES 
(1, 'Laptop', 'High-performance laptop', 'laptop.jpg', 999.99),
(1, 'Mouse', 'Wireless mouse', 'mouse.jpg', 29.99);

-- Заказы для Jane Smith (3 заказа)
INSERT INTO Orders (customer_id, item_title, item_description, item_photo, total)
VALUES 
(2, 'Smartphone', 'Latest model smartphone', 'smartphone.jpg', 799.99),
(2, 'Headphones', 'Noise-cancelling headphones', 'headphones.jpg', 199.99),
(2, 'Tablet', 'High-resolution tablet', 'tablet.jpg', 499.99);

-- Заказы для Alice Johnson (1 заказ)
INSERT INTO Orders (customer_id, item_title, item_description, item_photo, total)
VALUES 
(3, 'Camera', 'Digital SLR camera', 'camera.jpg', 699.99);

-- Заказы для Bob Brown (4 заказа)
INSERT INTO Orders (customer_id, item_title, item_description, item_photo, total)
VALUES 
(4, 'TV', '4K Ultra HD TV', 'tv.jpg', 1199.99),
(4, 'Soundbar', 'High-quality soundbar', 'soundbar.jpg', 299.99),
(4, 'Gaming Console', 'Next-gen gaming console', 'console.jpg', 499.99),
(4, 'Blu-ray Player', '4K Blu-ray player', 'bluray.jpg', 199.99);

-- Заказы для Eve Davis (2 заказа)
INSERT INTO Orders (customer_id, item_title, item_description, item_photo, total)
VALUES 
(5, 'Printer', 'All-in-one printer', 'printer.jpg', 149.99),
(5, 'Monitor', '27-inch monitor', 'monitor.jpg', 349.99);


USE 090924_Kutushev;

SELECT * FROM Customer;
SELECT * FROM Orders;

-- 1. Вывести все заказы, отсортированные по убыванию по стоимости
SELECT *
FROM Orders
ORDER BY total DESC;

-- 2. Вывести всех заказчиков, у которых почта зарегистриварована на gmail.com
SELECT *
FROM Customer
WHERE email LIKE '%_@gmail.com';

-- 3. Вывести заказы, добавив дополнительный вычисляемый столбец status, который вычисляется 
-- по стоимости заказа и имеет три значения: low, middle, high.
SELECT *,
	CASE
		WHEN total > 700 THEN "high"
        WHEN total > 300 THEN "middle"
        ELSE "low"
    END AS `status`
FROM Orders;

-- 4. Вывести заказчиков по убыванию рейтинга. (etu zadachu mi propustili na uroke)

-- 5. Вывести всех заказчиков из города на ваш выбор.
SELECT *
FROM Customer
WHERE city = "Houston";
	
-- 6.Написать запрос, который вернет самый часто продаваемый товар. (ne sdelali, tak kak wes tovar pokupalsya tolko po odnomu razu)

-- 7. Вывести список заказов и столбец со значением скидки. 
-- (Вывести список заказов с максимальной скидкой. zadacha peredelanna, tak kak vezde 10% discount)
SELECT *, (total - discounted_price) AS discounted
FROM Orders;

-- 8. Ответьте в 1 предложении: как вы определите скидку? 
-- ---  Скидка определяется как разница между нормальной ценой (total) и скидочной ценой (discounted_price) 
-- --- (ya eto skopiroval, tak kak soglasen so skazannim, i ya ochen leniviy)

-- 9. Ответьте в 1 предложении: может ли это быть разница между нормальной ценой и скидочной ценой? 
-- -- Da.


-- 10. Написать запрос, который выведет все заказы с дополнительным столбцом процент_скидки, 
-- который содержит разницу в процентах между нормальной и скидочной ценой
SELECT *, ((total - discounted_price)/ total) * 100 AS discount_procent
FROM Orders;

SELECT *, ROUND(100 - (discounted_price / total * 100),0 ) AS discount_procent
FROM Orders;