# SQL & Database Mastery

**Repository name:** `sql-database-mastery`  
**Repository description:** A practical, fundamentals-to-advanced SQL and database engineering curriculum featuring a production-style PostgreSQL e-commerce schema, migrations, realistic seed data, query labs, indexes, views, transactions, procedures, security guidance, tests, and automation.

A hands-on SQL learning repository designed to move from beginner queries to database design and production-minded engineering. The project uses **PostgreSQL 15+** and a fictional commerce platform as its running example.

## Learning outcomes

- Write and reason about `SELECT`, filtering, sorting, joins, grouping, subqueries, CTEs, and window functions.
- Design normalized relational schemas and understand keys, constraints, cardinality, and referential integrity.
- Build and evolve a complete database with versioned migrations and reproducible seed data.
- Model customers, addresses, products, categories, inventory, carts, orders, payments, shipments, and reviews.
- Use transactions, isolation concepts, locking, indexes, query plans, views, and materialized views.
- Apply practical security, least privilege, backup, restore, monitoring, and deployment practices.
- Practice with exercises, solutions, tests, and an end-to-end capstone.

## Repository structure

```text
sql-database-mastery/
├── README.md
├── DESCRIPTION.md
├── LICENSE
├── .gitignore
├── .env.example
├── docker-compose.yml
├── Makefile
├── docs/
│   ├── learning-roadmap.md
│   ├── schema-reference.md
│   ├── normalization-and-design.md
│   ├── performance.md
│   ├── transactions-and-concurrency.md
│   ├── security-and-operations.md
│   └── project-requirements.md
├── sql/
│   ├── 00_create_database.sql
│   ├── 01_schema.sql
│   ├── 02_indexes.sql
│   ├── 03_views.sql
│   ├── 04_functions_and_triggers.sql
│   ├── 05_seed_data.sql
│   ├── 06_analytics_examples.sql
│   └── 07_roles_and_permissions.example.sql
├── lessons/
│   ├── 01_sql_fundamentals.sql
│   ├── 02_joins_and_aggregation.sql
│   ├── 03_subqueries_ctes_windows.sql
│   ├── 04_dml_and_transactions.sql
│   └── 05_advanced_sql.sql
├── exercises/
│   ├── README.md
│   ├── beginner.sql
│   ├── intermediate.sql
│   ├── advanced.sql
│   └── solutions/
│       ├── beginner_solutions.sql
│       ├── intermediate_solutions.sql
│       └── advanced_solutions.sql
├── tests/
│   ├── README.md
│   └── integrity_checks.sql
└── .github/
    └── workflows/
        └── sql-checks.yml
```

## Quick start

### Option A — Docker Compose (recommended)

Requirements: Docker Desktop or Docker Engine with Compose.

1. Copy `.env.example` to `.env` and change the example password for local use.
2. Start PostgreSQL:

   ```bash
   docker compose up -d
   ```

3. Connect using `psql` (if installed locally):

   ```bash
   psql "postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery"
   ```

4. Apply scripts in order:

   ```bash
   psql "postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery" -v ON_ERROR_STOP=1 -f sql/01_schema.sql
   psql "postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery" -v ON_ERROR_STOP=1 -f sql/02_indexes.sql
   psql "postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery" -v ON_ERROR_STOP=1 -f sql/03_views.sql
   psql "postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery" -v ON_ERROR_STOP=1 -f sql/04_functions_and_triggers.sql
   psql "postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery" -v ON_ERROR_STOP=1 -f sql/05_seed_data.sql
   ```

5. Run integrity checks:

   ```bash
   psql "postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery" -v ON_ERROR_STOP=1 -f tests/integrity_checks.sql
   ```

The container initializes an empty database. The schema, indexes, views, functions, and seed data are applied explicitly so the execution order stays visible for learning.

### Option B — Existing PostgreSQL instance

Create a database named `sql_mastery`, then apply the scripts in the order listed above. PostgreSQL 15+ is recommended.

## Database schema overview

The schema contains these related tables:

- `customers`, `customer_addresses`
- `categories`, `products`, `product_categories`
- `warehouses`, `inventory`
- `carts`, `cart_items`
- `orders`, `order_items`
- `payments`, `shipments`
- `reviews`
- `audit_log`

Primary keys, foreign keys, unique constraints, check constraints, timestamps, and indexes are included where appropriate. Money is represented using `NUMERIC`, not floating-point types. Order items snapshot product names and prices so historical orders remain interpretable after catalog changes.

See [`docs/schema-reference.md`](docs/schema-reference.md) for the table-by-table data dictionary and relationships.

## Learning path

1. Read `docs/learning-roadmap.md`.
2. Run `lessons/01_sql_fundamentals.sql` and continue through lesson 05.
3. Inspect the schema and explain each primary/foreign key relationship.
4. Complete exercises without looking at the solutions.
5. Run the integrity checks and explore `EXPLAIN (ANALYZE, BUFFERS)` on representative queries.
6. Complete the capstone requirements in `docs/project-requirements.md`.

## Industry-minded practices included

- Explicit data types, constraints, and referential integrity.
- Repeatable SQL scripts and migration ordering.
- Indexes aligned to common access patterns, not indiscriminately on every column.
- Transactions and concurrency guidance.
- Least-privilege role examples (review and customize before use).
- Parameterized-query and secret-management guidance.
- Integrity checks, CI syntax checks, and operational documentation.

**Important:** This is a learning/reference project, not a certified production deployment. Review security, privacy, retention, availability, recovery objectives, query plans, and migration strategy before using it for real customer data. The sample credentials are local-only placeholders.

## Tests and validation status

- `tests/integrity_checks.sql` contains database-level assertions for a live PostgreSQL database.
- GitHub Actions runs lightweight repository checks and SQL linting where configured.
- The ZIP archive was integrity-checked at packaging time.
- SQL was authored for PostgreSQL 15+, but this packaging environment did not run a PostgreSQL server. Therefore database scripts, triggers, seed inserts, and database assertions have **not** been runtime-tested here. Run the quick-start steps in a PostgreSQL environment before relying on them.

## License

MIT — see [`LICENSE`](LICENSE).
