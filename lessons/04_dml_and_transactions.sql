SET search_path TO commerce, public;

-- Atomic multi-step transaction pattern (illustrative only).
BEGIN;
UPDATE inventory
SET quantity_reserved = quantity_reserved + 1, updated_at = now()
WHERE warehouse_id = 1 AND product_id = 2 AND quantity_on_hand - quantity_reserved >= 1;
-- In application code, inspect affected row count; if zero, fail/rollback.
-- Insert order and order_item rows only when reservation succeeds.
ROLLBACK; -- Keep the lesson non-destructive.

-- UPSERT for idempotent ingestion.
INSERT INTO inventory (warehouse_id, product_id, quantity_on_hand, quantity_reserved)
VALUES (1, 2, 60, 0)
ON CONFLICT (warehouse_id, product_id)
DO UPDATE SET quantity_on_hand = EXCLUDED.quantity_on_hand,
              updated_at = now();

-- Isolation and row-locking examples (run in a disposable DB):
-- SELECT * FROM inventory WHERE warehouse_id=1 AND product_id=2 FOR UPDATE;
