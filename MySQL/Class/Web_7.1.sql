USE hr;

SELECT * FROM employees;

SELECT COUNT(*) AS total_empl
FROM employees;

SELECT COUNT(department_id)
FROM employees;

SELECT SUM(salary) AS total_salary
FROM employees;

SELECT MAX(salary) AS max_salary
FROM employees;

SELECT MIN(salary) AS min_salary
FROM employees;

SELECT ROUND(AVG(salary), 2) AS avg_salary
FROM employees;

SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
	SELECT MAX(salary)
    FROM employees
);

#########################

USE hr;

-- 1. Найти самую высокую зарплату
SELECT MAX(salary) AS max_salary
FROM employees;

-- 2. Найти количество сотрудников
SELECT COUNT(*) AS total_empl
FROM employees;

-- 3. Найти имя и фамилию сотрудника с самой высокой зарплатой
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
	SELECT MAX(salary)
    FROM employees
);

-- 4. Найти среднюю зарплату по компании
SELECT ROUND(AVG(salary), 2) AS avg_salary
FROM employees;

-- 5. Найти сотрудников, у которых зарплата меньше средней зарплаты по компании
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (
	SELECT AVG(salary)
    FROM employees
);

-- 6. Найти общее количество департаментов.
select count(*) as departments_cnt
from departments;

-- 7. Найти количество департаментов, в которых никто не работает
SELECT *
FROM departments d
LEFT JOIN employees e
	ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- 8. Найти количество сотрудников из департамента с айди 100, которые зарабатывают более 5000
SELECT COUNT(*) empl_count
FROM employees
WHERE department_id = 100 AND salary > 5000;

################

-- Посчитаем количество сотрудников в каждом отделе (выведем номер отдела и количество сотрудников)
SELECT department_id, COUNT(*) AS total_empl
FROM employees
GROUP BY department_id
HAVING department_id IS NOT NULL;

-- Можно с помощью join вывести названия отделов и количество сотрудников в каждом
SELECT d.department_name, COUNT(*) AS total_empl
FROM employees e
JOIN departments d
	ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Найдите имена и фамилии сотрудников с максимальной зарплатой в каждом департаменте
SELECT e.first_name, e.last_name, e.salary, ms.max_salary_for_dep
FROM employees e
JOIN (
	SELECT department_id, MAX(salary) AS max_salary_for_dep
	FROM employees
	GROUP BY department_id
) ms
	ON e.department_id = ms.department_id
WHERE e.salary = ms.max_salary_for_dep;

-- 2. Выведите среднюю (максимальную, минимальную) зарплату по отделу.
SELECT department_id,
	ROUND(AVG(salary), 2) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM employees
GROUP BY department_id
HAVING department_id IS NOT NULL;