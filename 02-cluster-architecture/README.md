
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




## Lab Environment

| Component | Details |
|-----------|----------|
| Host OS | Windows 11 |
| Virtualization | VMware Workstation Pro 17 |
| Guest OS | Red Hat Enterprise Linux 9.8 |
| PostgreSQL Version | PostgreSQL 16 |

| Server | Status |
|--------|--------|
| Primary Server | Installed and Configured |
| Standby Server 1 |Installed and Configured |


## Repository Contents

- [README.md](README.md) - Overview of the PostgreSQL Cluster Architecture module.
- [notes.md](notes.md) - PostgreSQL Cluster Architecture concepts and explanations.
- [commands.md](commands.md) - Practical SQL queries and Linux commands used to explore the PostgreSQL cluster..
- [screenshots](screenshots/) -  Screenshots captured while exploring the PostgreSQL cluster architecture.
