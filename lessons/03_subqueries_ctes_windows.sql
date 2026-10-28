SET search_path TO commerce, public;

-- Scalar subquery
SELECT name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products);

-- CTE for readability
WITH product_sales AS (
  SELECT product_id, SUM(quantity) AS units_sold
  FROM order_items GROUP BY product_id
)
SELECT p.name, COALESCE(s.units_sold, 0) AS units_sold
FROM products p LEFT JOIN product_sales s USING (product_id)
ORDER BY units_sold DESC;

-- Rank products within each category
SELECT c.name AS category, p.name AS product,
       p.unit_price,
       DENSE_RANK() OVER (PARTITION BY c.category_id ORDER BY p.unit_price DESC) AS price_rank
FROM products p
JOIN product_categories pc USING (product_id)
JOIN categories c USING (category_id);

-- Running order total per customer
SELECT customer_id, order_number, placed_at, total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY placed_at
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM orders;
