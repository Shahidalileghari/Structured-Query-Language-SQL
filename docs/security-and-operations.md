# Security and Operations

- Use separate database roles for migrations, application runtime, analytics, and read-only access.
- Grant only the privileges each role requires; avoid superuser application credentials.
- Use parameterized queries; never concatenate untrusted input into SQL.
- Keep credentials out of Git and logs. Use environment variables locally and managed secret stores in deployments.
- Encrypt network connections and storage where appropriate; restrict network access to the database.
- Minimize personal data, restrict audit access, define retention, and avoid logging secrets/payment credentials.
- Establish backup schedules and retention, then test restore procedures. A successful backup is not proven until a restore works.
- Define recovery point objective (RPO) and recovery time objective (RTO).
- Monitor connections, slow queries, lock waits, replication lag where applicable, disk capacity, and failed jobs.
- Use reviewed, versioned migrations with a rollback or forward-fix plan.
- Keep PostgreSQL and extensions patched and document incident response contacts and procedures.

The included Docker configuration is for local learning, not a hardened production deployment.
