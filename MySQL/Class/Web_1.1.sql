USE hr;

SELECT *
FROM employees;

-- 1. Найти всех сотрудников, c job_id = IT_PROG
SELECT *
FROM employees
WHERE job_id = "IT_PROG";

-- 2. Найти сотрудников, с зп больше 10 000
SELECT *
FROM employees
WHERE salary > 10000;

-- 3. Найти сотрудников, с зп от 10 000 до 20 000 (включая концы)
SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

SELECT *
FROM employees
WHERE salary >= 10000 AND salary <= 20000;

-- 4. Найти сотрудников не из 60, 30 и 100 департамента
SELECT *
FROM employees
WHERE department_id NOT IN (60,30,100);

-- 5. Найти сотрудников у которых есть две буквы ll подряд в середине имени
SELECT *
FROM employees
WHERE first_name LIKE "%_ll_%";

-- 6. Найти сотрудников, у которых фамилия кончается на a)
SELECT *
FROM employees
WHERE last_name LIKE "%_a";