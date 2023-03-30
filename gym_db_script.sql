/**
    DATABASE_NAME = `gym_db`
**/

/** Table ROLES **/

CREATE TABLE IF NOT EXISTS `gym_db`.`roles` (
  `id` INT UNSIGNED AUTO_INCREMENT,  
  `name` VARCHAR(100) NOT NULL,      
  `description` VARCHAR(255) NULL,   
  CONSTRAINT `pk_role_id` PRIMARY KEY (`id`)
);

/** Table PLANS **/

CREATE TABLE IF NOT EXISTS `gym_db`.`plans` (
  `id` INT UNSIGNED AUTO_INCREMENT,  
  `name` VARCHAR(100) NOT NULL,      
  `description` VARCHAR(255) NULL,   
  `price` DECIMAL(10, 2) NOT NULL,   
  CONSTRAINT `pk_plan_id` PRIMARY KEY (`id`),         
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) 
);


/** Table CUSTOMERS **/

CREATE TABLE IF NOT EXISTS `gym_db`.`customers` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `active_customer` BOOLEAN NOT NULL DEFAULT true,
  `plan_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `pk_customer_id` PRIMARY KEY (`id`),
  CONSTRAINT `fk_customers_plans`
    FOREIGN KEY (`plan_id`)
    REFERENCES `gym_db`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




/** Table COACHES **/

CREATE TABLE IF NOT EXISTS `gym_db`.`coaches` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `verified` BOOLEAN NOT NULL DEFAULT false,
  `description` VARCHAR(255) NULL,
  CONSTRAINT `pk_coach_id` PRIMARY KEY (`id`));


/** Table USERS **/

CREATE TABLE IF NOT EXISTS `gym_db`.`users` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `sex` VARCHAR(45) NULL,
  `dob` DATE NULL,
  `address` VARCHAR(255) NULL,
  `phone` VARCHAR(45) NULL,
  `roles_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NULL,
  `coach_id` INT UNSIGNED NULL,
  CONSTRAINT `pk_user_id` PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC),
  UNIQUE INDEX `coach_id_UNIQUE` (`coach_id` ASC),
  CONSTRAINT `fk_users_roles`
    FOREIGN KEY (`roles_id`)
    REFERENCES `gym_db`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `gym_db`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_coaches`
    FOREIGN KEY (`coach_id`)
    REFERENCES `gym_db`.`coaches` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `gym_db`.`users`
ADD CONSTRAINT `check_customer_or_coach`
    CHECK ((`customer_id` IS NULL AND `coach_id` IS NOT NULL)
           OR (`customer_id` IS NOT NULL AND `coach_id` IS NULL)
           OR (`customer_id` IS NULL AND `coach_id` IS NULL));

/** Table CLASSES **/

CREATE TABLE IF NOT EXISTS `gym_db`.`classes` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  `coach_id` INT UNSIGNED NOT NULL,
  `student_limit` INT NULL,
  CONSTRAINT `pk_class_id` PRIMARY KEY (`id`),
  CONSTRAINT `fk_classes_coaches`
    FOREIGN KEY (`coach_id`)
    REFERENCES `gym_db`.`coaches` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


/** Table SERVICES **/

CREATE TABLE IF NOT EXISTS `gym_db`.`services` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  CONSTRAINT `pk_service_id` PRIMARY KEY (`id`));



/** Table SERVICE_PLANS **/

CREATE TABLE IF NOT EXISTS `gym_db`.`service_plans` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `plan_id` INT UNSIGNED NOT NULL,
  `service_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `pk_service_plan_id` PRIMARY KEY (`id`),
  CONSTRAINT `fk_plans_services_plans`
    FOREIGN KEY (`plan_id`)
    REFERENCES `gym_db`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plans_services_services`
    FOREIGN KEY (`service_id`)
    REFERENCES `gym_db`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


/** Table SUBSCRIPTION_HISTORY **/

CREATE TABLE IF NOT EXISTS `gym_db`.`subscription_history` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `subscription_date` DATE NOT NULL,
  `subscription_expiration` DATE NOT NULL,
  `subscription_price` DECIMAL(10,2) NULL,
  `plans_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `pk_subscription_history_id` PRIMARY KEY (`id`),
  CONSTRAINT `fk_subscription_history_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `gym_db`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_history_plans`
    FOREIGN KEY (`plans_id`)
    REFERENCES `gym_db`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


/** Table SCHEDULE **/

CREATE TABLE IF NOT EXISTS `gym_db`.`schedules` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `hour` TIME NOT NULL,
  `day` DATE NOT NULL,
  `duration` TIME NOT NULL,
  `class_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `pk_schedule_id` PRIMARY KEY (`id`),
  CONSTRAINT `fk_schedule_classes`
    FOREIGN KEY (`class_id`)
    REFERENCES `gym_db`.`classes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



/** Table RESERVATIONS **/

CREATE TABLE IF NOT EXISTS `gym_db`.`reservations` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `class_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `schedule_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `pk_reservation_id` PRIMARY KEY (`id`),
  CONSTRAINT `fk_reservations_classes`
    FOREIGN KEY (`class_id`)
    REFERENCES `gym_db`.`classes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservations_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `gym_db`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservations_schedule`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `gym_db`.`schedules` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);