USE VKontakte

/*
TRUNCATE communities;
TRUNCATE communities_users;
TRUNCATE friendship;
TRUNCATE friendship_statuses;
TRUNCATE media;
TRUNCATE media_types;
TRUNCATE messages;
TRUNCATE profiles;
TRUNCATE users;
*/

-- ������� ������� ��������
INSERT INTO friendship_statuses (name) VALUES
   ('Requested'),
   ('Confirmed'),
   ('Rejected');
-- SELECT * FROM friendship_statuses; 

-- ������� ������� ����� �����
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('audio'),
  ('video');
-- SELECT * FROM media_types;

-- ��������� � ���������� ������ ������� users
ALTER TABLE users 
  MODIFY COLUMN phone VARCHAR(13) NOT NULL UNIQUE; 
 
UPDATE users SET phone = 
   CONCAT(phone, FLOOR(100 + RAND() * 899)
   );
-- SELECT * FROM users;

-- ���������� ������� � ����� ����� ��� ������ ������������� �������
-- �.�. ��������������� �� ���������� ������
CREATE TEMPORARY TABLE  genders (gender CHAR(1));
INSERT INTO genders VALUES ('m'), ('f');
-- SELECT * FROM genders
 
UPDATE profiles SET gender = (
   SELECT gender FROM genders ORDER BY RAND() LIMIT 1
   );
-- SELECT * FROM profiles;

-- ���������� ������� messsages, �.�. ���� ����� ������������ ��������� 
-- ���� ����  
UPDATE messages SET 
  from_user_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);
-- SELECT * FROM messages;


-- ���������� ������� �����
UPDATE media SET 
  media_type_id = FLOOR(1 + RAND() * 3);


UPDATE media SET 
  user_id = FLOOR(1 + RAND() * 100);   
 
 
UPDATE media SET size  = FLOOR(1 + RAND() * 9999)
   WHERE size < 1000; 


UPDATE media SET 
  filename  =  CONCAT('http://dropbox/vk/file_', FLOOR(1 + RAND() * 9999)
 );
-- SELECT * FROM media;

ALTER TABLE media MODIFY COLUMN metadata JSON;

UPDATE media SET metadata  = CONCAT('{"owner":"',
   (SELECT CONCAT(first_name, ' ', last_name) 
    FROM users 
    WHERE id = user_id), 
    '"}');
-- SELECT * FROM media;


/*
SELECT id, JSON_EXTRACT(metadata, '$.owner') as owner
FROM media

UPDATE media SET metadata = 
 JSON_REPLACE(metadata, '$.owner', 'REPLACED VALUE')
WHERE id = 1;
*/
   
-- ���������� ������� friendship
UPDATE friendship SET 
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100); 
 
UPDATE friendship SET 
  status_id = FLOOR(1 + RAND() * 3);
-- SELECT * FROM friendship;
 
-- ���������� ������� communities_users
UPDATE communities_users SET 
  community_id = FLOOR(1 + RAND() * 15),
  user_id = FLOOR(1 + RAND() * 100);
-- SELECT * FROM communities_users;  
-- SELECT * FROM communities;
 