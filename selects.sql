SELECT COUNT(*)
    FROM customers
    WHERE active_customer = true LIMIT 20;

SELECT AVG(subscription_price) as avg_subs_prices
    FROM subscription_history 
    LIMIT 20;

SELECT MIN(subscription_price) as min_subs_prices,
    subscription_date, 
    subscription_expiration 
    FROM subscription_history 
    GROUP BY subscription_date, 
    subscription_expiration 
    LIMIT 20; 

SELECT name, 
    UPPER(sex) AS sex, 
    dob, 
    address 
    FROM users
    LIMIT 20;

SELECT REPLACE(LOWER(name), ' ', '-') AS slug_service, 
    name,
    description 
    FROM services LIMIT 20;












/**  Seleccionar el nombre y precio de los planes de la tabla plans que tengan un precio mayor a 50: **/


SELECT name, price FROM plans WHERE price > 50;

/** Seleccionar el nombre y descripción de los roles de la tabla roles que tengan una descripción que contenga la palabra "administrador": **/

SELECT name, description FROM roles WHERE description LIKE '%administrador%';

/** Seleccionar el nombre y correo electrónico de los usuarios de la tabla users que tengan un correo electrónico de dominio "gmail.com": **/
SELECT name, email FROM users WHERE email LIKE '%gmail.com';

/** Seleccionar el nombre y descripción de los servicios de la tabla services que tengan una descripción que contenga la palabra "dolores musculares": **/

SELECT name, description FROM services WHERE description LIKE '%dolores musculares%';

/** Seleccionar el nombre y fecha de nacimiento de los usuarios de la tabla users que tengan una fecha de nacimiento anterior al 1 de enero de 1990: **/

SELECT name, dob FROM users WHERE dob < '1990-01-01';














-- 9. Consultas Intermedias de una tabla con agrupamiento de valores, funciones de grupo y exclusión de resultados. 

/** Selecciona el id y la suma de precios de todos los planes de la tabla "gym_db.plans". 
 Agrupa los resultados por el id del plan y solo devuelve aquellos resultados cuya suma de precios es mayor a 50. **/
SELECT a.id, SUM(a.price) AS Total
FROM gym_db.plans a
GROUP BY a.id
HAVING SUM(a.price) > 50;


/**  Cuenta la cantidad de usuarios en la tabla "gym_db.users" agrupados por su sexo. **/
SELECT sex, COUNT(*) AS Cantidad
FROM gym_db.users
GROUP BY sex;

/**  Selecciona el día de nacimiento de los usuarios de la tabla 
"gym_db.users" y cuenta la cantidad de usuarios que nacieron cada día. **/
SELECT DAY(dob) AS Dia_Nacimiento, COUNT(*) AS Cantidad
FROM gym_db.users
GROUP BY Dia_Nacimiento;

/**  Selecciona el id de cada plan en la tabla "gym_db.plans" 
junto con el precio mínimo, máximo y promedio de todos los planes agrupados por id. **/
SELECT p.id, MIN(p.price) AS Minimo, MAX(p.price) AS Máximo, AVG(p.price) AS Promedio
FROM gym_db.plans AS p
GROUP BY p.id;

/**  Selecciona el año de suscripción y cuenta la cantidad total de suscripciones en la tabla "gym_db.subscription_history" 
agrupadas por año. Solo devuelve aquellos resultados cuya cantidad total de suscripciones es mayor a cero.  **/
SELECT YEAR(sub.subscription_date) AS Año,
COUNT(*) AS Total_Suscripciones
FROM gym_db.subscription_history AS sub
GROUP BY Año
HAVING COUNT(Año) > 1;














/**  Mostrar el nombre y la cantidad de estudiantes inscritos en cada clase que se impartirá la próxima semana, excluyendo aquellas clases que ya se encuentran llenas: **/
select group_concat(c.name)  AS class_name, COUNT(*) AS enrolled_students, c.id as class_is, c.student_limit
FROM gym_db.classes c
LEFT JOIN gym_db.reservations r ON c.id = r.class_id
LEFT JOIN gym_db.schedules s ON r.schedule_id = s.id
GROUP BY c.id, c.student_limit
HAVING COUNT(*) < c.student_limit OR c.student_limit IS NULL;

/**
Mostrar el nombre y la fecha de inicio de todas las suscripciones que finalizan en el próximo mes, excluyendo aquellas suscripciones que ya han expirado: **/
SELECT p.name AS plan_name, sh.subscription_date AS start_date
FROM gym_db.plans p
INNER JOIN gym_db.subscription_history sh ON p.id = sh.plans_id
WHERE sh.subscription_expiration BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 YEAR)
GROUP BY sh.id
HAVING MAX(sh.subscription_expiration) >= CURDATE();

/**
Mostrar el nombre y el precio total de todos los servicios que ofrecen los planes que tienen un precio superior a $50, excluyendo aquellos servicios que no están incluidos en ningún plan: **/
SELECT s.name AS service_name, SUM(p.price) AS total_price
FROM gym_db.services s
INNER JOIN gym_db.service_plans sp ON s.id = sp.service_id
INNER JOIN gym_db.plans p ON sp.plan_id = p.id
GROUP BY s.id
HAVING SUM(p.price) > 50 AND COUNT(*) > 0;

/**  
Mostrar el nombre y la cantidad de clientes que tienen una suscripción activa para cada plan existente en el gimnasio: **/
SELECT p.name AS plan_name, COUNT(*) AS active_subscriptions
FROM gym_db.plans p
LEFT JOIN gym_db.customers c ON p.id = c.plan_id
WHERE c.active_customer = true
GROUP BY p.id;

/** Mostrar el nombre y la descripción de todos los planes que tienen subcripciones en una duración de más de 70 dias, excluyendo aquellos planes que no están incluidos en ninguna suscripción activa: **/
SELECT p.name, p.description
FROM gym_db.plans p
INNER JOIN gym_db.subscription_history sh ON p.id = sh.plans_id
INNER JOIN gym_db.customers c ON sh.customer_id = c.id
WHERE DATEDIFF(sh.subscription_expiration, sh.subscription_date) > 70 AND c.active_customer = true
GROUP BY p.id;