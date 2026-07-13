# PostgreSQL Configuration Files

## Overview

PostgreSQL uses several configuration files to control how the database server operates.

These files define server behavior, client authentication, logging, memory usage, networking, replication, write-ahead logging (WAL), and many other server settings.

When a new PostgreSQL database cluster is initialized using `initdb`, PostgreSQL automatically creates the default configuration files inside the data directory.

The four primary configuration files are:

| Configuration File | Purpose |
|--------------------|---------|
| postgresql.conf | Main PostgreSQL server configuration file |
| postgresql.auto.conf | Stores configuration changes made using ALTER SYSTEM |
| pg_hba.conf | Controls client authentication and connection rules |
| pg_ident.conf | Maps operating system users to PostgreSQL users |

---

## Configuration Loading Order

When PostgreSQL starts, configuration settings are processed in the following order:

1. Built-in default settings
2. postgresql.conf
3. postgresql.auto.conf
4. PostgreSQL server startup
5. Client connection
6. pg_hba.conf
7. pg_ident.conf (if required)
8. Database session

Because `postgresql.auto.conf` is processed after `postgresql.conf`, any parameter stored in `postgresql.auto.conf` overrides the same parameter defined in `postgresql.conf`.

---

## postgresql.conf

### Purpose

The main server configuration file.

It controls:

- Memory
- Connections
- Networking
- Logging
- WAL
- Replication
- Autovacuum
- Query Planner
- Resource Usage

Common examples include:

- port
- listen_addresses
- shared_buffers
- max_connections
- wal_level
- logging_collector

Some parameters require only a configuration reload, while others require a complete PostgreSQL restart.

---

## postgresql.auto.conf

### Purpose

This file stores configuration changes made using:

```sql
ALTER SYSTEM
```

Instead of editing `postgresql.conf`, PostgreSQL automatically writes configuration changes to this file.

If a parameter exists in both configuration files, the value stored in `postgresql.auto.conf` takes precedence.

This file should not be edited manually.

---

## pg_hba.conf

### Purpose

Host-Based Authentication configuration file.

It determines:

- Who can connect
- Which database they can access
- Which PostgreSQL user they can use
- Which client IP addresses are allowed
- Which authentication method is required

PostgreSQL reads this file from top to bottom and applies only the first matching rule.

---

## pg_ident.conf

### Purpose

Optional username mapping file.

It maps operating system users to PostgreSQL users when their names differ.

It is primarily used together with Peer or Ident authentication.

---

## Summary

Understanding these configuration files is essential for PostgreSQL administration because they control server behavior, authentication, security, and runtime configuration.
