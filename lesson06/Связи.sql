-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

-- Изменяем тип столбца при необходимости
ALTER TABLE profiles DROP FOREIGN KEY profiles_photo_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
      
-- Смотрим структурв таблицы
DESC messages;

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

-- Если нужно удалить
ALTER TABLE messages DROP FOREIGN KEY messages_to_user_id_fk;

ALTER TABLE friendship
  ADD CONSTRAINT user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
       ON DELETE CASCADE,
  ADD CONSTRAINT friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
       ON DELETE CASCADE;
    
ALTER TABLE friendship DROP FOREIGN KEY user_id_fk;
ALTER TABLE friendship DROP FOREIGN KEY friend_id_fk;

ALTER TABLE friendship
  ADD CONSTRAINT status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
       ON DELETE CASCADE;
          
 ALTER TABLE media
  ADD CONSTRAINT media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
       ON DELETE CASCADE;
            
 ALTER TABLE communities_users
  ADD CONSTRAINT community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id)
       ON DELETE CASCADE,
  ADD CONSTRAINT community_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
       ON DELETE CASCADE;
            
  ALTER TABLE posts
    ADD CONSTRAINT post_media_id_fk
      FOREIGN KEY (media_id) REFERENCES media(id)
         ON DELETE CASCADE,      
    ADD CONSTRAINT post_community_id_fk
      FOREIGN KEY (community_id) REFERENCES communities(id)
         ON DELETE CASCADE,         
    ADD CONSTRAINT posts_user_id_fk 
      FOREIGN KEY (user_id) REFERENCES users(id)
         ON DELETE CASCADE;
         
        
  ALTER TABLE likes
  ADD CONSTRAINT target_type_id_fk
    FOREIGN KEY (target_type_id) REFERENCES target_types(id)
       ON DELETE CASCADE,
       
  ADD CONSTRAINT like_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
       ON DELETE CASCADE;
        
        
        