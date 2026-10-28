SET search_path TO commerce, public;
BEGIN;

INSERT INTO customers (customer_id, email, first_name, last_name, phone, status) VALUES
(1, 'amina@example.test', 'Amina', 'Khan', '+1-555-0101', 'active'),
(2, 'bilal@example.test', 'Bilal', 'Ahmed', '+1-555-0102', 'active'),
(3, 'sara@example.test', 'Sara', 'Malik', NULL, 'active')
ON CONFLICT (customer_id) DO NOTHING;

INSERT INTO customer_addresses (address_id, customer_id, address_type, recipient_name, line1, city, region, postal_code, country_code, is_default) VALUES
(1, 1, 'both', 'Amina Khan', '10 Example Street', 'Karachi', 'Sindh', '74000', 'PK', true),
(2, 2, 'both', 'Bilal Ahmed', '22 Sample Road', 'Lahore', 'Punjab', '54000', 'PK', true),
(3, 3, 'shipping', 'Sara Malik', '5 Demo Avenue', 'Islamabad', 'ICT', '44000', 'PK', true)
ON CONFLICT (address_id) DO NOTHING;

INSERT INTO categories (category_id, name, slug, description) VALUES
(1, 'Computing', 'computing', 'Computers and accessories'),
(2, 'Accessories', 'accessories', 'Useful everyday technology accessories'),
(3, 'Books', 'books', 'Technical and educational books')
ON CONFLICT (category_id) DO NOTHING;

INSERT INTO products (product_id, sku, name, description, unit_price, currency, status, weight_grams) VALUES
(1, 'LAP-001', 'Developer Laptop', 'Fictional laptop for development labs', 899.00, 'USD', 'active', 1800),
(2, 'KEY-001', 'Mechanical Keyboard', 'Fictional mechanical keyboard', 79.50, 'USD', 'active', 850),
(3, 'DBK-001', 'Database Design Handbook', 'Fictional database learning book', 34.00, 'USD', 'active', 500),
(4, 'MOU-001', 'Wireless Mouse', 'Fictional wireless mouse', 25.00, 'USD', 'active', 120)
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO product_categories (product_id, category_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 2)
ON CONFLICT DO NOTHING;

INSERT INTO warehouses (warehouse_id, code, name, city, country_code) VALUES
(1, 'KHI-01', 'Karachi Main Warehouse', 'Karachi', 'PK'),
(2, 'LHR-01', 'Lahore Fulfilment Center', 'Lahore', 'PK')
ON CONFLICT (warehouse_id) DO NOTHING;

INSERT INTO inventory (warehouse_id, product_id, quantity_on_hand, quantity_reserved) VALUES
(1, 1, 12, 2), (1, 2, 60, 5), (1, 3, 100, 4), (1, 4, 80, 3),
(2, 1, 5, 1), (2, 2, 25, 0), (2, 3, 40, 0), (2, 4, 30, 2)
ON CONFLICT (warehouse_id, product_id) DO NOTHING;

INSERT INTO carts (cart_id, customer_id, status) VALUES (1, 1, 'open')
ON CONFLICT (cart_id) DO NOTHING;
INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (1, 2, 1), (1, 4, 2)
ON CONFLICT (cart_id, product_id) DO NOTHING;

INSERT INTO orders (order_id, order_number, customer_id, billing_address_id, shipping_address_id, status, currency, subtotal, tax_amount, shipping_amount, discount_amount, total_amount, placed_at)
VALUES
(1, 'ORD-2026-0001', 1, 1, 1, 'delivered', 'USD', 129.50, 10.36, 5.00, 0.00, 144.86, now() - interval '14 days'),
(2, 'ORD-2026-0002', 2, 2, 2, 'confirmed', 'USD', 34.00, 2.72, 4.00, 5.00, 35.72, now() - interval '2 days')
ON CONFLICT (order_id) DO NOTHING;

INSERT INTO order_items (order_item_id, order_id, product_id, sku_snapshot, product_name_snapshot, unit_price, quantity) VALUES
(1, 1, 2, 'KEY-001', 'Mechanical Keyboard', 79.50, 1),
(2, 1, 4, 'MOU-001', 'Wireless Mouse', 25.00, 2),
(3, 2, 3, 'DBK-001', 'Database Design Handbook', 34.00, 1)
ON CONFLICT (order_item_id) DO NOTHING;

INSERT INTO payments (payment_id, order_id, provider, provider_reference, status, amount, currency, paid_at) VALUES
(1, 1, 'ExamplePay', 'PAY-DEMO-0001', 'captured', 144.86, 'USD', now() - interval '13 days'),
(2, 2, 'ExamplePay', 'PAY-DEMO-0002', 'authorized', 35.72, 'USD', NULL)
ON CONFLICT (payment_id) DO NOTHING;

INSERT INTO shipments (shipment_id, order_id, carrier, tracking_number, status, shipped_at, delivered_at) VALUES
(1, 1, 'Demo Logistics', 'TRACK-DEMO-0001', 'delivered', now() - interval '12 days', now() - interval '10 days'),
(2, 2, 'Demo Logistics', NULL, 'pending', NULL, NULL)
ON CONFLICT (shipment_id) DO NOTHING;

INSERT INTO reviews (review_id, customer_id, product_id, rating, title, body, status) VALUES
(1, 1, 2, 5, 'Great typing feel', 'Sample review for SQL practice.', 'published'),
(2, 2, 3, 4, 'Useful reference', 'Fictional sample review.', 'published')
ON CONFLICT (review_id) DO NOTHING;

-- Keep identity sequences above the explicit demo IDs.
SELECT setval(pg_get_serial_sequence('commerce.customers', 'customer_id'), GREATEST((SELECT COALESCE(MAX(customer_id), 1) FROM customers), 1));
SELECT setval(pg_get_serial_sequence('commerce.customer_addresses', 'address_id'), GREATEST((SELECT COALESCE(MAX(address_id), 1) FROM customer_addresses), 1));
SELECT setval(pg_get_serial_sequence('commerce.categories', 'category_id'), GREATEST((SELECT COALESCE(MAX(category_id), 1) FROM categories), 1));
SELECT setval(pg_get_serial_sequence('commerce.products', 'product_id'), GREATEST((SELECT COALESCE(MAX(product_id), 1) FROM products), 1));
SELECT setval(pg_get_serial_sequence('commerce.warehouses', 'warehouse_id'), GREATEST((SELECT COALESCE(MAX(warehouse_id), 1) FROM warehouses), 1));
SELECT setval(pg_get_serial_sequence('commerce.carts', 'cart_id'), GREATEST((SELECT COALESCE(MAX(cart_id), 1) FROM carts), 1));
SELECT setval(pg_get_serial_sequence('commerce.orders', 'order_id'), GREATEST((SELECT COALESCE(MAX(order_id), 1) FROM orders), 1));
SELECT setval(pg_get_serial_sequence('commerce.order_items', 'order_item_id'), GREATEST((SELECT COALESCE(MAX(order_item_id), 1) FROM order_items), 1));
SELECT setval(pg_get_serial_sequence('commerce.payments', 'payment_id'), GREATEST((SELECT COALESCE(MAX(payment_id), 1) FROM payments), 1));
SELECT setval(pg_get_serial_sequence('commerce.shipments', 'shipment_id'), GREATEST((SELECT COALESCE(MAX(shipment_id), 1) FROM shipments), 1));
SELECT setval(pg_get_serial_sequence('commerce.reviews', 'review_id'), GREATEST((SELECT COALESCE(MAX(review_id), 1) FROM reviews), 1));

COMMIT;
