-- 1. Busca en la tabla "users"  cualquier registro donde el campo 'name' sea igual al valor que se pasa como parámetro 'username'.

DELIMITER //
CREATE PROCEDURE get_user_info(IN username VARCHAR(100))
BEGIN
    SELECT *
    FROM gym_db.users 
    WHERE name = username;
END;
DELIMITER ;


CALL get_user_info('Daniel Jose');


-- 2. Este Procedimiento  recibe como parámetro el id de un coach y lo marca como verificado.

DELIMITER //
CREATE PROCEDURE verify_coach(IN coachId INT)
BEGIN
    UPDATE gym_db.coaches
    SET verified = 1
    WHERE id = coachId;
END //
DELIMITER ;

CALL verify_coach(2);

-- 3. Este procedimiento devuelve una lista de clases que imparte un determinado entrenador (coach) identificado por su ID.

DELIMITER //
CREATE PROCEDURE get_classes_by_coach(IN coachId INT)
BEGIN
    SELECT *
    FROM gym_db.classes
    WHERE coach_id = coachId;
END //
DELIMITER ;

CALL get_classes_by_coach(3);