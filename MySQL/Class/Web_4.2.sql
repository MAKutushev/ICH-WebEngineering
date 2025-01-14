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

-- 4. Вывести всех заказчиков из города на ваш выбор.
SELECT *
FROM Customer
WHERE city = "Houston";

 -- 5. Вывести список заказов и столбец со значением скидки.
SELECT *, (total - discounted_price) AS discounted
FROM Orders;

-- 6. Написать запрос, который выведет все заказы с дополнительным столбцом процент_скидки, 
-- который содержит разницу в процентах между нормальной и скидочной ценой
SELECT *, ((total - discounted_price)/ total) * 100 AS discount_procent
FROM Orders;

SELECT *, ROUND(100 - (discounted_price / total * 100),0 ) AS discount_procent
FROM Orders;