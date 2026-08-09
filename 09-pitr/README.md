# PostgreSQL Point-in-Time Recovery (PITR)

## Objective

This module demonstrates PostgreSQL Point-in-Time Recovery (PITR) using a physical base backup and archived WAL files.

The lab demonstrates how PostgreSQL can restore a database cluster to a specific point in time by restoring a base backup and replaying the required WAL files.

The content is based on hands-on practice and the PostgreSQL official documentation.

## Topics Covered

- WAL archiving verification
- Physical base backup using pg_basebackup
- WAL generation and archiving
- Recovery target identification
- Simulating data loss
- Restoring the PostgreSQL data directory
- Configuring archive recovery
- recovery.signal
- restore_command
- Starting PostgreSQL in recovery
- Verifying Point-in-Time Recovery

## Recovery Flow

Base Backup
    ↓
Archived WAL
    ↓
Database Changes
    ↓
Data Loss
    ↓
Restore Base Backup
    ↓
Replay Archived WAL
    ↓
Recovery Target
    ↓
Recovered Database

## Repository Contents

- `README.md` - Overview of the PITR lab.
- `notes.md` - PITR concepts and recovery process.
- `commands.md` - Step-by-step commands and evidence.
- `scripts/` - Script containing the commands used during the lab.
- `screenshots/` - Evidence captured during the PITR exercise.

## Reference

PostgreSQL Official Documentation - Continuous Archiving and Point-in-Time Recovery (PITR)

https://www.postgresql.org/docs/current/continuous-archiving.html
