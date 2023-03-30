
INSERT INTO roles ( name, description) VALUES 
  ( 'admin', 'Administrador del sistema'),
  ( 'customer', 'Cliente del gimnasio'),
  ( 'coach', 'Entrenador del gimnasio');


INSERT INTO plans (name, description, price) VALUES 
  ('Básico', 'Acceso a todas las clases del gimnasio.', 50),
  ('Intermedio', 'Acceso a todas las clases del gimnasio y una consulta de nutrición al mes.', 75),
  ('Avanzado', 'Acceso a todas las clases del gimnasio, una consulta de nutrición al mes y un entrenamiento personalizado semanal.', 100);


INSERT INTO customers (active_customer, plan_id) VALUES (true, 1), (true, 2), (true, 3), (false, 3), (false, 2), (true, 2);


INSERT INTO coaches (verified, description) VALUES 
  (true, 'Entrenador personal certificado.'),
  (false, 'Entrenador de crossfit con experiencia.'),
  (true, 'Especialista en yoga y meditación.'),
  (true, 'Entrenador de Boxeo con experiencia.');



INSERT INTO users (name, email, password, sex, dob, address, phone, roles_id, customer_id, coach_id) VALUES 
  ('Juan Pérez', 'juan.perez@gmail.com', 'abc123', 'Masculino', '1998-02-15', 'Calle 12 #34-56', '555-1234', 2, 1, null),
  ('María Rodríguez', 'maria.rodriguez@gmail.com', 'def456', 'Femenino', '1995-07-22', 'Carrera 45 #67-89', '555-5678', 2, 2, null),
  ('José Pérez', 'jose.perez@gmail.com', 'ghi789', 'Masculino', '1990-11-05', 'Avenida 23 #12-34', '555-9012', 2, 3, null),
  ('Ana González', 'ana.gonzalez@gmail.com', 'jkl012', 'Femenino', '1985-04-10', 'Calle 98 #76-54', '555-3456', 2, 4, null),
  ('Eduardo tomas', 'aeduardo_t79@gmail.com', '7yf8Uv#d', 'Masculino', '2001-04-10', 'Calle marzo, carrera noviembre #76-54', '552-3426', 3, null, 1),
  ('Pedro Sanchez', 'pedro@gmail.com', 'hT6&kL9@', 'Masculino', '2000-03-10', 'Calle 17, siempre viva #76-54', '555-3456', 3, null, 2),
  ('Roxana Ayala', 'roxana756@gmail.com', '$2sG4fP@', 'Femenino', '1996-04-10', 'Calle venezuela #76-54', '5226-3456', 3, null, 3),
  ('Michell Daza', 'michell56564@gmail.com', 'qY9@rT2#', 'Femenino', '2000-02-10', 'Calle orchan #76-54', '2265-345656', 3, null, 4),
  ('Beatriz Jimenez', 'beatriz256@gmail.com', 'qUJa223/*#', 'Femenino', '1980-06-10', 'Calle arc #56-21', '3254-345656', 2, 5, null),
  ('Alejandro Magno', 'magno59@gmail.com', 'Y9de435$!@XDF', 'Masculino', '1987-10-10', 'Calle real, Urb KingSour #20', '65712-365410', 2, 6, null),
  ('Simon Diaz', 'diaz562sim@gmail.com', 'as7#fF4$', 'Masculino', '1992-04-09', 'Urb. la paz #76-54', '3215-3456', 1, null, null),
  ('Daniel Jose', 'jose23@gmail.com', 'eH7#fF4$', 'Masculino', '2002-04-03', 'Calle falsa, petare #76-54', '5545-342256', 1, null, null);


INSERT INTO classes (name, description, coach_id, student_limit) VALUES 
  ('Yoga', 'Clase de yoga para principiantes y avanzados.', 3, 20),
  ('Crossfit', 'Entrenamiento de alta intensidad para mejorar la resistencia y la fuerza.', 2, 15),
  ('Pilates', 'Rutina de ejercicios para mejorar la flexibilidad y tonificar los músculos.', 1, 12),
  ('Boxeo', 'Clase de Boxeo para iniciantes', 4, 12);



INSERT INTO services (name, description) VALUES 
    ('Consulta de nutrición', 'Evaluación nutricional y asesoramiento.'),
    ('Entrenamiento personalizado', 'Rutinas de ejercicios personalizadas según tus objetivos.'),
    ('Masajes', 'Masajes relajantes y terapéuticos para aliviar el estrés y los dolores musculares.');



INSERT INTO service_plans (plan_id, service_id) VALUES (2, 1), (3, 1), (3, 2);



INSERT INTO subscription_history (subscription_date, subscription_expiration, subscription_price, plans_id, customer_id) VALUES 
  ('2022-01-01', '2022-02-01', 50, 1, 1),
  ('2022-03-15', '2022-06-15', 225, 2, 2),
  ('2022-07-01', '2022-12-31', 550, 3, 3);



INSERT INTO schedules (hour, day, duration, class_id) VALUES 
  ('08:00:00', '2022-04-01', '01:00:00', 1),
  ('10:00:00', '2022-05-01', '00:30:00', 2),
  ('9:00:00', '2022-04-01', '01:30:00', 3),
  ('16:00:00', '2022-04-01', '02:00:00', 3);



INSERT INTO reservations (class_id, customer_id, schedule_id) VALUES (1, 2, 1), (2, 3, 2), (3, 1, 3), (3, 4, 4);