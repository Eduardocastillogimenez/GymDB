-- Procedimiento que utilica cursores para incrementar el límite de alumnos de todas las clases en el numero que se le pase por parametro, en este caso en 5

DELIMITER //
CREATE PROCEDURE increment_student_limit(IN INCREMENT INT)

BEGIN
    DECLARE done BOOLEAN;
    DECLARE class_id INT;
    DECLARE std_limit INT;

    DECLARE cur CURSOR FOR SELECT id, student_limit FROM gym_db.classes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET done = FALSE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO class_id, std_limit;
        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE gym_db.classes SET student_limit = std_limit + INCREMENT WHERE id = class_id;
    END LOOP;

    CLOSE cur;

END //
DELIMITER ;

CALL increment_student_limit(5);



--  Accede a todos lo registros de la tabla schedules y actualiza la duración de las clases que se imparten en la fecha que se le pase por parametro, en este caso 2022-05-01

DELIMITER //
CREATE PROCEDURE update_schedules_duration(
    IN newDuration TIME,
 	IN limitDate DATE
)
BEGIN
    DECLARE done BOOLEAN;
    DECLARE schedule_id INT;
    DECLARE schedule_day DATE;
    DECLARE schedule_duration TIME;
   
    DECLARE schedules_cursor CURSOR FOR SELECT id, day, duration FROM gym_db.schedules;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
   
    SET done = FALSE;
    OPEN schedules_cursor;


    read_loop: LOOP
        FETCH schedules_cursor INTO schedule_id, schedule_day, schedule_duration;
       
        IF done THEN
            LEAVE read_loop;
        END IF;
       
        IF DATEDIFF(schedule_day, limitDate) = 0 THEN
            UPDATE gym_db.schedules 
 	        SET duration = newDuration 
            WHERE id = schedule_id;
        END IF;
       
    END LOOP;
   
    CLOSE schedules_cursor;
    select 'Data Updated Successfully';
END //
DELIMITER ;


CALL update_schedules_duration('01:00:00', '2022-05-01');