SET search_path TO commerce, public;

-- Recursive CTE for hierarchical categories.
WITH RECURSIVE category_tree AS (
  SELECT category_id, parent_category_id, name, 0 AS depth
  FROM categories WHERE parent_category_id IS NULL
  UNION ALL
  SELECT c.category_id, c.parent_category_id, c.name, ct.depth + 1
  FROM categories c JOIN category_tree ct ON c.parent_category_id = ct.category_id
)
SELECT * FROM category_tree ORDER BY depth, name;

-- JSONB audit inspection
SELECT table_name, action, changed_at, new_row ->> 'sku' AS sku
FROM audit_log
ORDER BY changed_at DESC LIMIT 20;

-- Inspect a query plan before optimizing.
EXPLAIN (ANALYZE, BUFFERS)
SELECT order_id, placed_at, total_amount
FROM orders
WHERE customer_id = 1
ORDER BY placed_at DESC
LIMIT 20;

-- PostgreSQL features to explore: partial indexes, GIN, JSONB, partitioning,
-- materialized views, advisory locks, EXPLAIN, VACUUM/ANALYZE, pg_stat_statements.
