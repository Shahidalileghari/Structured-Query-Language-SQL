# Learning Roadmap: Beginner to Advanced

## Stage 1 — Fundamentals
Learn relational tables, rows, columns, data types, primary keys, `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `NULL`, `CASE`, and basic DML. Start with lesson 01.

**Deliverable:** Answer basic questions about the product catalog and customers.

## Stage 2 — Relational querying
Study inner/outer joins, one-to-many relationships, grouping, aggregates, `HAVING`, and duplicate-row pitfalls. Use lesson 02.

**Deliverable:** Customer order counts, product review summaries, and revenue reports.

## Stage 3 — Query composition
Learn scalar and correlated subqueries, CTEs, recursive CTEs, window functions, ranking, `LAG`, and running totals. Use lesson 03 and 05.

**Deliverable:** Customer lifetime value and product/category rankings.

## Stage 4 — Data modeling
Practice entities, attributes, cardinality, candidate keys, normalization, constraints, junction tables, and historical snapshots. Read `normalization-and-design.md`.

**Deliverable:** Extend the schema with promotions and returns without duplicating data unnecessarily.

## Stage 5 — Transactions and correctness
Study ACID, commit/rollback, isolation levels, row locks, deadlocks, optimistic concurrency, idempotency, and inventory reservation. Use lesson 04.

**Deliverable:** Design a safe order placement transaction that reserves stock atomically.

## Stage 6 — Performance
Read `performance.md`; inspect `EXPLAIN (ANALYZE, BUFFERS)`, choose indexes from query patterns, and understand sequential scans, index scans, selectivity, and statistics.

**Deliverable:** Document a measured query improvement with before/after plans.

## Stage 7 — Operations and security
Learn least privilege, secrets, backups, restore drills, migration rollback strategy, monitoring, PII minimization, retention, and incident response.

**Deliverable:** Write a runbook for backup restoration and a restricted read-only reporting role.

## Stage 8 — Capstone
Complete all requirements in `project-requirements.md`. Use tests, explain design tradeoffs, and document what was and was not tested.
