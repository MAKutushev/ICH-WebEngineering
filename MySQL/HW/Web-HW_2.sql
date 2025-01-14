USE hr;
-- Используя https://github.com/it-career-hub/MySQL_databases/blob/main/hr_data.sql, вывести список всех сотрудников. ??????????
SELECT * FROM employees;

-- Найти поле с зарплатой сотрудника. 
SELECT salary FROM employees;

-- Используя операторы case/when/end, изменить запрос так, чтобы результатом был только один столбец, назовите его SALARY_GROUP и оно будет принимать значение 1 если зп сотрудника больше 10000 и значение 0, если меньше.
SELECT 
	CASE
		WHEN salary > 10000 THEN 1
        WHEN salary < 10000 THEN 0
        -- ot sebya
        ELSE "chto-to tam"
	END AS SALARY_GROUP
FROM employees;

-- Ответить одним предложением: почему выводится только один столбец? 
-- -- We choose what to get with SELECT, in that case SALARY_GROUP.
-- ---- Запрос
-- ---- Команда на SQL, предназначенная для получения или изменения данных или структуры сущностей в базе данных.

-- Изменить запрос, так, чтобы вывелось два столбца: имя сотрудника и новое поле SALARY_GROUP.
SELECT first_name,
	CASE
		WHEN salary > 10000 THEN 1
        WHEN salary < 10000 THEN 0
        -- ot sebya
        ELSE "chto-to tam"
	END AS SALARY_GROUP
FROM employees;

-- Вывести среднюю зарплату для департаментов с номерами 60, 90 и 100 используя составное условие.
-- 1. Var
SELECT 
IF(department_id IN (60,90,100),AVG(salary),NULL) AS Average
FROM employees;
-- 2- Var
SELECT 
	CASE
		WHEN department_id IN (60,90,100) THEN AVG(salary)
    END AS Average
FROM employees;

-- Разделить уровни (level) сотрудников на junior < 10000,10000<mid<15000, senior>15000 в зависимости от их зарплаты. Вывести список сотрудников (first_name, last_name, level).
SELECT first_name, last_name,
	CASE
		WHEN salary < 10000 THEN "junior"
        WHEN salary BETWEEN 10000 AND 15000 THEN "mid"
        WHEN salary > 15000 THEN "senior"
	END AS `level`
FROM employees;

-- Посмотреть содержимое таблицы jobs. Написать запрос c использованием оператора case/when/end, который возвращает 2 столбца: job_id, payer_rank, где столбец payer_rank формируется по правилу: если максимальная зарплата больше 10000, то “high_payer”, если меньше, то “low payer”. 
SELECT * FROM jobs;

SELECT job_id,
	CASE
		WHEN max_salary > 10000 THEN "high_payer"
        WHEN max_salary < 10000 THEN "low_payer"
        ELSE "mid_payer"
    END AS payer_rank
FROM jobs;

-- Переписать этот запрос с использованием оператора IF.
SELECT job_id,
	IF(max_salary > 10000, "high_payer", IF(max_salary < 10000, "low_payer", "mid_payer")) AS payer_rank
FROM jobs;

-- Поменять предыдущий запрос так, чтобы выводилось 3 столбца, к двум существующим добавьте max_salary и отсортировать результат по убыванию. 
SELECT job_id,
	IF(max_salary > 10000, "high_payer", IF(max_salary < 10000, "low_payer", "mid_payer")) AS payer_rank, max_salary
FROM jobs
ORDER BY max_salary DESC;