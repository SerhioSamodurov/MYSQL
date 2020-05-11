
/*
start transaction;
SELECT total from accounts where user_id = 4;
savepoint accounts_4;
update accounts set total = total - 2000 where user_id = 4;
SELECT total from accounts where user_id = 4;
rollback to savepoint accounts_4;
SELECT total from accounts where user_id = 4;
commit;
*/

START TRANSACTION;
update accounts set total = total - 2000 where user_id = 4;
update accounts set total = total + 2000 where user_id is null;
SELECT total from accounts where user_id = 4;
Commit;

START TRANSACTION;
update accounts set total = total - 1000 where user_id = 4;
update accounts set total = total + 2000 where user_id is null;
SELECT total from accounts where user_id = 4;
rollback;
commit;

use shop;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  user_id INT,
  total DECIMAL (11,2) COMMENT '—чет',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '—чета пользователей и интернет магазина';

INSERT INTO accounts (user_id, total) VALUES
  (4, 5000.00),
  (3, 0.00),
  (2, 200.00),
  (NULL, 25000.00);

 
SHOW VARIABLES LIKE 'innodb_log_%';

