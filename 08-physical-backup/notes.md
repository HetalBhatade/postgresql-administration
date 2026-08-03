# PostgreSQL Physical Backup

## Introduction

Physical backup is the process of creating a binary copy of the PostgreSQL database cluster.

Unlike logical backups, physical backups copy the actual database files stored in the PostgreSQL data directory (PGDATA). They preserve the exact state of the database cluster and are commonly used for disaster recovery, standby server creation, and Point-in-Time Recovery (PITR).

---

# What is a Physical Backup?

A physical backup copies the PostgreSQL cluster files exactly as they exist on disk.

A physical backup includes:

- Database files (base/)
- Global system catalogs (global/)
- WAL files (pg_wal/)
- Configuration files
- Transaction status information
- Tablespaces
- Other cluster metadata

Because physical backups copy the database at the file level, the PostgreSQL major version and operating system must generally be compatible when restoring the backup.

---

# Types of Physical Backup

PostgreSQL supports multiple approaches for physical backups.

## 1. Offline (Cold) Backup

The PostgreSQL server is stopped before copying the data directory.

Characteristics:

- Database is unavailable during backup.
- Simple to perform.
- Produces a consistent backup without requiring WAL archiving.
- Suitable for development and maintenance windows.

---

## 2. Online Physical Backup

The PostgreSQL server remains running while the backup is taken.

Characteristics:

- No downtime.
- Suitable for production systems.
- Requires WAL files to ensure backup consistency.

Two common approaches are:

- Low-Level Backup API
- pg_basebackup

---

# WAL Archiving

Write-Ahead Logging (WAL) is a fundamental component of PostgreSQL recovery.

When WAL archiving is enabled:

- Completed WAL segment files are copied to an archive location.
- Archived WAL files allow recovery beyond the time when the base backup was taken.
- WAL archiving is required for Point-in-Time Recovery (PITR).

Common configuration parameters include:

- wal_level
- archive_mode
- archive_command
- max_wal_senders

---

# Low-Level Backup API

PostgreSQL provides SQL functions to coordinate online physical backups.

The backup process typically includes:

1. Start backup using pg_backup_start().
2. Copy the database files.
3. Stop backup using pg_backup_stop().

These functions ensure the backup remains consistent while PostgreSQL continues processing client transactions.

---

# pg_basebackup

pg_basebackup is the standard PostgreSQL utility for creating physical backups.

It automatically:

- Copies the PostgreSQL data directory.
- Streams the required WAL files.
- Generates backup metadata.
- Produces a consistent physical backup.

pg_basebackup is commonly used for:

- Standby server creation
- Disaster recovery
- Base backups for PITR

---

# Backup Verification

After completing a physical backup, verify that:

- Backup files exist.
- WAL files are archived successfully.
- backup_label (if applicable) is created.
- backup_manifest (supported versions) is present.
- PostgreSQL starts successfully after restoration.
- Database objects and data are accessible.

---

# Best Practices

- Perform regular physical backups.
- Enable WAL archiving for production environments.
- Verify every backup by testing restoration.
- Store backup files on separate storage.
- Protect backup files using appropriate permissions.
- Monitor archive status using pg_stat_archiver.
- Keep multiple generations of backups.

---

# Summary

Physical backups provide a complete copy of the PostgreSQL database cluster and are essential for disaster recovery.

Offline backups are simple but require downtime, while online techniques such as the Low-Level Backup API and pg_basebackup allow consistent backups with minimal interruption. Combined with WAL archiving, physical backups form the foundation of reliable PostgreSQL recovery strategies.
