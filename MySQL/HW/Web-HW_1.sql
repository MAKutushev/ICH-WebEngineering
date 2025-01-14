-- Web engineering: Домашнее задание 1 (morning)

USE hr;

-- Написать запрос, возвращающий всех сотрудников, c job_id = IT_PROG.
SELECT *
FROM employees
WHERE job_id = "IT_PROG";

-- Изменить запрос так, чтобы вывести всех сотрудников с job_id равной AD_VP?
SELECT *
FROM employees
WHERE job_id = "AD_VP";

-- Найдите сотрудников, с зп от 10 000 до 20 000 (включая концы)
SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

-- Найдите сотрудников не из 60, 30 и 100 департамента
SELECT *
FROM employees
WHERE department_id NOT IN (60,30,100);

-- Найдите сотрудников у которых есть две буквы ll подряд в середине имени
SELECT *
FROM employees
WHERE first_name LIKE "%_ll_%";

-- Найдите сотрудников, у которых фамилия кончается на a
SELECT *
FROM employees
WHERE last_name LIKE "%_a";

-- Найти всех сотрудников с зарплатой выше 10000
SELECT *
FROM employees
WHERE salary > 10000;

-- Найти всех сотрудников, с зарплатой выше 10000 и чья фамилия начинается на букву L
SELECT *
FROM employees
WHERE salary > 10000 AND last_name LIKE "L%";

-- Не выполняя запрос к базе данных, предсказать его результат:
-- select *  from employees where salary > 10000 or salary <= 10000;
-- -- -- here is like we do: WHERE salary (will show everything).

-- Ответить в 1 предложении: чем он будет отличаться от результата этого запроса?

-- select *  from employees where salary > 10000 or salary < 10000;
-- -- -- and here we get every salary but 10000, because 10000 is not included.

-- Не выполняя запрос к базе, предсказать результат. 
-- select *  from employees where salary > 10000 and salary < 5000;
-- -- -- it shows 0, but i dont get why... in my opinion it should return from 0 to 4999 and from 10001 to + infinity, nut i turned out to be wrong.