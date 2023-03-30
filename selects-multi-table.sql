
-- Obtener todos los planes que incluyen el servicio de Masajes:
SELECT p.name AS plan_name, 
    p.price AS plan_price, 
    s.name AS service_name,
    s.description AS service_description 
FROM plans p
INNER JOIN service_plans sp ON sp.plan_id = p.id
INNER JOIN services s ON s.id = sp.service_id
WHERE s.name = 'Masajes';

-- Obtener el nombre, descripción de las clases que imparte un coach en particular:
SELECT c.name, 
    c.description,
    u.name AS user_name,
    u.email AS user_email
FROM classes c
INNER JOIN coaches co ON co.id = c.coach_id
INNER JOIN user u ON u.coach_id = co.id
WHERE u.name = 'Juan Perez';

-- Obtener las clases a las que un cliente en especifico ha reservado un espacio:
SELECT c.name, c.description
FROM classes c
INNER JOIN reservations r ON r.class_id = c.id
INNER JOIN customers cu ON cu.id = r.customer_id
INNER JOIN users u ON u.customer_id = cu.id
WHERE u.id = 'ID del Cliente';



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
SELECT c.name AS class_name,
    c.description AS class_description,
    u.name AS coach_name,
    u.email AS coach_email
 COUNT(r.id) AS reservation_count
FROM classes c
INNER JOIN coaches co ON co.id = c.coach_id
INNER JOIN reservations r ON r.class_id = c.id
INNER JOIN users u ON u.coach_id = co.id
WHERE co.name = 'Nombre del Coach';