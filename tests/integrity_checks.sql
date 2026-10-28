SET search_path TO commerce, public;

DO $$
BEGIN
  IF (SELECT COUNT(*) FROM customers) < 3 THEN
    RAISE EXCEPTION 'Expected at least 3 seed customers';
  END IF;
  IF (SELECT COUNT(*) FROM products) < 4 THEN
    RAISE EXCEPTION 'Expected at least 4 seed products';
  END IF;
  IF EXISTS (SELECT 1 FROM inventory WHERE quantity_on_hand < 0 OR quantity_reserved < 0 OR quantity_reserved > quantity_on_hand) THEN
    RAISE EXCEPTION 'Inventory integrity check failed';
  END IF;
  IF EXISTS (
    SELECT 1 FROM orders
    WHERE total_amount <> subtotal + tax_amount + shipping_amount - discount_amount
  ) THEN
    RAISE EXCEPTION 'Order total arithmetic check failed';
  END IF;
  IF EXISTS (
    SELECT 1 FROM order_items oi
    LEFT JOIN orders o ON o.order_id = oi.order_id
    WHERE o.order_id IS NULL
  ) THEN
    RAISE EXCEPTION 'Orphan order item found';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM product_catalog WHERE sku = 'DBK-001') THEN
    RAISE EXCEPTION 'Product catalog view missing expected seed product';
  END IF;
END;
$$;

SELECT 'All integrity assertions passed.' AS result;
