SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE SCHEMA IF NOT EXISTS `school_db` DEFAULT CHARACTER SET utf8 ;
USE `school_db` ;
CREATE TABLE IF NOT EXISTS `school_db`.`class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `course_number` VARCHAR(45) NOT NULL,
  `term` VARCHAR(45) NOT NULL,
  `section_number` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`class_id`),
  UNIQUE INDEX `class_id_UNIQUE` (`class_id` ASC) VISIBLE,
  UNIQUE (course_number,term,section_number))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `school_db`.`student` (
  `student_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`student_id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `school_db`.`class_enrollment` (
  `class_enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`class_enrollment_id`),
  UNIQUE INDEX `class_enrollment_id_UNIQUE` (`class_enrollment_id` ASC) VISIBLE,
  UNIQUE (student_id,class_id),
  CONSTRAINT `enrollment_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `school_db`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `enrollment_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `school_db`.`class` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `school_db`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `weight` FLOAT NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `idcategory_UNIQUE` (`category_id` ASC) VISIBLE,
  UNIQUE (name,class_id),
  INDEX `class_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `category_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `school_db`.`class` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `school_db`.`assignment` (
  `assignment_id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `point_value` INT NOT NULL,
  PRIMARY KEY (`assignment_id`),
  UNIQUE INDEX `assignment_id_UNIQUE` (`assignment_id` ASC) VISIBLE,
  UNIQUE (name,category_id),
  INDEX `category_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `assignment_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `school_db`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `school_db`.`assignment_grade` (
  `assignment_grade_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `assignment_id` INT NOT NULL,
  `points_awarded` INT NOT NULL,
  PRIMARY KEY (`assignment_grade_id`),
  UNIQUE INDEX `idassignment_grade_UNIQUE` (`assignment_grade_id` ASC) VISIBLE,
  INDEX `student_idx` (`student_id` ASC) VISIBLE,
  INDEX `assignment_idx` (`assignment_id` ASC) VISIBLE,
  UNIQUE(student_id,assignment_id),
  CONSTRAINT `graded_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `school_db`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `graded_assignment`
    FOREIGN KEY (`assignment_id`)
    REFERENCES `school_db`.`assignment` (`assignment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
