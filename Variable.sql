use shop;
select @total :=COUNT(*) from products;
select @total;

select @price := max(price) from products;
select * from products where price = @price;

set @last = now() - INTERVAL 7 DAY;
select CURDATE(), @last; 


SET @start := 0;
select @start := @start + 1 as id, name from cities;


CREATE TEMPORARY TABLE table_name(
   id INT,
   name VARCHAR(255)  
 );

DESCRIBE table_name;


PREPARE ver FROM 'SELECT VERSION()';
EXECUTE ver;


PREPARE prd FROM 'SELECT id, name, price FROM products WHERE catalog_id = ?';
SET @catalog_id = 1;
EXECUTE prd USING @catalog_id;

-- Представления
SELECT * FROM catalogs;
CREATE VIEW cat AS SELECT * FROM catalogs ORDER BY name;
SELECT * FROM cat;
SHOW TABLES;


CREATE VIEW cat_reverse (catalog , catalog_id)
  AS SELECT name, id FROM catalogs;
SELECT * FROM cat_reverse;


CREATE OR REPLACE VIEW namecat (id, name, total)
  AS SELECT id, name ,LENGTH(name) FROM catalogs;
SELECT * FROM namecat;

