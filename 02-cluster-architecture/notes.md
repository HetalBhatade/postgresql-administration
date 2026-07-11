# PostgreSQL Cluster Architecture Notes

This document explains the PostgreSQL database cluster, data directory structure, and the purpose of important directories and files created during database initialization.

---

# PostgreSQL Database Cluster

## What is a Database Cluster?

In PostgreSQL, a database cluster is a collection of databases managed by a single PostgreSQL server instance.

A cluster is initialized using the `initdb` utility and stores all database files, configuration files, transaction logs, and metadata inside a single data directory.

Unlike some database systems, a PostgreSQL cluster can contain multiple databases that share the same PostgreSQL server process.

### Key Points

- One PostgreSQL server manages one database cluster.
- A cluster can contain multiple databases.
- Each database has its own physical storage inside the data directory.
- System catalogs and shared metadata are maintained at the cluster level.

---

# PostgreSQL Data Directory

The PostgreSQL data directory is the main storage location of the database cluster.

It contains:

- User databases
- System catalogs
- WAL files
- Configuration files
- Tablespace links
- Transaction information
- Server status files

Default location (RHEL)

```
/var/lib/pgsql/16/data
```

---

# Base Directory

The `base` directory stores the physical files for every database in the cluster.

Each database is stored in a separate directory named with its Object Identifier (OID).

Example

```
base/
├── 1
├── 4
└── 5
```

These directories correspond to databases stored in `pg_database`.

When a new database is created, PostgreSQL automatically creates a new directory inside `base`.

---

# Database OID Mapping

Every PostgreSQL database has a unique Object Identifier (OID).

The OID can be viewed using:

```sql
SELECT datname, oid
FROM pg_database;
```

Example

| Database | OID |
|----------|----:|
| template1 | 1 |
| template0 | 4 |
| postgres | 5 |

The OID matches the directory name under the `base` directory.

---

# Global Directory

The `global` directory stores cluster-wide system catalogs.

These catalogs are shared by all databases within the cluster.

Examples include:

- Shared system catalogs
- Role information
- Tablespace metadata
- Cluster-level metadata

Unlike the `base` directory, files inside `global` are accessible by the entire PostgreSQL cluster.

---

# pg_tblspc Directory

The `pg_tblspc` directory stores symbolic links for user-defined tablespaces.

When a tablespace is created outside the data directory, PostgreSQL creates a symbolic link inside `pg_tblspc` that points to the actual storage location.

---

# pg_wal Directory

The `pg_wal` directory stores PostgreSQL Write-Ahead Log (WAL) files.

WAL files record every database change before it is written to the data files.

Important points:

- Default WAL segment size is 16 MB.
- PostgreSQL automatically switches to a new WAL segment when the current segment becomes full.
- WAL files support crash recovery and replication.
- Checkpoints occur based on `checkpoint_timeout` or `max_wal_size`, not simply because a WAL segment changes.

---

# Log Directory

The `log` directory stores PostgreSQL server log files when logging is configured.

Log files help administrators:

- Troubleshoot problems
- Monitor server activity
- Investigate errors
- Review warnings and informational messages

---

# postmaster.pid

The `postmaster.pid` file is created whenever the PostgreSQL server starts.

It contains information such as:

- Server process ID (PID)
- Data directory location
- Port number
- Socket directory
- Server status

PostgreSQL removes this file when the server shuts down normally.

---

# postmaster.opts

The `postmaster.opts` file records the command-line options used to start the PostgreSQL server.

It is useful for troubleshooting and verifying server startup parameters.

---

# pg_hba.conf

The `pg_hba.conf` file is PostgreSQL's Host-Based Authentication configuration file.

It controls:

- Who can connect
- Which databases they can access
- Authentication methods
- Allowed client IP addresses

This file will be explained in detail in the PostgreSQL Configuration module.

---

# Summary

Understanding the PostgreSQL data directory is essential for database administration because it provides insight into:

- Database storage
- Cluster organization
- WAL management
- Tablespaces
- Shared system catalogs
- Server startup files
- Authentication configuration
