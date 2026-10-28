# Transactions and Concurrency

## ACID
- **Atomicity:** a transaction succeeds or rolls back as a unit.
- **Consistency:** constraints and application rules remain valid.
- **Isolation:** concurrent transactions are protected according to the isolation level.
- **Durability:** committed work survives according to database durability configuration.

## Order placement example
A robust order workflow typically validates prices and address ownership, reserves inventory atomically, writes the order and order items, records payment state, and commits. If any required step fails, roll back. External payment-provider calls should not be held open inside a long database transaction; use idempotency keys and a state machine/outbox-style integration.

## Concurrency patterns
- Use conditional updates for inventory, checking the affected-row count.
- Use `SELECT ... FOR UPDATE` when a row must be locked while a transaction decides.
- Keep transactions short and acquire locks in a consistent order.
- Handle serialization failures and deadlocks with bounded retries.
- Design idempotent endpoints to avoid duplicate orders on network retries.

The lesson file intentionally rolls back its demonstration changes.
