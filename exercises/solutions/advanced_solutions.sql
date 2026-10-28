SET search_path TO commerce, public;
-- A1
WITH monthly AS (
  SELECT date_trunc('month', placed_at)::date AS month, SUM(total_amount) AS revenue
  FROM orders WHERE status IN ('confirmed','processing','shipped','delivered')
  GROUP BY 1
)
SELECT month, revenue, LAG(revenue) OVER(ORDER BY month) AS prior_month,
       revenue - LAG(revenue) OVER(ORDER BY month) AS change
FROM monthly ORDER BY month;
-- A2
SELECT DISTINCT customer_id,
       FIRST_VALUE(order_number) OVER(PARTITION BY customer_id ORDER BY placed_at) AS first_order,
       FIRST_VALUE(order_number) OVER(PARTITION BY customer_id ORDER BY placed_at DESC) AS latest_order
FROM orders;
-- A3
WITH RECURSIVE tree AS (
  SELECT category_id, parent_category_id, name, 0 AS depth FROM categories WHERE parent_category_id IS NULL
  UNION ALL
  SELECT c.category_id, c.parent_category_id, c.name, t.depth+1
  FROM categories c JOIN tree t ON c.parent_category_id=t.category_id
)
SELECT * FROM tree ORDER BY depth, name;
-- A4: differences may be valid when shipping/tax/discounts apply; investigate rather than assume bug.
SELECT o.order_number, o.subtotal, COALESCE(SUM(oi.line_total),0) AS item_total,
       o.subtotal - COALESCE(SUM(oi.line_total),0) AS difference
FROM orders o LEFT JOIN order_items oi USING(order_id)
GROUP BY o.order_id
HAVING o.subtotal <> COALESCE(SUM(oi.line_total),0);
-- A5: choose a representative query and compare EXPLAIN ANALYZE plans before/after index changes.
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM orders WHERE customer_id=1 ORDER BY placed_at DESC LIMIT 20;
