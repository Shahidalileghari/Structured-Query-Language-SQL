# Capstone: Commerce Database Engineering

## Functional requirements
- Maintain customers and multiple addresses.
- Organize products with hierarchical categories.
- Track available and reserved stock by warehouse.
- Support carts, orders, item snapshots, payment attempts, shipment status, and reviews.
- Produce monthly revenue, customer lifetime value, low-stock, and product performance reports.

## Non-functional requirements
- Referential integrity and meaningful constraints.
- Monetary precision and currency-aware reporting.
- Versioned schema scripts and repeatable sample data.
- Least-privilege roles and secret management.
- Explainable indexing decisions and performance evidence.
- Automated checks and documented backup/restore procedure.

## Deliverables
1. ER diagram (draw one from `schema-reference.md`).
2. At least 10 additional SQL queries, including 2 window-function queries.
3. One safe transaction design for order placement.
4. One index experiment with before/after `EXPLAIN` output.
5. One new migration and a documented rollback/forward-fix plan.
6. A test plan covering constraints, foreign keys, order totals, and inventory.
7. An operations runbook with backup, restore, monitoring, and incident steps.

## Acceptance criteria
- A new developer can start the database using documented steps.
- Seed data loads in documented order.
- Integrity checks pass in a live PostgreSQL environment.
- Query assumptions, edge cases, and limitations are documented.
- No production secrets or real customer data are committed.
