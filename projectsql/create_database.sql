DROP DATABASE IF EXISTS call_center;
CREATE DATABASE call_center;
USE call_center;

DROP TABLE IF EXISTS roles;
CREATE TABLE roles(
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(15) NOT NULL UNIQUE
) COMMENT = 'Роли пользователей системы';


DROP TABLE IF EXISTS users;
CREATE TABLE users (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL UNIQUE,
   last_name VARCHAR(50) NOT NULL UNIQUE,
   email VARCHAR(100) NOT NULL UNIQUE,
   self_phone VARCHAR(13) NOT NULL UNIQUE,
   role_flag INT UNSIGNED, 
   create_at DATETIME DEFAULT NOW(),
   update_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
   CONSTRAINT user_role_flag_fk
       FOREIGN KEY (role_flag) REFERENCES roles(id) 
               ON DELETE SET NULL 
               ON UPDATE CASCADE   
   ) COMMENT = 'Учетные записи работников КЦ';
  


DROP TABLE IF EXISTS internal_phones;
CREATE TABLE internal_phones (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   phone VARCHAR(10) NOT NULL UNIQUE,
   user_id INT UNSIGNED,
   CONSTRAINT user_inrternal_phones_fk
      FOREIGN KEY (user_id) REFERENCES users(id)
          ON DELETE SET NULL 
          ON UPDATE CASCADE   
   ) COMMENT = 'Добавочные номера специалистов КЦ';
 

DROP TABLE IF EXISTS work_statuses;
CREATE TABLE work_statuses(
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30) NOT NULL UNIQUE,
   create_at DATETIME DEFAULT NOW(),
   update_at DATETIME DEFAULT NOW() ON UPDATE NOW()
) COMMENT = 'Рабочие статусы спекциалистов';


DROP TABLE IF EXISTS real_time_user_status;
CREATE TABLE real_time_user_status(
    user_id INT UNSIGNED NOT NULL,
    status_id INT UNSIGNED NOT NULL,
    login_system_at DATETIME DEFAULT NOW(),
    update_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    CONSTRAINT user_id_fk
       FOREIGN KEY (user_id) REFERENCES users(id)
               ON DELETE CASCADE,
    CONSTRAINT status_id_fk
       FOREIGN KEY (status_id) REFERENCES work_statuses(id)
               ON DELETE CASCADE
   ) COMMENT = 'Таблица состояний агентов в реальном времени';
  
  
DROP TABLE IF EXISTS work_group;
CREATE TABLE work_group (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(20) NOT NULL UNIQUE,
   create_at DATETIME DEFAULT NOW(),
   update_at DATETIME DEFAULT NOW() ON UPDATE NOW()
   ) COMMENT = 'Перечнь рабочих групп специалистов';
  

DROP TABLE IF EXISTS users_group; 
CREATE TABLE users_group(
   users_id INT UNSIGNED,
   group_id INT UNSIGNED,
   CONSTRAINT users_fk
      FOREIGN KEY (users_id) REFERENCES users(id)
              ON DELETE CASCADE,
   CONSTRAINT group_id_fk
      FOREIGN KEY (group_id) REFERENCES work_group(id)
              ON DELETE CASCADE
) COMMENT = 'Принадлежность сотрудников к группам, у каждого их может быть несколько';


DROP TABLE IF EXISTS calls_status;
CREATE TABLE calls_status (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL UNIQUE
) COMMENT = 'Статусы звонков';


DROP TABLE IF EXISTS calls_detail;
CREATE TABLE calls_detail(
  user_id INT UNSIGNED,
  to_user_id INT UNSIGNED,
  status_id INT UNSIGNED,
  customer_phone VARCHAR(30),
  begin_at DATETIME DEFAULT NOW(), 
  end_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  CONSTRAINT user_call_id_fk
      FOREIGN KEY (user_id) REFERENCES users(id)
         ON DELETE CASCADE,
  CONSTRAINT to_user_call_id_fk
      FOREIGN KEY (to_user_id) REFERENCES users(id)
         ON DELETE CASCADE,
  CONSTRAINT status_call_id_fk
      FOREIGN KEY (status_id) REFERENCES calls_status(id)
         ON DELETE CASCADE
  ) COMMENT = 'Звонки';


DROP TABLE IF EXISTS black_list_status;
CREATE TABLE black_list_status (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL UNIQUE
) COMMENT = 'Статусы черного листа';



DROP TABLE IF EXISTS black_list;
CREATE TABLE black_list(
   user_id INT UNSIGNED,
   status_id INT UNSIGNED,
   phone VARCHAR(20) NOT NULL UNIQUE,
   blocked_at DATETIME DEFAULT NOW(),
   unblocked DATETIME DEFAULT NOW() ON UPDATE NOW(),
   CONSTRAINT user_black_id_fk
       FOREIGN KEY (user_id) REFERENCES users(id)
         ON DELETE CASCADE,
   CONSTRAINT status_black_id_fk
   FOREIGN KEY (status_id) REFERENCES black_list_status(id)
         ON DELETE CASCADE
         ON UPDATE CASCADE  
  );



  

