/*
���������� ����� ���������� ������, 
������� �������� 10 ����� ������� �������������.
*/

SELECT user_id,
       (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = profiles.user_id) as full_name,
       (YEAR(CURRENT_DATE()) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) as age,
       (SELECT COUNT(*) FROM likes WHERE user_id = profiles.user_id) as likes
FROM profiles 
HAVING likes > 0
ORDER BY age LIMIT 10;


/*
���������� ��� ������ �������� ������ (�����) - ������� ��� �������?
*/

SELECT gender, 
       SUM(likes) as likes
FROM (SELECT user_id, 
             gender,
            (SELECT COUNT(*) FROM likes WHERE user_id = profiles.user_id) as likes
      FROM profiles) as u
GROUP BY gender
      

/*
����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.
*/

SELECT d.user_id, 
       d.full_name, 
      (d.likes + d.messages + d.medias) as active  
FROM (SELECT user_id,
       (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = profiles.user_id) as full_name,
       (SELECT COUNT(*) FROM likes WHERE user_id = profiles.user_id) as likes,
       (SELECT COUNT(*) FROM messages WHERE from_user_id = profiles.user_id) as messages,
       (SELECT COUNT(*) FROM media WHERE user_id = profiles.user_id) as medias
FROM profiles) as d
ORDER BY active LIMIT 10


