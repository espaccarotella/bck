-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema todo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema todo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `todo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `todo` ;

-- -----------------------------------------------------
-- Table `todo`.`tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todo`.`tasks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(60) NULL DEFAULT NULL,
  `folder` VARCHAR(20) NULL DEFAULT NULL,
  `complete` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 85
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `todo` ;

-- -----------------------------------------------------
-- procedure tasksAddOrEdit
-- -----------------------------------------------------

DELIMITER $$
USE `todo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `tasksAddOrEdit`(
	IN _id INT,
    IN _description VARCHAR(60),
    IN _folder VARCHAR(20),
    IN _complete TINYINT
)
BEGIN
	IF _id = 0 THEN
		INSERT INTO tasks (description, folder, complete)
        VALUES (_description, _folder, 0);
        SET _id = LAST_INSERT_ID();
	ELSE
		UPDATE tasks
        SET
			description = _description,
            folder = _folder,
            complete = _complete
            WHERE id = _id;
	END IF;
    
    SELECT _id AS id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
