USE call_center;
DROP TABLE IF EXISTS log_us;
CREATE TABLE log_us(
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   user INT UNSIGNED,
   new_user INT UNSIGNED,
   phone VARCHAR(10),
   event VARCHAR(100),
   create_at DATETIME DEFAULT NOW()
) COMMENT = 'контроль добавочных номеров';

DROP TRIGGER IF EXISTS event_delete_user;

DELIMITER //
CREATE TRIGGER event_delete_user BEFORE DELETE ON users
  FOR EACH ROW 
      BEGIN 
	      INSERT INTO log_us (user, new_user, phone, event) 
	       SELECT OLD.id,
	              NULL,
	              (SELECT phone FROM internal_phones WHERE user_id = OLD.id),
	              (SELECT CONCAT('удаление пользователя: ', OLD.id, ', освобождение номера: ', (SELECT phone FROM internal_phones WHERE user_id = OLD.id)));	             
      END

//

DROP TRIGGER IF EXISTS update_user_phone;

DELIMITER //
CREATE TRIGGER update_user_phone BEFORE UPDATE ON internal_phones 
   FOR EACH ROW
      BEGIN
	      INSERT INTO log_us (user, new_user, phone, event) 
	        SELECT OLD.user_id,
	               NEW.user_id,
	               NEW.phone,
	               (SELECT CONCAT(NEW.phone, ' присвоен специалисту: ', NEW.user_id));	        
      END
//


DROP PROCEDURE IF EXISTS koef_answer;

DELIMITER //
CREATE PROCEDURE koef_answer()
  BEGIN
	 SELECT wg.name, 
	        ROUND(SUM(CASE WHEN status_id = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS koef	        
	   FROM calls_detail cd
	      LEFT JOIN users_group ug ON ug.users_id  = cd.user_id 
	      LEFT JOIN work_group wg ON wg.id = ug.group_id 
	 GROUP BY wg.name;
  END
//








