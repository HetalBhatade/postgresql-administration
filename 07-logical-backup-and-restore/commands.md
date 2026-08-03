# PostgreSQL Logical Backup and Restore Commands

This document contains the commands used to perform logical backup and restore operations using PostgreSQL utilities.

Each section includes the purpose, command syntax, and evidence captured during the lab.

---

# Part 1 - Prepare Backup Directory

## Step 1 - Create Backup Directory

### Purpose

Create a dedicated directory to store PostgreSQL backup files.

### Commands

```bash
mkdir backup

cd backup
```

### Evidence

![Create Backup Directory](screenshots/create_backup_directory.png)

---

## Step 2 - Take Full Database Backup (Custom Format)

### Purpose

Create a logical backup of the SchoolDB database using pg_dump in Custom format.

### Command Syntax

```bash
pg_dump -Fc -d schooldb -f schooldb.backup
```

### Evidence

![pg_dump Command](screenshots/01-pg_dump_command.png)

![pg_dump Command Output](screenshots/02-pg_dump_command.png)

![Backup Output](screenshots/pg_dump_command_output.png)

---

## Step 3 - Resolve Backup Path Issue

### Purpose

Resolve the issue encountered while saving the backup in the desired directory.

### Evidence

![Home Directory Issue](screenshots/home-directory-issue.png)

---

## Step 4 - Verify Backup File

### Purpose

Verify that the custom backup file was created successfully.

### Evidence

![Custom Backup](screenshots/schooldb-full-cutom-backup.png)

---

# Part 2 - Practice Restore Errors

## Step 5 - Simulate Restore Failure

### Purpose

Drop the Students table before restoring to understand common restore errors.

### Evidence

![Drop Students Table](screenshots/drop-table-students.png)

---

## Step 6 - Attempt Restore

### Purpose

Attempt to restore the backup and observe the reported errors.

### Evidence

![Restore Error](screenshots/restore_error_students_backup.png)

![Restore Error Analysis](screenshots/restore_error_analysis.png)

![Schema/Data Restore Failed](screenshots/schema-data-restor-failed.png)

---

# Part 3 - Restore Entire Database

## Step 7 - Drop Existing Database

### Purpose

Simulate database loss before performing a full restore.

### Command Syntax

```sql
DROP DATABASE schooldb;
```

### Evidence

![Drop Database](screenshots/drop-database-schooldb.png)

---

## Step 8 - Restore Database

### Purpose

Restore the complete database using pg_restore.

### Command Syntax

```bash
pg_restore -d schooldb schooldb.backup
```

### Evidence

![Database Restore Command](screenshots/pg_restore_db-command.png)

---

## Step 9 - Verify Database Restore

### Purpose

Verify that all database objects and data were restored successfully.

### Evidence

![Restore Success](screenshots/restoration-schooldb-sucess.png)

---

# Part 4 - Backup and Restore Individual Table

## Step 10 - Verify Student Table

### Purpose

Verify the existing data before taking the backup.

### Evidence

![Student Table Count](screenshots/student_table_count.png)

---

## Step 11 - Backup Students Table

### Purpose

Create a logical backup of only the Students table.

### Command Syntax

```bash
pg_dump -t class.students
```

### Evidence

![Students Table Backup](screenshots/student-table-data-backup.png)

---

## Step 12 - Remove Student Data

### Purpose

Truncate the Students table to simulate accidental data loss.

### Evidence

![Truncate Student Table](screenshots/truncatate-table-failed.png)

---

## Step 13 - Restore Students Table

### Purpose

Restore the Students table using psql.

### Command Syntax

```bash
psql -f students_backup.sql
```

### Evidence

![Students Table Restore](screenshots/psql_restore_table.png)

---

# Part 5 - Backup and Restore Another Table

## Step 14 - Backup Teachers Table

### Purpose

Create a logical backup of the Teachers table.

### Evidence

![Teacher Backup Command](screenshots/teachers_backup.png)

![Teacher Backup Success](screenshots/2-teacher-backup-success.png)

---

## Step 15 - Remove Teacher Data

### Purpose

Truncate the Teachers table before restoring.

### Evidence

![Teacher Truncate](screenshots/3-teacher-truncate-table.png)

---

## Step 16 - Restore Teachers Table

### Purpose

Restore the Teachers table from the backup.

### Evidence

![Teacher Restore](screenshots/4-restore-teacher-backup.png)

---

## Step 17 - Verify Teacher Restore

### Purpose

Verify that all teacher records were restored successfully.

### Evidence

![Teacher Count](screenshots/4-teacher-count-after-restore.png)

---

# Part 6 - Backup Compression

## Step 18 - Compress and Split Backup

### Purpose

Compress the backup using gzip and split the compressed file into multiple parts.

### Command Syntax

```bash
gzip

split
```

### Evidence

![Compression and Split](screenshots/cat-spilt-backup.png)

---

## Step 19 - Restore Split Backup

### Purpose

Merge the split files using cat and restore the backup.

### Command Syntax

```bash
cat
```

### Evidence

![Restore Using cat](screenshots/restore-table-cat.png)

---

## Step 20 - Production Practice

### Purpose

Demonstrate the use of gzip, split, and cat commands to reduce backup size and simplify the transfer of large backup files in production environments.

### Evidence

![Production Backup](screenshots/prod_gzip_split_backup.png)

---

# Part 7 - Backup Entire PostgreSQL Cluster

## Step 21 - Backup All Databases

### Purpose

Create a logical backup of the entire PostgreSQL cluster using pg_dumpall.

### Command Syntax

```bash
pg_dumpall
```

### Evidence

![pg_dumpall Backup](screenshots/pg_dumpall_backup.png)

---

## Step 22 - Backup Global Objects

### Purpose

Backup PostgreSQL global objects such as roles and tablespaces.

### Command Syntax

```bash
pg_dumpall --globals-only
```

### Evidence

![Global Backup](screenshots/pg_dumpall-global.png)

---

## Step 23 - Restore Global Objects

### Purpose

Restore PostgreSQL global objects from the backup.

### Command Syntax

```bash
psql -f globals.sql
```

### Evidence

![Global Restore](screenshots/pg_dump-allrestore.png)

---

# Summary

This lab demonstrated:

- Full database logical backup using **pg_dump**
- Full database restore using **pg_restore**
- Table-level backup and restore
- Database recovery verification
- Backup compression using **gzip**
- Splitting and merging backup files using **split** and **cat**
- Cluster-wide backup using **pg_dumpall**
- Backup and restore of PostgreSQL global objects
