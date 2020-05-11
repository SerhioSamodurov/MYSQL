USE call_center;

-- 5 операторов на кого выпало больше всего вызовов + % отвеченных
SELECT CONCAT(u.first_name, ' ', u.last_name) AS full_name,
       ip.phone,
       COUNT(*) AS count_call,
       (SELECT COUNT(*) 
           FROM calls_detail cd2 
             LEFT JOIN calls_status cs 
                  ON cs.id = cd2.status_id 
           WHERE cd2.user_id = cd.user_id AND cs.name = 'answered'           
                           ) AS answered, 
       ROUND((SELECT COUNT(*) FROM calls_detail cd2 LEFT JOIN calls_status cs ON cs.id = cd2.status_id    
               WHERE cd2.user_id = cd.user_id AND cs.name = 'answered')/COUNT(*) * 100, 2) AS 'service %' 
  FROM calls_detail AS cd
     INNER JOIN internal_phones AS ip 
           ON ip.user_id = cd.user_id 
     INNER JOIN users AS u 
           ON u.id = cd.user_id 
GROUP BY full_name, ip.phone
ORDER BY count_call DESC 
      LIMIT 10;
      

     
SELECT DISTINCT 
       group_line,
       AVG(cnt) OVER w AS average,
       MAX(cnt) OVER w AS max,
       MIN(cnt) OVER w AS min,
       SUM(cnt) OVER w AS group_sum,
       SUM(cnt) OVER() AS total ,
       SUM(cnt) OVER w / SUM(cnt) OVER() * 100 AS '%'
       
FROM (     
      SELECT CAST(cd.begin_at AS DATE) AS date
             , wg.name AS group_line
             , COUNT(*) AS cnt
         FROM work_group wg
           INNER JOIN users_group ug
                 ON ug.group_id = wg.id 
           INNER JOIN calls_detail cd 
                 ON cd.user_id = ug.users_id 
     WHERE wg.name NOT LIKE 'admin%'
     GROUP BY date, group_line
       ) AS array
     WINDOW w AS (PARTITION BY group_line);
      



