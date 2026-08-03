**offline-backup.sh**



\#!/bin/bash



\# =====================================================

\# PostgreSQL Offline (Cold) Backup

\# =====================================================



\# Stop PostgreSQL Server

systemctl stop postgresql-16



\# Verify PostgreSQL has stopped

systemctl status postgresql-16



\# Switch to postgres user

sudo su - postgres



\# Create Backup Directory

mkdir -p /backup/offline\_backup



\# Take filesystem backup

cp -rp /var/lib/pgsql/16/data /backup/offline\_backup/



\# Verify Backup

ls -lrth /backup/offline\_backup



\# Start PostgreSQL

exit



systemctl start postgresql-16



\# Verify PostgreSQL

systemctl status postgresql-16

