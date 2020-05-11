USE call_center;
DROP VIEW IF EXISTS interval_calls;
CREATE OR REPLACE VIEW interval_calls AS
SELECT dt.date,
       CASE WHEN dt.time BETWEEN '00:00:00' AND '00:59:59' THEN '00:00:00' 
            WHEN dt.time BETWEEN '01:00:00' AND '01:59:59' THEN '01:00:00'
            WHEN dt.time BETWEEN '02:00:00' AND '02:59:59' THEN '02:00:00'
            WHEN dt.time BETWEEN '03:00:00' AND '03:59:59' THEN '03:00:00'
            WHEN dt.time BETWEEN '04:00:00' AND '04:59:59' THEN '04:00:00'
            WHEN dt.time BETWEEN '05:00:00' AND '05:59:59' THEN '05:00:00'
            WHEN dt.time BETWEEN '06:00:00' AND '06:59:59' THEN '06:00:00'
            WHEN dt.time BETWEEN '07:00:00' AND '07:59:59' THEN '07:00:00'
            WHEN dt.time BETWEEN '08:00:00' AND '08:59:59' THEN '08:00:00'
            WHEN dt.time BETWEEN '09:00:00' AND '09:59:59' THEN '09:00:00'
            WHEN dt.time BETWEEN '10:00:00' AND '10:59:59' THEN '10:00:00'
            WHEN dt.time BETWEEN '11:00:00' AND '11:59:59' THEN '11:00:00'
            WHEN dt.time BETWEEN '12:00:00' AND '12:59:59' THEN '12:00:00'
            WHEN dt.time BETWEEN '13:00:00' AND '13:59:59' THEN '13:00:00'
            WHEN dt.time BETWEEN '14:00:00' AND '14:59:59' THEN '14:00:00'
            WHEN dt.time BETWEEN '15:00:00' AND '15:59:59' THEN '15:00:00'
            WHEN dt.time BETWEEN '16:00:00' AND '16:59:59' THEN '16:00:00'
            WHEN dt.time BETWEEN '17:00:00' AND '17:59:59' THEN '17:00:00'
            WHEN dt.time BETWEEN '18:00:00' AND '18:59:59' THEN '18:00:00'
            WHEN dt.time BETWEEN '19:00:00' AND '19:59:59' THEN '19:00:00'
            WHEN dt.time BETWEEN '20:00:00' AND '20:59:59' THEN '20:00:00'
            WHEN dt.time BETWEEN '21:00:00' AND '21:59:59' THEN '21:00:00'
            WHEN dt.time BETWEEN '22:00:00' AND '22:59:59' THEN '22:00:00'
            WHEN dt.time BETWEEN '23:00:00' AND '23:59:59' THEN '23:00:00'
       END time_interval,
       dt.group_line,
       dt.full_name,
       SUM(dt.cnt) AS 'всего',
       SUM(CASE WHEN call_status = 'answered' THEN 1 ELSE 0 END) AS 'отвечено',
       SUM(CASE WHEN call_status = 'interrupted' THEN 1 ELSE 0 END) AS 'потеряно',
       SUM(CASE WHEN call_status = 'transfer' THEN 1 ELSE 0 END) AS 'переведено',
       SUM(CASE WHEN call_status = 'connection_error' THEN 1 ELSE 0 END) AS 'ошибка'
    FROM (
          SELECT 
           ROW_NUMBER() OVER(PARTITION BY cd.customer_phone) AS cnt, 
           wg.name AS group_line,
           CONCAT(u.first_name, ' ', u.last_name) AS full_name,
           cs.name AS call_status,
           CAST(cd.begin_at as DATE) AS date, 
           CAST(cd.begin_at as TIME) AS time
        FROM calls_detail cd
           LEFT JOIN users u 
                ON u.id = cd.user_id
           LEFT JOIN users_group ug 
                ON ug.users_id = cd.user_id
           INNER JOIN work_group  wg 
                ON wg.id = ug.group_id
           LEFT JOIN calls_status cs 
                ON cs.id = cd.status_id) AS dt
GROUP BY dt.date, time_interval, dt.group_line, dt.full_name;


DROP VIEW IF EXISTS status_agents;
CREATE OR REPLACE VIEW status_agents AS
SELECT wg.name AS 'Линия',
       CONCAT(u.first_name, ' ', u.last_name) AS 'сотрудник',
       ws.name AS 'статус',
       rtus.update_at AS 'время_начала'
  FROM real_time_user_status rtus
    LEFT JOIN users u
         ON u.id = rtus.user_id
    LEFT JOIN work_statuses ws 
         ON ws.id = rtus.status_id
    LEFT JOIN users_group ug
         ON ug.users_id = rtus.user_id
    LEFT JOIN work_group wg 
         ON wg.id = ug.group_id 
    WHERE wg.id <> 1;
      

        
    




