# Query Performance

## A safe workflow

1. Capture the actual slow query and representative parameters.
2. Check row counts and data distribution.
3. Run `EXPLAIN (ANALYZE, BUFFERS)` in a safe environment; `ANALYZE` executes the query.
4. Compare estimated and actual rows, scan type, sort, join method, buffer hits/reads, and total time.
5. Add or adjust an index only when it supports a real access pattern.
6. Re-run with representative data and compare plans and timings.
7. Account for write overhead, index size, vacuuming, and cache effects.

## Index guidance

- B-tree indexes support equality, range, and ordering patterns.
- Composite index order matters; leading columns are particularly important.
- Partial indexes can help when queries consistently target a subset of rows.
- GIN can support full-text search and many JSONB operations.
- Indexes consume storage and slow writes; avoid indexing every column.

## Production cautions

Never treat one local timing as proof of an improvement. Use realistic data volumes, representative parameter values, and repeatable measurements. Be careful with `EXPLAIN ANALYZE` on mutating statements. Consider connection pooling, query timeouts, statistics, lock waits, and application-level N+1 query patterns.
