====================================================================
PostgreSQL Point-in-Time Recovery (PITR) - Lab Commands
====================================================================

Database used:
companydb

PostgreSQL version:
16

Purpose:
These commands demonstrate PostgreSQL Point-in-Time Recovery using
a physical base backup and archived WAL files.

====================================================================
PHASE 1 - VERIFY WAL ARCHIVING
====================================================================

STEP 1 - Check WAL and Archiving Configuration
--------------------------------------------------------------------

Purpose:
Verify that WAL archiving is enabled and that the PostgreSQL server
is configured to generate WAL suitable for PITR.

Commands:

SHOW wal_level;

SHOW archive_mode;

SHOW archive_command;


Expected configuration:

wal_level       | replica
archive_mode    | on
archive_command | cp %p /var/lib/pgsql/16/archive/%f


Evidence:
screenshots/01-verify-archive.png


STEP 2 - Check WAL Archiver Status
--------------------------------------------------------------------

Purpose:
Verify whether WAL segments are being archived successfully.

Command:

SELECT archived_count,
       failed_count,
       last_archived_wal,
       last_archived_time
FROM pg_stat_archiver;


Check that:

archived_count > 0
failed_count = 0


Evidence:
screenshots/01-verify-archive.png


====================================================================
PHASE 2 - TAKE A FRESH BASE BACKUP
====================================================================

STEP 3 - Create PITR Base Backup Directory
--------------------------------------------------------------------

Purpose:
Create a dedicated directory to store the physical base backup.

Commands:

sudo mkdir -p /var/lib/pgsql/16/pitr_basebackup

sudo chown postgres:postgres /var/lib/pgsql/16/pitr_basebackup

sudo chmod 700 /var/lib/pgsql/16/pitr_basebackup


Evidence:
screenshots/02-create-backup-dir.png


STEP 4 - Take Physical Base Backup
--------------------------------------------------------------------

Purpose:
Create a physical base backup using pg_basebackup.

Command:

sudo -u postgres pg_basebackup \
-D /var/lib/pgsql/16/pitr_basebackup \
-Fp \
-X stream \
-P


Evidence:
screenshots/03-basebackup.png


STEP 5 - Verify Base Backup
--------------------------------------------------------------------

Purpose:
Verify that the base backup files were created successfully.

Command:

ls -lrth /var/lib/pgsql/16/pitr_basebackup


Evidence:
screenshots/03-basebackup.png


====================================================================
PHASE 3 - GENERATE TRANSACTIONS
====================================================================

STEP 6 - Connect to companydb
--------------------------------------------------------------------

Purpose:
Connect to the database where the PITR test will be performed.

Command:

sudo -u postgres psql companydb


STEP 7 - Create PITR Test Table
--------------------------------------------------------------------

Purpose:
Create a test table that will be used to demonstrate recovery.

Command:

CREATE TABLE pitr_test
(
    id INT,
    name TEXT
);


STEP 8 - Insert Initial Data
--------------------------------------------------------------------

Purpose:
Insert the initial records that should exist in the recovered
database.

Command:

INSERT INTO pitr_test
VALUES
(1,'John'),
(2,'Mary'),
(3,'David');


Verify:

SELECT * FROM pitr_test;


Evidence:
screenshots/04-pitr-table-switch-wal.png


====================================================================
PHASE 4 - FORCE WAL ARCHIVING
====================================================================

STEP 9 - Switch WAL
--------------------------------------------------------------------

Purpose:
Force PostgreSQL to switch to a new WAL segment so that the
completed WAL segment can be archived.

Command:

SELECT pg_switch_wal();


STEP 10 - Verify WAL Archiving
--------------------------------------------------------------------

Command:

SELECT archived_count,
       last_archived_wal,
       last_archived_time
FROM pg_stat_archiver;


Evidence:
screenshots/04-pitr-table-switch-wal.png
screenshots/05-pg_stat_wal_archiver_table.png


====================================================================
PHASE 5 - RECORD RECOVERY TARGET
====================================================================

STEP 11 - Record Recovery Time
--------------------------------------------------------------------

Purpose:
Record the timestamp that will be used as the PITR recovery target.

Command:

SELECT now();


IMPORTANT:

Save the timestamp returned by this command.

Example:

2026-07-19 18:42:30


Evidence:
screenshots/06-recovery-time.png


====================================================================
PHASE 6 - GENERATE MORE TRANSACTIONS
====================================================================

STEP 12 - Insert Additional Records
--------------------------------------------------------------------

Purpose:
Generate additional database changes after the selected recovery
point.

Command:

INSERT INTO pitr_test
VALUES
(4,'Scott'),
(5,'Allen'),
(6,'James');


Verify:

SELECT * FROM pitr_test;


Evidence:
screenshots/07-insert-record.png


STEP 13 - Force Another WAL Switch
--------------------------------------------------------------------

Command:

SELECT pg_switch_wal();


Verify:

SELECT archived_count,
       last_archived_wal,
       last_archived_time
FROM pg_stat_archiver;


====================================================================
PHASE 7 - SIMULATE USER ERROR
====================================================================

STEP 14 - Drop Test Table
--------------------------------------------------------------------

Purpose:
Simulate an accidental user operation that needs to be recovered.

Command:

DROP TABLE pitr_test;


Verify:

\dt


The pitr_test table should no longer be listed.


Evidence:
screenshots/08-drop-table.png


====================================================================
PHASE 8 - STOP POSTGRESQL
====================================================================

STEP 15 - Stop PostgreSQL
--------------------------------------------------------------------

Purpose:
Stop PostgreSQL before restoring the physical base backup.

Command:

sudo systemctl stop postgresql-16


Evidence:
screenshots/09-stop-server.png


====================================================================
PHASE 9 - PRESERVE CURRENT DATA DIRECTORY
====================================================================

STEP 16 - Rename Existing Data Directory
--------------------------------------------------------------------

Purpose:
Preserve the current data directory before restoring the base backup.

Command:

sudo mv /var/lib/pgsql/16/data \
/var/lib/pgsql/16/data_old


Evidence:
screenshots/10-move-directory.png


====================================================================
PHASE 10 - RESTORE BASE BACKUP
====================================================================

STEP 17 - Restore Physical Base Backup
--------------------------------------------------------------------

Purpose:
Restore the previously created physical base backup as the
PostgreSQL data directory.

Commands:

sudo cp -a \
/var/lib/pgsql/16/pitr_basebackup/. \
/var/lib/pgsql/16/data/


STEP 18 - Fix Ownership
--------------------------------------------------------------------

Purpose:
Ensure the restored PostgreSQL data directory is owned by the
PostgreSQL operating-system user.

Command:

sudo chown -R postgres:postgres \
/var/lib/pgsql/16/data


====================================================================
PHASE 11 - CONFIGURE RECOVERY
====================================================================

STEP 19 - Configure restore_command
--------------------------------------------------------------------

Purpose:
Tell PostgreSQL how to retrieve archived WAL files during recovery.

Configuration:

restore_command = 'cp /var/lib/pgsql/16/archive/%f %p'


STEP 20 - Configure Recovery Target
--------------------------------------------------------------------

Purpose:
Tell PostgreSQL where recovery should stop.

Configuration:

recovery_target_time = 'YYYY-MM-DD HH:MM:SS'

Replace the timestamp with the timestamp recorded during STEP 11.

Example:

recovery_target_time = '2026-07-19 18:42:30'

STEP 21 - Configure Recovery Target Action
--------------------------------------------------------------------

Configuration:

recovery_target_action = 'promote'


Evidence:
screenshots/11-update-auto-conf-file.png


====================================================================
PHASE 12 - CREATE RECOVERY SIGNAL
====================================================================

STEP 22 - Create recovery.signal
--------------------------------------------------------------------

Purpose:
Create recovery.signal so PostgreSQL starts targeted recovery when
the server starts.

Command:

sudo touch /var/lib/pgsql/16/data/recovery.signal


STEP 23 - Set Ownership
--------------------------------------------------------------------

Command:

sudo chown postgres:postgres \
/var/lib/pgsql/16/data/recovery.signal


Evidence:
screenshots/12-create-recovery-file.png


====================================================================
PHASE 13 - START POSTGRESQL
====================================================================

STEP 24 - Start PostgreSQL
--------------------------------------------------------------------

Purpose:
Start PostgreSQL and allow it to replay the required archived WAL
files.

Command:

sudo systemctl start postgresql-16


STEP 25 - Check PostgreSQL Status
--------------------------------------------------------------------

Command:

sudo systemctl status postgresql-16


Evidence:
screenshots/13-start-server.png


====================================================================
PHASE 14 - VERIFY PITR
====================================================================

STEP 26 - Connect to companydb
--------------------------------------------------------------------

Command:

sudo -u postgres psql companydb


STEP 27 - Verify Recovered Table
--------------------------------------------------------------------

Command:

SELECT * FROM pitr_test;


Expected:

The pitr_test table exists.

Records committed before the selected recovery target should be
present.

The DROP TABLE operation should not be present in the recovered
state if the recovery target was correctly selected before the
DROP operation.


Evidence:
screenshots/14-verify-PITR.png


====================================================================
PHASE 15 - VERIFY RECOVERY COMPLETED
====================================================================

STEP 28 - Check Recovery Status
--------------------------------------------------------------------

Command:

SELECT pg_is_in_recovery();


Expected:

f


Meaning:

PostgreSQL has completed recovery and is operating as a normal
primary server.


Evidence:
screenshots/14-verify-PITR.png


====================================================================
END OF PITR LAB
====================================================================
