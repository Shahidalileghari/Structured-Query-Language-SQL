-- Indexes for common joins, lookups, and operational screens.
SET search_path TO commerce, public;

CREATE INDEX IF NOT EXISTS idx_addresses_customer ON customer_addresses(customer_id);
CREATE INDEX IF NOT EXISTS idx_categories_parent ON categories(parent_category_id);
CREATE INDEX IF NOT EXISTS idx_product_categories_category ON product_categories(category_id, product_id);
CREATE INDEX IF NOT EXISTS idx_products_status_name ON products(status, name);
CREATE INDEX IF NOT EXISTS idx_inventory_product ON inventory(product_id);
CREATE INDEX IF NOT EXISTS idx_carts_customer_status ON carts(customer_id, status);
CREATE INDEX IF NOT EXISTS idx_orders_customer_placed ON orders(customer_id, placed_at DESC);
CREATE INDEX IF NOT EXISTS idx_orders_status_placed ON orders(status, placed_at DESC);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_order_items_product ON order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_payments_order_status ON payments(order_id, status);
CREATE INDEX IF NOT EXISTS idx_shipments_order_status ON shipments(order_id, status);
CREATE INDEX IF NOT EXISTS idx_reviews_product_status ON reviews(product_id, status);
CREATE INDEX IF NOT EXISTS idx_audit_log_table_changed ON audit_log(table_name, changed_at DESC);

-- Optional full-text search example; evaluate against actual workload.
CREATE INDEX IF NOT EXISTS idx_products_search
    ON products USING GIN (to_tsvector('english', coalesce(name, '') || ' ' || coalesce(description, '')));
