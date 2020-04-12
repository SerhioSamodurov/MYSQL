USE shop;

-- 1
SELECT u.name, COUNT(o.id) as orders
FROM users as u
JOIN orders as o ON u.id = o.user_id
GROUP BY u.name;

-- 2
SELECT c.name, p.name, p.desription, p.price
FROM products as p
JOIN catalogs as c on p.catalog_id = c.id;


-- 3
SELECT f.id, c.name, c2.name 
FROM flights as f
JOIN cities as c on f.from_city = c.label
JOIN cities as c2 on f.to_city = c2.label
ORDER BY id;
