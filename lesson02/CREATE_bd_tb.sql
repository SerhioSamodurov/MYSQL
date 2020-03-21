-- DROP DATABASE IF EXISTS example;
CREATE DATABASE IF NOT EXISTS example;
USE example;

-- DROP TABLE IF EXISTS users
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) ,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
 ) ;
 

 INSERT INTO users VALUES
        (DEFAULT, 'Max', DEFAULT),
        (DEFAULT, 'Leo', DEFAULT),
        (DEFAULT, 'Kate', DEFAULT),
        (DEFAULT, 'Igor', DEFAULT),
        (DEFAULT, 'Ragnar', DEFAULT),
        (DEFAULT, 'Geralt', DEFAULT),
        (DEFAULT, 'Rapuncel', DEFAULT),
        (DEFAULT, 'Irina', DEFAULT),
        (DEFAULT, 'Viktor', DEFAULT),
        (DEFAULT, 'Bob', DEFAULT),
        (DEFAULT, 'Jane', DEFAULT);

-- SELECT * FROM users;
SELECT * FROM users LIMIT 5;
