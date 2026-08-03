**low-level-api-backup.sh**



\#!/bin/bash



\# =====================================================

\# PostgreSQL Low-Level API Backup

\# =====================================================



\# Create Backup Directory



mkdir -p /backup/low\_level



\# Start Backup



psql -c "SELECT pg\_backup\_start('Low Level Backup');"



\# Create Backup



tar -czvf /backup/low\_level/pgsql\_backup.tar.gz /var/lib/pgsql/16/data



\# Verify Backup



ls -lrth /backup/low\_level



\# Stop Backup



psql -c "SELECT pg\_backup\_stop();"



\# Verify backup\_label



ls -lrth /var/lib/pgsql/16/data

