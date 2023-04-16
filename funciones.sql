

/** Esta función devolvería todas las clases que imparte un determinado entrenador (coach) identificado por su ID. 
Para ello, se debería realizar una consulta a la tabla classes y filtrar por el ID del entrenador **/

DELIMITER //
CREATE PROCEDURE get_coach_classes(IN id INT)
BEGIN
  SELECT *
  FROM gym_db.classes
  WHERE id = coach_id;
END //
DELIMITER ;

-- 
call get_coach_classes(2);
-- 



/** Esta función devolvería todos los servicios contratados por un cliente (customer) identificado por su ID. Para ello, 
se debería realizar una consulta a la tabla service_plans y filtrar por el ID del cliente en la tabla customers. **/

DELIMITER //
CREATE PROCEDURE get_customer_services(IN customer_id INT)
BEGIN
  SELECT p.name as plan, p.description as plan_descripcion, p.price as plan_price, 
  s.name as servicio, s.description as servicio_descripcion
  FROM gym_db.service_plans sp
  JOIN gym_db.customers c ON sp.plan_id = c.plan_id
  JOIN gym_db.plans p ON P.id = c.plan_id
  JOIN gym_db.services s ON S.id = sp.service_id 
  WHERE c.id = customer_id;
END //
DELIMITER ;

-- 
call get_customer_services(2);
-- 






/** Esta función devolvería todos los clientes activos en el gimnasio. Para ello, 
se debería realizar una consulta a la tabla customers y filtrar por la columna active_customer. **/


DELIMITER //
CREATE PROCEDURE get_active_customers()
BEGIN
  SELECT *
  FROM gym_db.customers c
  JOIN gym_db.users u ON u.customer_id  = c.id 
  WHERE active_customer = true;
END //
DELIMITER ;

-- 
call get_active_customers();
-- 