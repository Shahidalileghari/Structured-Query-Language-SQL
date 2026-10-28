SET search_path TO commerce, public;

-- Revenue by month (exclude cancelled/refunded orders).
SELECT date_trunc('month', placed_at)::date AS month,
       currency, SUM(total_amount) AS gross_revenue, COUNT(*) AS order_count
FROM orders
WHERE status IN ('confirmed', 'processing', 'shipped', 'delivered')
GROUP BY 1, 2 ORDER BY 1, 2;

-- Best-selling products using immutable order snapshots.
SELECT sku_snapshot, product_name_snapshot, SUM(quantity) AS units_sold,
       SUM(line_total) AS merchandise_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status IN ('confirmed', 'processing', 'shipped', 'delivered')
GROUP BY 1, 2 ORDER BY units_sold DESC, merchandise_revenue DESC;

-- Customer spend ranking with a window function.
WITH customer_spend AS (
  SELECT c.customer_id, c.email, COALESCE(SUM(o.total_amount) FILTER
    (WHERE o.status IN ('confirmed','processing','shipped','delivered')), 0) AS spend
  FROM customers c LEFT JOIN orders o ON o.customer_id = c.customer_id
  GROUP BY c.customer_id, c.email
)
SELECT *, DENSE_RANK() OVER (ORDER BY spend DESC) AS spend_rank
FROM customer_spend ORDER BY spend_rank, customer_id;

-- Low-stock products across warehouses.
SELECT p.sku, p.name, w.code, i.quantity_on_hand, i.quantity_reserved,
       i.quantity_on_hand - i.quantity_reserved AS available
FROM inventory i JOIN products p USING (product_id)
JOIN warehouses w USING (warehouse_id)
WHERE i.quantity_on_hand - i.quantity_reserved <= 5
ORDER BY available, p.sku;

-- Full-text catalog search.
SELECT product_id, name, unit_price
FROM products
WHERE to_tsvector('english', coalesce(name, '') || ' ' || coalesce(description, ''))
      @@ plainto_tsquery('english', 'database handbook');
