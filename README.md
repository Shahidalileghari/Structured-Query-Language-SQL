# SQL & Database 

 
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

## Industry-minded practices included

- Explicit data types, constraints, and referential integrity.
- Repeatable SQL scripts and migration ordering.
- Indexes aligned to common access patterns, not indiscriminately on every column.
- Transactions and concurrency guidance.
- Least-privilege role examples (review and customize before use).
- Parameterized-query and secret-management guidance.
- Integrity checks, CI syntax checks, and operational documentation.


