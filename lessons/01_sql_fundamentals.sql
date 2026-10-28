-- Run after schema and seed scripts.
SET search_path TO commerce, public;

-- SELECT, aliases, and limiting
SELECT product_id, name AS product_name, unit_price
FROM products
WHERE status = 'active'
ORDER BY unit_price DESC
LIMIT 10;

-- Filtering and NULL
SELECT customer_id, email, phone
FROM customers
WHERE status = 'active' AND phone IS NOT NULL;

-- CASE expressions
SELECT sku, name,
       CASE WHEN unit_price >= 500 THEN 'premium'
            WHEN unit_price >= 50 THEN 'standard'
            ELSE 'budget' END AS price_band
FROM products;

-- DISTINCT and expressions
SELECT DISTINCT currency FROM products;

-- INSERT / UPDATE / DELETE: practice inside a transaction and roll back.
BEGIN;
INSERT INTO categories (name, slug) VALUES ('Practice', 'practice');
UPDATE categories SET description = 'Temporary practice row' WHERE slug = 'practice';
SELECT * FROM categories WHERE slug = 'practice';
ROLLBACK;
