# PostgreSQL Cluster Architecture Notes

This document explains the PostgreSQL database cluster, data directory structure, and the purpose of important directories and files created during database initialization.


## PostgreSQL Cluster Overview

The following diagram illustrates the overall PostgreSQL cluster (PGDATA) directory layout.

![PostgreSQL Cluster Architecture](cluster_architectures-data _directory.png)

---

# PostgreSQL Database Cluster

## What is a Database Cluster?

In PostgreSQL, a database cluster is a collection of databases managed by a single PostgreSQL server instance. So basically single PostgreSQL server instance together with all databases managed by that instance and the shared data directory containing configuration files, WAL, system catalogs, and metadata.

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

Key Points

- WAL files record every database modification before the changes are written to the data files.
- The default WAL segment size is 16 MB.
- PostgreSQL automatically switches to a new WAL segment when the current segment becomes full.
- When WAL archiving is enabled, completed WAL segments can be archived using the configured `archive_command`.
- WAL files are essential for crash recovery, Point-in-Time Recovery (PITR), and streaming replication.
- Checkpoints are triggered based on `checkpoint_timeout` or `max_wal_size`, not simply because a WAL segment reaches 16 MB.
---

# Log Directory

If logging_collector is enabled, PostgreSQL stores log files in the configured log directory.

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

## Other Important Files and Directories

The previous sections covered the most important PostgreSQL directories in detail, including **base/**, **global/**, **pg_tblspc/**, **log/** and **pg_wal/**.

The PostgreSQL data directory (PGDATA) also contains several other files and directories that support transaction management, replication, authentication, logging, and server configuration.

The following table provides a high-level overview of these important files and directories.

## Important Files and Directories

The PostgreSQL data directory (PGDATA) contains various files and subdirectories that store database data, transaction logs, configuration files, and server metadata.

| Directory / File | Purpose | Important Contents |
|------------------|---------|--------------------|
| **base/** | Stores database files | One subdirectory per database (OID-based) containing tables, indexes, and other database objects. |
| **global/** | Stores cluster-wide system catalogs | Global PostgreSQL metadata shared across all databases, including roles and tablespace information. |
| **pg_wal/** | Stores Write-Ahead Log (WAL) files | WAL segments used for crash recovery, streaming replication, and Point-in-Time Recovery (PITR). |
| **pg_xact/** | Stores transaction status information | Tracks committed and aborted transactions. |
| **pg_multixact/** | Stores multi-transaction information | Supports shared row locking by multiple transactions. |
| **pg_commit_ts/** | Stores commit timestamps (optional) | Stores transaction commit timestamps when `track_commit_timestamp` is enabled. |
| **pg_subtrans/** | Stores subtransaction information | Maintains parent-child transaction relationships. |
| **pg_twophase/** | Stores two-phase commit files | Contains prepared transactions used for Two-Phase Commit (2PC). |
| **pg_tblspc/** | Stores tablespace symbolic links | Links user-defined tablespaces located outside the PGDATA directory. |
| **pg_stat/** | Stores persistent statistics | Database statistics used by the query planner and monitoring. |
| **pg_notify/** | Stores LISTEN/NOTIFY information | Maintains notification queue data for asynchronous messaging. |
| **pg_serial/** | Stores serializable transaction information | Tracks predicate locks used by SERIALIZABLE transaction isolation. |
| **pg_snapshots/** | Stores exported snapshots | Used by exported transaction snapshots. |
| **pg_replslot/** | Stores replication slot information | Contains metadata for physical and logical replication slots. |
| **pg_logical/** | Stores logical replication files | Stores logical decoding and logical replication metadata. |
| **pg_dynshmem/** | Stores dynamic shared memory files | Used for parallel query execution and dynamic shared memory management. |
| **pg_hba.conf** | Client authentication configuration | Defines who can connect, from where, and which authentication method is used. |
| **pg_ident.conf** | User name mapping configuration | Maps operating system users to PostgreSQL roles for peer and ident authentication. |
| **postgresql.conf** | Main server configuration | Controls memory, networking, WAL, checkpoints, logging, replication, autovacuum, and performance settings. |
| **postgresql.auto.conf** | Automatic configuration file | Stores configuration changes made using the `ALTER SYSTEM` command. |
| **PG_VERSION** | PostgreSQL version file | Indicates the major PostgreSQL version of the database cluster. |
| **postmaster.pid** | Running server information | Stores the server PID, port, socket directory, data directory, and startup information while the server is running. |
| **postmaster.opts** | Server startup options | Stores the command-line options used to start the PostgreSQL server. |
| **current_logfiles** | Active log file information | Lists the current log file when the logging collector is enabled. |

# Summary

Understanding the PostgreSQL data directory is essential for database administration because it provides insight into:

- Database storage
- Cluster organization
- WAL management
- Tablespaces
- Shared system catalogs
- Server startup files
- Authentication configuration
