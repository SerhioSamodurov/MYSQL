USE shop;
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


START TRANSACTION;
SELECT total from accounts where user_id = 4;
update accounts set total = total - 2000 where user_id = 4;
update accounts set total = total + 2000 where user_id is null;
select * from accounts;
commit; -- закоммитит изменени€


start transaction;
update accounts set total = total - 2000 where user_id = 4;
update accounts set total = total + 2000 where user_id is null;
select * from accounts;
rollback; -- отменит изменени€
commit;




