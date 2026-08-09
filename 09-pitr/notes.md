# PostgreSQL Point-in-Time Recovery (PITR)

## Introduction

Point-in-Time Recovery (PITR) allows PostgreSQL to restore a database cluster to a specific point in time.

PITR combines:

- A physical base backup
- Archived WAL files

The base backup provides the starting state of the PostgreSQL cluster. PostgreSQL then replays the archived WAL files to reconstruct database changes until the configured recovery target is reached.

---

# Why PITR Is Required

A physical base backup alone represents the database state at the time the backup was taken.

For example:

```text
10:00 AM
   │
   └── Base Backup
          │
          ├── 10:10 AM → INSERT
          ├── 10:20 AM → UPDATE
          └── 10:30 AM → DROP TABLE
```

If the database is restored only from the 10:00 AM base backup, the changes after 10:00 AM are not available.

WAL archiving allows PostgreSQL to replay those changes during recovery.

---

# PITR Architecture

```text
                 PostgreSQL Cluster
                        │
                        │
              ┌─────────┴─────────┐
              │                   │
              ▼                   ▼
        Base Backup            WAL Files
              │                   │
              │                   ▼
              │             WAL Archive
              │                   │
              └─────────┬─────────┘
                        │
                        ▼
                 Recovery Process
                        │
                        ▼
               Recovery Target
                        │
                        ▼
                Recovered Cluster
```

The base backup provides the starting point, while archived WAL provides the changes required to move the database forward during recovery.

---

# WAL Archiving

Write-Ahead Logging (WAL) records changes made to the PostgreSQL database.

WAL files are normally stored in:

```text
pg_wal/
```

For PITR, completed WAL segments are copied to a separate archive location.

Important configuration parameters include:

- `wal_level`
- `archive_mode`
- `archive_command`

Example:

```text
archive_command = 'cp %p /var/lib/pgsql/16/archive/%f'
```

The archive location should be separate from the active `pg_wal` directory so that archived WAL remains available if the database cluster is damaged.

---

# Checking WAL Archiving

PostgreSQL provides the `pg_stat_archiver` view to monitor WAL archiving.

Important columns include:

- `archived_count`
- `failed_count`
- `last_archived_wal`
- `last_archived_time`

A successful archive configuration should show WAL segments being archived and should not continuously accumulate archive failures.

---

# Physical Base Backup

A physical base backup is the starting point for PITR.

In this lab, the base backup is created using:

```text
pg_basebackup
```

The backup contains a physical copy of the PostgreSQL cluster.

Example:

```text
PostgreSQL Cluster
       │
       ▼
Physical Base Backup
       │
       ▼
PITR Recovery Starting Point
```

A new dedicated backup directory was used for the PITR lab:

```text
/var/lib/pgsql/16/pitr_basebackup
```

---

# Generating WAL for the PITR Test

After taking the base backup, database changes are generated.

In this lab:

1. A `pitr_test` table was created.
2. Initial records were inserted.
3. WAL was forced to switch using `pg_switch_wal()`.
4. The recovery target time was recorded.
5. Additional records were inserted.
6. The table was dropped to simulate an accidental user operation.

This creates a recovery scenario where the database needs to be restored to a point before the unwanted operation.

---

# Recovery Target

A recovery target specifies where PostgreSQL should stop WAL replay.

One supported recovery target is:

```text
recovery_target_time
```

Example:

```text
recovery_target_time = 'YYYY-MM-DD HH:MM:SS'
```

The timestamp should represent the desired point in time for recovery.

The recovery target used in the lab was recorded before the simulated user error.

---

# recovery.signal

PostgreSQL uses:

```text
recovery.signal
```

to indicate that the server should enter targeted recovery.

The file is created inside the PostgreSQL data directory before starting the server for recovery.

Example:

```text
$PGDATA/recovery.signal
```

---

# restore_command

During recovery, PostgreSQL needs a method to retrieve archived WAL files.

This is provided using:

```text
restore_command
```

Example:

```text
restore_command = 'cp /var/lib/pgsql/16/archive/%f %p'
```

Where:

- `%f` represents the requested WAL file name.
- `%p` represents the destination path where PostgreSQL expects the WAL file.

PostgreSQL uses this command during recovery to retrieve WAL files from the archive.

---

# recovery_target_action

The recovery target action controls what PostgreSQL should do after reaching the recovery target.

In this lab:

```text
recovery_target_action = 'promote'
```

After reaching the recovery target, PostgreSQL promotes the recovered server to a normal primary server.

---

# PITR Recovery Process

The recovery process used in this lab can be summarized as:

```text
1. Verify WAL Archiving
          │
          ▼
2. Take Physical Base Backup
          │
          ▼
3. Generate Database Changes
          │
          ▼
4. Record Recovery Target
          │
          ▼
5. Simulate User Error
          │
          ▼
6. Stop PostgreSQL
          │
          ▼
7. Restore Base Backup
          │
          ▼
8. Configure Recovery
          │
          ▼
9. Create recovery.signal
          │
          ▼
10. Start PostgreSQL
          │
          ▼
11. Replay Archived WAL
          │
          ▼
12. Stop at Recovery Target
          │
          ▼
13. Verify Recovered Database
```

---

# PITR Lab Scenario

The lab uses the `companydb` database.

The test scenario is:

```text
Base Backup
     │
     ▼
pitr_test table created
     │
     ▼
Initial records inserted
     │
     ▼
Recovery time recorded
     │
     ▼
Additional records inserted
     │
     ▼
pitr_test table dropped
     │
     ▼
Database restored from base backup
     │
     ▼
Archived WAL replayed
     │
     ▼
Recovery stops at selected time
     │
     ▼
pitr_test table recovered
```

The purpose is to demonstrate that PostgreSQL can recover the database to a point before the unwanted operation.

---

# Verifying PITR

After PostgreSQL starts following recovery, the recovery status can be checked using:

```sql
SELECT pg_is_in_recovery();
```

When recovery is still running:

```text
t
```

After recovery has completed and the server has been promoted:

```text
f
```

The recovered table can then be verified:

```sql
SELECT *
FROM pitr_test;
```

The expected result is that the table exists again and contains the data that existed at the selected recovery target.

---

# PITR vs Logical Backup

PITR and logical backup solve different recovery requirements.

| Feature | PITR | Logical Backup |
|---|---|---|
| Backup type | Physical | Logical |
| Main tools | pg_basebackup + WAL | pg_dump / pg_dumpall |
| Recovery level | Cluster | Database/object |
| Point-in-time recovery | Yes | No |
| Requires WAL archive | Yes | No |
| Typical use | Disaster recovery | Selective restoration |

PITR is intended for physical cluster recovery, while logical backups are useful when individual databases, tables, schemas, or objects need to be restored.

---

# Important Considerations

- A suitable physical base backup is required as the starting point.
- Required WAL files must be available in the archive.
- WAL archiving must be configured correctly.
- Archive failures should be monitored.
- Recovery targets must be selected carefully.
- Backup and WAL archives should be stored separately from the production data directory.
- PITR should be tested regularly rather than assuming that a successful backup automatically guarantees successful recovery.

---

# Summary

PostgreSQL PITR combines a physical base backup with archived WAL files.

The base backup provides the initial database state, while WAL replay reconstructs subsequent changes.

By specifying a recovery target, PostgreSQL can stop recovery at a selected point in time and recover the cluster to the desired state.

This makes PITR an important PostgreSQL disaster-recovery technique.
