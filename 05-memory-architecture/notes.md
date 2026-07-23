# PostgreSQL Memory Architecture

## Overview

After understanding PostgreSQL Client-Server Architecture and Database Cluster Architecture, the next step is understanding how PostgreSQL uses memory.

Reading data directly from disk for every query is expensive and slows down database performance. To reduce disk I/O and improve query execution, PostgreSQL uses memory to cache frequently accessed data and provide working space for backend processes.

PostgreSQL primarily uses two types of memory:

- **Shared Memory** – Shared by all backend processes.
- **Local Memory** – Private to each backend process.

---

## PostgreSQL Memory Architecture

The following diagram illustrates the major memory components used by PostgreSQL.

![PostgreSQL Memory Architecture](screenshots/Memory-achitecture.png)

---

# Shared Memory

Shared Memory is allocated during PostgreSQL server startup and is shared by all backend processes.

Since all sessions can access this memory, it is primarily used to cache frequently accessed data and coordinate database activities.

The two most important shared memory components are:

- Shared Buffers
- WAL Buffers

---

## Shared Buffers

Shared Buffers are PostgreSQL's primary cache.

When a query requests data, PostgreSQL first checks whether the required table or index page is already available in Shared Buffers.

If the page exists in memory:

- Cache Hit (`blks_hit`)
- No disk access is required.

If the page is not available:

- Cache Miss (`blks_read`)
- PostgreSQL reads the page from disk and stores it in Shared Buffers for future use.

Because of this caching mechanism, frequently accessed data can be served directly from memory, significantly reducing disk I/O and improving query performance.

---

## WAL Buffers

WAL Buffers temporarily store Write-Ahead Log (WAL) records before they are written to WAL files located in the **pg_wal** directory.

Writing WAL records through memory instead of directly to disk improves transaction performance by reducing the number of physical disk writes.

By default, PostgreSQL automatically determines an appropriate size for `wal_buffers`, although it can be configured manually if required.

---

# Buffer Cache Hit Ratio

The Buffer Cache Hit Ratio measures how efficiently PostgreSQL serves data from Shared Buffers instead of reading it from disk.

Formula:

```
Buffer Cache Hit Ratio =
blks_hit / (blks_hit + blks_read)
```

General guidelines:

- **99% or higher** – Excellent for most OLTP workloads.
- **95%–99%** – Generally healthy for many production systems.
- **Below 95%** – May indicate additional investigation is required depending on the workload.

A higher cache hit ratio usually means less disk I/O and better query performance.

---

# Local Memory

Local Memory is allocated separately for each backend process.

Unlike Shared Memory, Local Memory is private to an individual session and cannot be shared with other backend processes.

Each active session receives its own Local Memory area for query execution.

---

## work_mem

`work_mem` defines the amount of memory available for query operations such as:

- ORDER BY
- GROUP BY
- Hash Join
- Merge Join
- Hash Aggregate

If a query requires more memory than configured, PostgreSQL writes temporary data to disk, which can reduce performance.

---

## temp_buffers

`temp_buffers` specifies the amount of memory allocated for temporary tables created within a session.

These buffers exist only for the lifetime of the current session.

---

## maintenance_work_mem

`maintenance_work_mem` defines the amount of memory available for maintenance operations such as:

- VACUUM
- ANALYZE
- CREATE INDEX
- REINDEX
- ALTER TABLE ADD FOREIGN KEY

Larger values may improve the performance of these operations, provided sufficient system memory is available.

Autovacuum workers use `autovacuum_work_mem` if configured; otherwise, they use `maintenance_work_mem`.

---

# Memory Parameters Summary

| Parameter | Memory Type | Purpose |
|-----------|-------------|---------|
| `shared_buffers` | Shared Memory | Caches frequently accessed table and index pages. |
| `wal_buffers` | Shared Memory | Temporarily stores WAL records before writing them to the `pg_wal` directory. |
| `work_mem` | Local Memory | Used for sorting, hash joins, `ORDER BY`, and `GROUP BY` operations. |
| `temp_buffers` | Local Memory | Used for temporary tables created within a session. |
| `maintenance_work_mem` | Local Memory | Used for maintenance operations such as `VACUUM`, `CREATE INDEX`, and `REINDEX`. |

---

# Key Takeaways

- PostgreSQL uses memory to reduce disk I/O and improve query performance.
- Shared Memory is accessible by all backend processes.
- Shared Buffers cache table and index pages.
- WAL Buffers temporarily store WAL records before they are written to disk.
- Local Memory is private to each backend process.
- `work_mem`, `temp_buffers`, and `maintenance_work_mem` support query execution and maintenance tasks.
- Monitoring memory configuration helps DBAs optimize database performance.

---

# References

- PostgreSQL Official Documentation – Runtime Resource Configuration
- PostgreSQL Official Documentation – Monitoring Database Activity
