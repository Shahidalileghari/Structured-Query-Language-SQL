SET search_path TO commerce, public;
-- I1
SELECT c.customer_id, c.email, COUNT(o.order_id) AS order_count
FROM customers c LEFT JOIN orders o USING (customer_id)
GROUP BY c.customer_id, c.email;
-- I2
SELECT p.product_id, p.name, COUNT(r.review_id) AS review_count, AVG(r.rating)::NUMERIC(3,2) AS avg_rating
FROM products p LEFT JOIN reviews r ON r.product_id=p.product_id AND r.status='published'
GROUP BY p.product_id, p.name;
-- I3
SELECT p.sku, p.name, COALESCE(SUM(i.quantity_on_hand-i.quantity_reserved),0) AS available
FROM products p LEFT JOIN inventory i USING(product_id)
GROUP BY p.product_id HAVING COALESCE(SUM(i.quantity_on_hand-i.quantity_reserved),0) < 10;
-- I4
SELECT c.customer_id, c.email,
       COALESCE(SUM(o.total_amount) FILTER (WHERE o.status NOT IN ('cancelled','refunded')),0) AS spend
FROM customers c LEFT JOIN orders o USING(customer_id)
GROUP BY c.customer_id, c.email;
-- I5
SELECT c.name AS category, p.name, p.unit_price,
       DENSE_RANK() OVER(PARTITION BY c.category_id ORDER BY p.unit_price DESC) AS price_rank
FROM products p JOIN product_categories pc USING(product_id) JOIN categories c USING(category_id);
