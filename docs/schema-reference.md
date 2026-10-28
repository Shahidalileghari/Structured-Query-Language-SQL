# Schema Reference / Data Dictionary

All tables live in the PostgreSQL schema `commerce`. IDs are generated identity columns unless otherwise stated. Timestamps use `TIMESTAMPTZ` and default to the database clock.

| Table | Purpose | Important relationships / constraints |
|---|---|---|
| `customers` | Customer account profile | Unique email; status check |
| `customer_addresses` | Customer billing/shipping addresses | FK to customers; address type check |
| `categories` | Hierarchical catalog categories | Optional self-FK to parent category |
| `products` | Product catalog and current price | Unique SKU; nonnegative price; status check |
| `product_categories` | Many-to-many product/category mapping | Composite PK; FKs to products and categories |
| `warehouses` | Physical stock locations | Unique warehouse code |
| `inventory` | Per-product stock per warehouse | Composite PK; nonnegative on-hand/reserved; reserved <= on-hand |
| `carts` | Customer shopping carts | FK to customer; status check |
| `cart_items` | Products and quantities in a cart | Composite PK (cart, product); positive quantity |
| `orders` | Order header and financial totals | Unique order number; FK to customer; total arithmetic check |
| `order_items` | Purchased item snapshots | FK to order; snapshot SKU/name/price; generated line total |
| `payments` | Payment attempts and provider reference | FK to order; unique provider reference; positive amount |
| `shipments` | Shipment tracking lifecycle | FK to order; unique tracking number; chronology check |
| `reviews` | Customer product reviews | FK to customer/product; rating 1–5; one review per customer/product |
| `audit_log` | Selected row-change audit history | JSONB before/after images; action check |

## Relationship summary

- One customer has many addresses, carts, and orders.
- Products and categories are many-to-many through `product_categories`.
- Products and warehouses are many-to-many through `inventory`, which stores quantities.
- A cart has many cart items; a product can appear in many carts.
- An order has many order items, payment attempts, and shipments.
- A customer can review many products; a product can receive many reviews.
- Categories can have a parent category, enabling a tree.

## Design notes

- `order_items` stores snapshots because catalog names and prices can change after purchase.
- `NUMERIC(12,2)` avoids floating-point rounding behavior for currency-like values. For real multinational commerce, use an explicit currency/tax policy and avoid summing unlike currencies.
- `orders.total_amount` has a check constraint enforcing subtotal + tax + shipping − discount. Application workflows should also ensure `subtotal` reconciles with line items.
- Customer address foreign keys do not themselves prove the address belongs to the same customer as the order. Enforce this in application logic or add a stronger relational design if required.
- Audit logging is enabled for product changes only as a demonstration. Audit data can contain sensitive information; minimize, restrict, and retain it according to policy.
