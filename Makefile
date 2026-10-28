DB_URL ?= postgresql://sql_lab:change_me_local_only@localhost:5432/sql_mastery
PSQL ?= psql

.PHONY: schema indexes views functions seed test lessons

schema:
	$(PSQL) "$(DB_URL)" -v ON_ERROR_STOP=1 -f sql/01_schema.sql
indexes:
	$(PSQL) "$(DB_URL)" -v ON_ERROR_STOP=1 -f sql/02_indexes.sql
views:
	$(PSQL) "$(DB_URL)" -v ON_ERROR_STOP=1 -f sql/03_views.sql
functions:
	$(PSQL) "$(DB_URL)" -v ON_ERROR_STOP=1 -f sql/04_functions_and_triggers.sql
seed:
	$(PSQL) "$(DB_URL)" -v ON_ERROR_STOP=1 -f sql/05_seed_data.sql
test:
	$(PSQL) "$(DB_URL)" -v ON_ERROR_STOP=1 -f tests/integrity_checks.sql
