



/**  Trigger que impide la eliminación de un plan utilizado en una suscripción
Este trigger se asegura de que no se pueda eliminar un plan que está siendo utilizado en una suscripción activa. 
Si se intenta eliminar un plan utilizado en una suscripción, se lanzará un error y se impedirá la eliminación del plan. **/

DELIMITER //
CREATE TRIGGER trg_prevent_plan_deletion
BEFORE DELETE ON gym_db.plans
FOR EACH ROW
BEGIN
    DECLARE plan_id INT UNSIGNED;
    SELECT id INTO plan_id FROM gym_db.subscription_history WHERE plans_id = OLD.id;
    IF plan_id IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Este plan está siendo utilizado en una suscripción activa y no puede ser eliminado.';
    END IF;
END //
DELIMITER ;

-- 
DELETE FROM plans WHERE id = 2;
-- 


/**  Trigger para impedir la eliminación de un coach si tiene clases asociadas: **/

DELIMITER $$
CREATE TRIGGER trg_coach_delete
BEFORE DELETE ON gym_db.coaches
FOR EACH ROW
BEGIN
    DECLARE count_classes INT;
    SELECT COUNT(*) INTO count_classes FROM gym_db.classes WHERE coach_id = OLD.id;
    IF count_classes > 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'No se puede eliminar el entrenador porque tiene clases asociadas.';
    END IF;
END $$
DELIMITER ;


-- 
DELETE FROM gym_db.coaches WHERE id = 1;
-- 




/**  Trigger para impedir la eliminación de un servicio si está asociado a algún plan: **/

DELIMITER $$
CREATE TRIGGER trg_service_delete
BEFORE DELETE ON gym_db.services
FOR EACH ROW
BEGIN
    DECLARE count_service_plans INT;
    SELECT COUNT(*) INTO count_service_plans FROM gym_db.service_plans WHERE service_id = OLD.id;
    IF count_service_plans > 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'No se puede eliminar el servicio porque está asociado a algún plan.';
    END IF;
END;
DELIMITER ;


-- 
DELETE FROM gym_db.coaches WHERE id = 1;
-- 


