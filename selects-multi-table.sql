-- Obtener todos los servicios con sus planes:
SELECT p.name AS plan_name, 
    p.price AS plan_price, 
    s.name AS service_name,
    s.description AS service_description
FROM services s
INNER JOIN service_plans sp ON sp.service_id  = s.id
INNER JOIN plans p ON p.id = sp.plan_id;

-- Obtener el nombre, descripción de las clases que imparte un coach en particular:
SELECT c.name, 
    c.description,
    u.name AS user_name,
    u.email AS user_email
FROM users u
INNER JOIN coaches co ON co.id = u.coach_id 
INNER JOIN classes c ON c.coach_id  = co.id
WHERE u.name = 'Pedro Sanchez';

-- Obtener las clases a las que un cliente en especifico ha reservado un espacio:
SELECT c.name as classes_name, c.description as classes_description, u.name as customer_name
FROM  users u
INNER JOIN customers cu ON cu.id = u.customer_id 
INNER JOIN reservations r ON r.customer_id  = cu.id
INNER JOIN classes c ON r.class_id  = c.id
WHERE u.name = 'José Pérez';



-- Obtiene el nombre, descripción y fecha de suscripción de todos los clientes que han adquirido un plan en particular, ordenados por fecha de suscripción:
SELECT u.name AS user_name,
    u.email AS user_email,
    p.name AS plan_name,
    p.description AS plan_description, 
    sh.subscription_date AS subscription_date
FROM users u
INNER JOIN customers c ON u.customer_id = c.id
INNER JOIN plans p ON c.plan_id = p.id
INNER JOIN subscription_history sh ON sh.customer_id = c.id
WHERE p.name = 'Basico'
ORDER BY sh.subscription_date ASC;


-- Obtiene el nombre del coach y cantidad de reservas de todas las clases que ha impartido ese coach

SELECT c.id AS class_id,
    c.name AS class_name,
    c.description AS class_description,
    u.name AS coach_name,
    u.email AS coach_email,
    COUNT(r.id) AS reservation_count
FROM users u
INNER JOIN coaches co ON u.coach_id = co.id
INNER JOIN classes c ON c.coach_id = co.id
LEFT JOIN reservations r ON r.class_id = c.id
WHERE u.name = 'Eduardo tomas'
GROUP BY c.id, c.name, c.description, u.name, u.email;