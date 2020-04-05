-- 1
UPDATE users
  SET created_at = CASE WHEN created_at IS NULL THEN NOW() ELSE created_at END,
      update_at = CASE WHEN update_at IS NULL THEN NOW() ELSE update_at END;

-- 2   
UPDATE users_2
   SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
       update_at = STR_TO_DATE(update_at, '%d.%m.%Y %H:%i');
      
ALTER TABLE users_2 MODIFY COLUMN created_at DATETIME;
ALTER TABLE users_2 MODIFY COLUMN update_at DATETIME;


-- 3
SELECT value, CASE WHEN value > 0 THEN 1 ELSE 2 END AS id
FROM storehouses_products
ORDER BY id, value;


-- 4
SELECT * FROM users WHERE birthday_at IN ('may', 'august')

-- 5
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


-- 6
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))
  -- , ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) 
FROM users;


-- 7
SELECT WEEKDAY(CONCAT(YEAR(CURRENT_DATE), DATE_FORMAT(birthday_at, '-%m-%d'))) as dayweek, count(*)
FROM users
GROUP BY dayweek
ORDER BY dayweek;




