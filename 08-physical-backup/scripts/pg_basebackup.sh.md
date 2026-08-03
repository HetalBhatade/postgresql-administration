**pg\_basebackup.sh**



\#!/bin/bash



\# =====================================================

\# PostgreSQL pg\_basebackup

\# =====================================================



\# Verify Required Parameters



psql -c "SHOW archive\_mode;"

psql -c "SHOW wal\_level;"



psql -c "SELECT \* FROM pg\_stat\_archiver;"



\# Create Backup Directory



mkdir -p /backup/basebackup



\# Execute Base Backup



pg\_basebackup \\

\-D /backup/basebackup \\

\-F p \\

\-X stream \\

\-P



\# Verify Backup



ls -lrth /backup/basebackup



\# Verify backup\_label



cat /backup/basebackup/backup\_label



\# Verify backup\_manifest



cat /backup/basebackup/backup\_manifest

