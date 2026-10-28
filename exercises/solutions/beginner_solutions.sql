SET search_path TO commerce, public;
-- B1
SELECT sku, name, unit_price FROM products WHERE status='active' ORDER BY unit_price DESC;
-- B2
SELECT customer_id, email FROM customers WHERE phone IS NULL;
-- B3
SELECT status, COUNT(*) FROM products GROUP BY status ORDER BY status;
-- B4
SELECT o.order_number, c.email FROM orders o JOIN customers c USING (customer_id);
-- B5
SELECT currency, AVG(unit_price)::NUMERIC(12,2) AS avg_price FROM products GROUP BY currency;
