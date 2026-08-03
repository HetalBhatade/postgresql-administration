
# PostgreSQL Logical Backup and Restore

## Introduction

Backing up a database is one of the most important responsibilities of a PostgreSQL Database Administrator.

Backups protect databases against hardware failures, accidental data deletion, software issues, and disaster recovery situations.

A successful backup strategy ensures that data can be restored with minimal downtime and data loss.

---

# What is a Logical Backup?

A logical backup stores the logical definition of database objects rather than copying the physical database files.

Logical backups contain SQL statements or PostgreSQL archive files that can recreate database objects and their data.

They are commonly used for:

- Database migration
- Development and testing
- Selective object restoration
- Version upgrades
- Data export

---

# PostgreSQL Backup Utilities

PostgreSQL provides several built-in utilities for logical backup and restore.

| Utility | Purpose |
|----------|----------|
| pg_dump | Backup a single database |
| pg_restore | Restore backups created using Custom, Tar or Directory formats |
| psql | Restore Plain SQL backups |
| pg_dumpall | Backup all databases and global objects |

---

# pg_dump

pg_dump creates a logical backup of a single PostgreSQL database.

It can backup:

- Entire database
- Individual schema
- Individual table
- Data only
- Schema only

Common backup formats include:

- Plain SQL
- Custom
- Directory
- Tar

---

# Backup Formats

## Plain Format (-Fp)

- SQL script
- Human readable
- Restored using psql

---

## Custom Format (-Fc)

- Compressed archive
- Most commonly used in production
- Supports selective restore
- Restored using pg_restore

---

## Directory Format (-Fd)

- Stores backup as multiple files
- Supports parallel backup and restore

---

## Tar Format (-Ft)

- Creates a TAR archive
- Useful for file-based transfer

---

# pg_restore

pg_restore restores backups created using:

- Custom format
- Directory format
- Tar format

It allows selective restoration of:

- Schemas
- Tables
- Functions
- Indexes
- Data

---

# psql Restore

Plain SQL backups are restored using the psql utility.

The SQL script is executed sequentially to recreate database objects and data.

---

# pg_dumpall

pg_dumpall creates a logical backup of the entire PostgreSQL cluster.

It includes:

- All databases
- Roles
- Tablespaces
- Global objects

It is commonly used for complete cluster backup.

---

# Backup Compression

Large logical backups can be compressed using utilities such as gzip.

Compressed files reduce storage requirements and improve transfer speed.

Large backup files can also be split into multiple parts using split and later combined using cat before restoration.

---

# Backup Verification

A backup should always be verified after completion.

Typical verification includes:

- Checking backup file creation
- Restoring the backup
- Verifying database objects
- Verifying row counts
- Confirming successful application startup

---

# Best Practices

- Schedule regular backups.
- Test restore procedures periodically.
- Store backups on separate storage.
- Compress large backup files.
- Maintain multiple backup copies.
- Verify backup integrity after creation.
- Protect backup files using appropriate permissions.

---

# Summary

Logical backup utilities provide flexible methods to backup and restore PostgreSQL databases.

Choosing the appropriate utility depends on the recovery requirements, backup size, and restore objectives.
