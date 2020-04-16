USE VKontakte;
/*
SELECT * FROM profiles;
SELECT * FROM likes WHERE target_id = 55;
SELECT * FROM target_types;
SELECT * FROM users WHERE id = 55;
*/
-- 1 --
SELECT p.user_id,
       CONCAT(u.first_name, ' ', u.last_name) AS full_name,
       p.birthday,
       COUNT(l.id) as liked
  FROM profiles AS p
    INNER JOIN users AS u 
       ON u.id = p.user_id -- не должно быть профиля без юзера 
    LEFT JOIN likes AS l 
       ON l.target_id = p.user_id AND target_type_id = 2
GROUP BY p.user_id, 
         full_name, 
         p.birthday 
ORDER BY p.birthday DESC LIMIT 10;


-- 2 --
SELECT gender,
       COUNT(l.id) AS total
  FROM profiles AS p
    INNER JOIN likes AS l 
       ON l.user_id  = p.user_id 
GROUP BY gender
ORDER BY total DESC 
LIMIT 1;
 
  
  
-- 3 --
SELECT CONCAT(first_name, ' ', last_name) AS user,
       (COUNT(l.id) + COUNT(m.id) + COUNT(msg.id)) AS overall_activity 
  FROM users AS u
    LEFT JOIN likes AS l ON l.user_id = u.id
    LEFT JOIN media AS m ON m.user_id = u.id
    LEFT JOIN messages AS msg ON msg.from_user_id = u.id
GROUP BY user
ORDER BY overall_activity
LIMIT 10;
       
      


	


