-- Важность условных операторов
-- ● Фильтрация данных
-- ● Вычисления на основе условий
-- ● Изменение данных
-- ● Сложные запросы

-- Оператор if
-- SELECT IF(500<1000, "YES", "NO"); —YES

-- Оператор Case
-- это оператор, который позволяет сформировать
-- значение в зависимости от условия. 


-- 1. Сформировать поле SALARY_GROUP которое принимает
-- a. значение 1, если зп сотрудника больше 10000
-- b. значение 0, если зп сотрудника меньше 10000 

SELECT first_name, last_name, salary,
	CASE
		WHEN salary > 10000 THEN 1
        WHEN salary < 10000 THEN 0
        ELSE -1
	END AS SALARY_GROUP
FROM employees;

-- Оператор distinct
-- Позволяет убрать дубли у запроса, это достаточно
-- мощный инструмент, однако использовать его нужно
-- только в уместных случаях: для нахождения дублей,
-- distinct прежде сортирует записи, а сортировка очень
-- ресурсозатратный процесс.

/* Оператор distinct */
SELECT first_name FROM employees;
SELECT DISTINCT first_name
FROM employees;

-- Задание №1
-- Найти сумму зарплат тех сотрудников, которые зарабатывают больше 10000.
-- Решите задачу через CASE

SELECT SUM(
	CASE 
		WHEN salary > 10000 THEN salary
        ELSE 0
	END) AS total
FROM employees;

-- Задание №2
-- Найти сумму зарплат тех сотрудников, которые зарабатывают больше 10000.
-- Решите задачу через WHERE

SELECT sum(salary) AS total
FROM employees
WHERE salary > 10000;

-- Задание №3
-- Найти сумму зарплат тех сотрудников, которые зарабатывают больше 10000.
-- С использованием IF

SELECT SUM(
IF(salary > 10000,salary , 0)
) AS total
FROM employees;

-- Задание №4
-- Найти среднюю зарплату тех сотрудников, которые зарабатывают меньше 10000. 

-- CASE
SELECT ROUND( AVG(
	CASE 
		WHEN salary < 10000 THEN salary
        ELSE NULL
	END), 2)AS average
FROM employees;

-- WHERE
SELECT ROUND(AVG(salary),2) AS average
FROM employees
WHERE salary < 10000;

-- IF
SELECT round(avg(
IF(salary < 10000, salary , NULL)
),2) AS average
FROM employees;

-- Задание №6
-- Найти департаменты в которых есть работники, зарабатывающие больше 10 000. 
-- В результате выборки формируются два поля (department_id и поле со значениями 1 или 0).
-- После, выведите количество таких департаментов.

SELECT 
IF(salary > 10000, department_id, 0)
FROM employees;

SELECT COUNT(DISTINCT department_id) AS rich_departs
FROM employees
WHERE salary > 10000;

-- Задание №7
-- Разделите самолеты на ближне-, средне- и
-- дальнемагистральные. Ближнемагистральными
-- будем считать самолеты, дальность полета
-- которых > 1000 км и <= 2500 км.
-- Среднемагистральными — с дальностью полета >
-- 2500 км и <= 6000 км. Дальнемагистральными — с
-- дальностью полета > 6000 км. В выборке должно
-- быть два столбца, где в первом указана модель
-- самолета. Во втором, category, — категория, со
-- значениями short-haul, medium-haul, long-haul
-- (ближне-, средне- и дальнемагистральные
-- соответственно). Каждый самолет точно попадает
-- ровно в одну категорию.
-- В выборке должны присутствовать два атрибута —
-- model_name, category.
USE airport;

SELECT model_name,
	CASE
		WHEN `range` > 1000 AND `range` <= 2500 THEN "short-haul"
        WHEN `range` > 2500 AND `range` <= 6000 THEN "medium-haul"
        WHEN `range` > 6000 THEN "long-haul"
        ELSE "unknown"
	END AS category
FROM airliners;

-- Задание №8
/* Выведите данные о билетах разной ценовой
категории. Среди билетов экономкласса
(Economy) добавьте в выборку билеты с ценой от
10 000 до 11 000 включительно. Среди билетов
комфорт-класса (PremiumEconomy) — билеты с
ценой от 20 000 до 30 000 включительно. Среди
билетов бизнес-класса (Business) — с ценой
строго больше 100 000. В решении необходимо
использовать оператор CASE.
В выборке должны присутствовать три атрибута —
id, service_class, price. */

SELECT * FROM tickets;

SELECT id, service_class, price
FROM tickets
WHERE
	CASE service_class
		WHEN "Economy" THEN price BETWEEN 10000 AND 11000
        WHEN "PremiumEconomy" THEN price BETWEEN 20000 AND 30000
		WHEN "Business" THEN price > 100000
	END;
    
-- Задание №9
/* Руководство авиакомпании снизило цены на
билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и
JQF04Q8I9G. Скидка на билет экономкласса
(Economy) составила 15%, на билет бизнес-класса
(Business) — 10%, а на билет комфорт-класса
(PremiumEconomy) — 20%. Определите цену
билета в каждом сегменте с учетом скидки.
В выборке должны присутствовать три атрибута —
id, trip_id, new_price. */

SELECT id, trip_id,
	CASE service_class
		WHEN "Economy" THEN price * 0.85
        WHEN "PremiumEconomy" THEN price * 0.8
		WHEN "Business" THEN price * 0.9
    END AS new_price
FROM tickets
WHERE trip_id IN ("LL4S1G8PQW", "0SE4S0HRRU", "JQF04Q8I9G");

-- 1 задание (вывести все уникальные job_id)
USE hr;
SELECT * FROM employees;

SELECT DISTINCT job_id AS unique_job_id
FROM employees;

-- 2 задание (найти job_id у которых нет COMMISSION_PCT или зп меньше 3000)

SELECT DISTINCT job_id AS unique_job_id
FROM employees
WHERE COMMISSION_PCT IS NULL OR salary < 3000;

-- 3. Отсортировать сотрудников по фамилии в алфавитном порядке

SELECT last_name
FROM employees
ORDER BY last_name;


-- 4. Отсортировать сотрудников по зарплате - от самой большой зарплаты до самой маленькой

SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;