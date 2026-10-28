SET search_path TO commerce, public;

-- Keep updated_at current for selected mutable entities.
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    NEW.updated_at := now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_customers_updated_at
BEFORE UPDATE ON customers FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_products_updated_at
BEFORE UPDATE ON products FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_orders_updated_at
BEFORE UPDATE ON orders FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_carts_updated_at
BEFORE UPDATE ON carts FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Generic row audit trigger. Attach only to tables whose data policy permits
-- storing before/after row images; avoid logging secrets or unnecessary PII.
CREATE OR REPLACE FUNCTION write_audit_log()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_key TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        v_key := to_jsonb(NEW) ->> TG_ARGV[0];
        INSERT INTO audit_log(table_name, record_key, action, new_row)
        VALUES (TG_TABLE_NAME, v_key, TG_OP, to_jsonb(NEW));
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        v_key := to_jsonb(NEW) ->> TG_ARGV[0];
        INSERT INTO audit_log(table_name, record_key, action, old_row, new_row)
        VALUES (TG_TABLE_NAME, v_key, TG_OP, to_jsonb(OLD), to_jsonb(NEW));
        RETURN NEW;
    ELSE
        v_key := to_jsonb(OLD) ->> TG_ARGV[0];
        INSERT INTO audit_log(table_name, record_key, action, old_row)
        VALUES (TG_TABLE_NAME, v_key, TG_OP, to_jsonb(OLD));
        RETURN OLD;
    END IF;
END;
$$;

CREATE TRIGGER trg_products_audit
AFTER INSERT OR UPDATE OR DELETE ON products
FOR EACH ROW EXECUTE FUNCTION write_audit_log('product_id');

-- Example reporting function.
CREATE OR REPLACE FUNCTION customer_lifetime_value(p_customer_id BIGINT)
RETURNS NUMERIC(12,2)
LANGUAGE SQL STABLE AS $$
    SELECT COALESCE(SUM(total_amount), 0)::NUMERIC(12,2)
    FROM orders
    WHERE customer_id = p_customer_id
      AND status IN ('confirmed', 'processing', 'shipped', 'delivered')
$$;
