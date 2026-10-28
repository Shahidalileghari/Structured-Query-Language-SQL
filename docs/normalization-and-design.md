# Normalization and Design

## Practical checklist

1. **Identify entities:** customer, product, order, warehouse, payment, shipment.
2. **Choose stable keys:** generated primary keys plus business keys such as SKU and order number.
3. **Normalize repeated facts:** addresses are separate rows; product/category mapping uses a junction table; stock is separated by warehouse.
4. **Avoid multi-valued columns:** don't store multiple product IDs in a comma-separated field.
5. **Preserve history intentionally:** order item name/SKU/price snapshots retain the purchase-time facts.
6. **Use constraints:** make invalid states difficult to represent with `NOT NULL`, `UNIQUE`, `CHECK`, and foreign keys.
7. **Document denormalization:** summary tables or materialized views should have a measured purpose and refresh strategy.

## Normal forms, in brief

- **1NF:** each field holds one value; each row is identifiable.
- **2NF:** non-key attributes depend on the whole candidate key, not just part of a composite key.
- **3NF:** non-key attributes depend on the key rather than other non-key attributes.
- **BCNF:** every determinant is a candidate key.

Normalization is not a ritual: model the business rules first, then make deliberate tradeoffs for measured workload needs.
