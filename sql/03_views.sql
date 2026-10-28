SET search_path TO commerce, public;

CREATE OR REPLACE VIEW product_catalog AS
SELECT p.product_id, p.sku, p.name, p.description, p.unit_price, p.currency,
       p.status, COALESCE(SUM(i.quantity_on_hand - i.quantity_reserved), 0)::BIGINT AS available_stock
FROM products p
LEFT JOIN inventory i ON i.product_id = p.product_id
GROUP BY p.product_id;

CREATE OR REPLACE VIEW order_summary AS
SELECT o.order_id, o.order_number, o.customer_id, o.status, o.currency,
       o.subtotal, o.tax_amount, o.shipping_amount, o.discount_amount, o.total_amount,
       o.placed_at, COUNT(oi.order_item_id) AS line_count,
       COALESCE(SUM(oi.quantity), 0) AS total_units
FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id;

CREATE OR REPLACE VIEW published_product_reviews AS
SELECT r.review_id, r.product_id, p.name AS product_name, r.customer_id,
       r.rating, r.title, r.body, r.created_at
FROM reviews r
JOIN products p ON p.product_id = r.product_id
WHERE r.status = 'published';
