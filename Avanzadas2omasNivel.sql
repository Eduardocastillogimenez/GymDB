




/** Mostrar el nombre de los clientes que tienen una suscripción activa en un plan que incluye el 
servicio de Entrenamiento personalizado. **/

SELECT u.name
FROM gym_db.users u
JOIN gym_db.customers c ON u.customer_id = c.id
JOIN gym_db.subscription_history s ON c.id = s.customer_id
JOIN gym_db.service_plans sp ON s.plans_id = sp.plan_id
JOIN gym_db.services serv ON sp.service_id = serv.id
JOIN gym_db.plans p ON s.plans_id = p.id
WHERE c.active_customer = true AND serv.name = 'Entrenamiento personalizado';


/** **/

/** Mostrar el nombre y precio de los planes que tienen al menos un cliente activo y que incluyen el servicio 
de Entrenamiento personalizado. **/

SELECT p.name, p.price, serv.name as nombre_servicio
FROM gym_db.plans p
JOIN gym_db.service_plans sp ON p.id = sp.plan_id
JOIN gym_db.services serv ON sp.service_id = serv.id
JOIN gym_db.subscription_history s ON p.id = s.plans_id
JOIN gym_db.customers c ON s.customer_id = c.id
WHERE c.active_customer = true AND serv.name = 'Entrenamiento personalizado'
GROUP BY p.id;




/**  Obtener el nombre, email y fecha de nacimiento de los usuarios que son entrenadores y 
están verificados, junto con el nombre de las clases que imparten **/

SELECT u.name, u.email, u.dob, cl.name AS class_name
FROM gym_db.users u
JOIN gym_db.coaches c ON u.coach_id = c.id
JOIN gym_db.classes cl ON c.id = cl.coach_id
WHERE c.verified = true;