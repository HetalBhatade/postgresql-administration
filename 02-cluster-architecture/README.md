
# PostgreSQL Database Cluster and Architecture

## Objective

This section documents the internal structure of a PostgreSQL database cluster and explores the layout of the PostgreSQL data directory.

The purpose of this module is to understand how PostgreSQL stores databases, system catalogs, transaction logs, configuration files, and cluster metadata.

## Topics Covered

- PostgreSQL Database Cluster
- Basic PostgreSQL Commands
- Data Directory
- Base Directory
- Database OID Mapping
- Global Directory
- pg_tblspc
- pg_wal
- Log Directory
- postmaster.pid
- postmaster.opts
- Basic PostgreSQL Commands

## Files

- notes.md
- commands.md
- screenshots/

## Lab Environment

| Component | Details |
|-----------|----------|
| Host OS | Windows 11 |
| Virtualization | VMware Workstation Pro 17 |
| Guest OS | Red Hat Enterprise Linux 9.8 |
| PostgreSQL Version | PostgreSQL 16 |
| Primary Server | Installed |
| Standby Server 1 | Installed |
