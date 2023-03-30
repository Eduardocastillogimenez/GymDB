UPDATE users
    SET name = 'Juan Pérez',
    address = 'Calle verde, casa 123',
    phone = '1234-2589'
    WHERE id = 1;

UPDATE classes
    SET name = 'Pilates Avanzado',
    description = 'Clase de Pilates para usuarios con experiencia previa',
    student_limit = 12,
    WHERE id = 3;


UPDATE services
    SET name = 'Entrenamiento Personalizado',
    description = 'Entrenamiento individualizado con un entrenador personal',
    price = 200.00
    WHERE id = 1;

UPDATE users
    SET name = 'Ana García',
    email = 'ana.garcia@hotmail.com'
    WHERE id = 2;

UPDATE classes
    SET name = 'Boxeo para Principiantes', 
    description = 'Clase de Boxeo para usuarios sin experiencia previa',
    student_limit = 15, 
    WHERE id = 1;