-- Подключиться к базе данных world
use world;

-- Вывести население в каждой стране. Результат содержит два поля: CountryCode, sum(Population). Запрос по таблице city

SELECT CountryCode,sum(Population) as sumPopulation
FROM city
group by CountryCode;

-- Изменить запрос выше так, чтобы выводились только страны с населением более 3 млн человек. 
SELECT CountryCode, sum(Population) as sumPopulation
FROM city
GROUP BY CountryCode
HAVING sumPopulation > 3000000;

-- Q: Сколько всего записей в результате?
-- A: 59

-- Поменять запрос выше так, чтобы в результате вместо кода страны выводилось ее название. Подсказка: нужен join таблиц city и country по полю CountryCode.
SELECT country.`Name`, sum(city.Population) as sumPopulation
FROM city
JOIN country
ON city.CountryCode = country.`Code`
GROUP BY CountryCode
HAVING sumPopulation > 3000000;

-- Вывести количество городов в каждой стране (CountryCode, amount of cities). Подсказка: запрос по таблице city и группировка по CountryCode.
SELECT CountryCode, COUNT(`Name`) as amount_of_cities
FROM city
GROUP BY CountryCode;

-- Поменять запрос так, чтобы вместо кодов стран, было названия стран.
SELECT country.`Name`, COUNT(city.`Name`) as amount_of_cities
FROM city 
JOIN country
ON city.CountryCode = country.`Code`
GROUP BY CountryCode;

-- Поменять запрос так, чтобы выводилось среднее количество городов в стране. Подсказка: разделите задачу на несколько подзадач. Например, сначала вывести код страны и количество городов в каждой стране.  Затем сделать join получившегося результата с запросом, где высчитывается среднее от количества городов. Потом добавить join, который добавит имена стран, вместо кода. 

-- Разобьем запросы на части:
-- 1. Вывести код страны и количество городов в каждой стране.
-- 2. Получить среднее количество городов в стране.
-- 3. Объединить результаты с именами стран.

-- sdelanno s CHAT GPT..
SELECT country.Name, city_counts.city_count, avg_cities.avg_cities_per_country
FROM (
    SELECT CountryCode, COUNT(*) AS city_count
    FROM city
    GROUP BY CountryCode
) AS city_counts
JOIN country ON city_counts.CountryCode = country.Code
JOIN (
    SELECT AVG(city_count) AS avg_cities_per_country
    FROM (
        SELECT CountryCode, COUNT(*) AS city_count
        FROM city
        GROUP BY CountryCode
    ) AS city_counts
) AS avg_cities;
