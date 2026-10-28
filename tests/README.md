# Database checks

Run after schema, indexes, views, functions, and seed scripts:

```bash
psql "$DB_URL" -v ON_ERROR_STOP=1 -f tests/integrity_checks.sql
```

The script uses PostgreSQL `DO` blocks and raises an exception if an assertion fails. It checks core row presence, foreign-key consistency, nonnegative stock, order arithmetic, and view behavior. These checks are intended for a local learning database with the included seed dataset.
