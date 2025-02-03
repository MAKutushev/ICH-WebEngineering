USE 090924_Kutushev;

SHOW TABLES;

CREATE TABLE IF NOT EXISTS tbl1 (
  id INT PRIMARY KEY AUTO_INCREMENT,
  value VARCHAR(255)
);
INSERT INTO tbl1
VALUES (1, 'fst1'), 
	   (2, 'fst2'), 
	   (3, 'fst3');

CREATE TABLE IF NOT EXISTS tbl2 (
  id INT PRIMARY KEY AUTO_INCREMENT,
  value VARCHAR(255)
);

INSERT INTO tbl2 
VALUES (1, 'snd1'), 
	   (2, 'snd2'), 
	   (3, 'snd3');

-- Посмотрим содержимое таблиц
SELECT * FROM tbl1;
SELECT * FROM tbl2;

SELECT * FROM tbl1 t1
CROSS JOIN tbl2 t2;

SELECT *
FROM Orders o
INNER JOIN Customer c
	ON o.customer_id = c.customer_id;
    
SELECT o.order_id, c.lastname, c.firstname, o.created_at
FROM Orders o
INNER JOIN Customer c
	ON o.customer_id = c.customer_id;
    
USE hr;

SHOW TABLES;

-- 1. Вывести имя и фамилию сотрудника и название его департамента

SELECT e.first_name, e.last_name, d.department_name
FROM  employees e
JOIN departments d
	ON e.department_id = d.department_id;
    
-- 2. Вывести имя и фамилию и название департамента только тех сотрудников, которые работают в IT, Treasury или IT Support
SELECT e.first_name, e.last_name, d.department_name
FROM  employees e
JOIN departments d
	ON e.department_id = d.department_id
    WHERE d.department_name = "IT" OR d.department_name = "Treasury" OR d.department_name = "IT Support";
    
-- 2. Вывести имя и фамилию и название департамента только тех сотрудников, которые работают в IT, Treasury или IT Support (2 more variants)
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d
	ON e.department_id = d.department_id
WHERE d.department_name IN ('IT', 'Treasury', 'IT Support');

SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d
	ON e.department_id = d.department_id AND d.department_name IN ('IT', 'Treasury', 'IT Support');
    
-- 3. Вывести имя и фамилию сотрудника и имя и фамилию его менеджера
SELECT e.first_name, e.last_name, m.first_name, m.last_name
FROM employees e
INNER JOIN employees m
	ON e.manager_id = m.employee_id;
    
-- 3. Вывести имя и фамилию сотрудника и имя и фамилию его менеджера (dop var)
SELECT e.first_name, e.last_name, m.first_name AS manager_name, m.last_name AS manager_lastname
FROM employees e
JOIN employees m
	ON e.manager_id = m.employee_id;
    
-- 4. Вывести job_id тех сотрудников, которые зарабатывают больше своего менеджера
SELECT e.job_id, e.first_name, e.last_name, m.first_name AS manager_name, m.last_name AS manager_lastname
FROM employees e
JOIN employees m
	ON e.manager_id = m.employee_id
    WHERE e.salary > m.salary;
    
-- 5. Вывести имя, фамилию и город сотрудников, которые работают в Seattle или Toronto
SELECT e.first_name, e.last_name, l.city
FROM employees e
JOIN departments d
	ON e.department_id = d.department_id
JOIN locations l
	ON d.location_id = l.location_id
    WHERE l.city IN("Seattle", "Toronto");
    
-- 6. Выведите названия департаментов, в которых менеджеры зарабатывают больше 10000
SELECT d.department_name
FROM  departments d
JOIN employees e
	ON d.manager_id = e.employee_id
    WHERE e.salary > 10000;

-- 7. Вывести имя, фамилию, название департамента и название должности сотрудника
SELECT e.first_name, e.last_name, d.department_name, j.job_title
FROM employees e
JOIN departments d
	ON e.department_id = d.department_id
JOIN jobs j
	ON e.job_id = j.job_id;

-- 8. Выведите имя и фамилию сотрудника и название его департамента.
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.department_id
UNION
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
RIGHT JOIN departments d
	ON e.department_id = d.department_id;

-- FULL OUTER JOIN (deleted from mySQL?!)
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.department_id
UNION
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
RIGHT JOIN departments d
	ON e.department_id = d.department_id;


SHOW TABLES;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM jobs;

-- FROM (выбор таблицы)
-- JOIN (комбинация с подходящими по условию данными из других таблиц)
-- WHERE (фильтрация строк)
-- GROUP BY (агрегирование данных)
-- HAVING (фильтрация агрегированных данных)
-- SELECT (возврат результирующего датасета)
-- ORDER BY (сортировка).

-- #####################################################################

USE shop;

-- 1. Выведите имена всех продавцов. Предусмотрите также в выборке имена их боссов, сформировав атрибут boss_name. 
-- В выборке должно присутствовать два атрибута — sname, boss_name.
SELECT s.SNAME, b.SNAME AS boss_name
FROM SELLERS s
LEFT JOIN SELLERS b
	ON s.BOSS_ID = b.SELL_ID;

-- 2. Выведите имена покупателей, которые совершили покупку на сумму больше 1000 условных единиц.
-- В выборке должно присутствовать два атрибута — cname, amt.
select c.cname, sum(o.amt)
from CUSTOMERS c
JOIN ORDERS o
	ON c.CUST_ID = o.CUST_ID
group by c.cname
having sum(o.amt) > 1000;

-- 3. Выведите имена покупателей, которые сделали заказ. Предусмотрите в выборке также имена продавцов.
-- Покупатели и продавцы должны быть из разных городов. В выборке должно присутствовать два атрибута — cname, sname.
SELECT c.CNAME, s.SNAME
FROM CUSTOMERS c
JOIN ORDERS o
	ON c.CUST_ID = o.CUST_ID
JOIN SELLERS s
	ON s.SELL_ID = o.SELL_ID
WHERE c.CITY <>  s.CITY; -- <> = ne rovno (not equal)

-- 4. Для каждого сотрудника выведите разницу между коммисионными его босса и его собственными. 
-- Если у сотрудника босса нет, выведите NULL.
-- Вывести : sname, difference.
SELECT s.SNAME, (b.COMM - s.COMM) AS difference
FROM SELLERS s
LEFT JOIN SELLERS b
	ON s.BOSS_ID = b.SELL_ID;
    

-- 5. Выведите пары покупателей и обслуживших их продавцов из одного города.
-- Вывести: sname, cname, city
SELECT s.SNAME, c.CNAME, c.CITY
FROM CUSTOMERS c
JOIN ORDERS o
	ON c.CUST_ID = o.CUST_ID
JOIN SELLERS s
	ON s.SELL_ID = o.SELL_ID
WHERE c.CITY = s.CITY;

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM SELLERS;

SHOW TABLES;