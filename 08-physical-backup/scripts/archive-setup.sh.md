**archive-setup.sh**



\#!/bin/bash



\# =====================================================

\# PostgreSQL WAL Archiving Configuration

\# =====================================================



\# Verify Current Settings



psql -c "SHOW wal\_level;"

psql -c "SHOW archive\_mode;"

psql -c "SHOW archive\_command;"

psql -c "SHOW max\_wal\_senders;"



\# Create Archive Directory



mkdir -p /pgarchive



chown postgres:postgres /pgarchive



chmod 700 /pgarchive



\# Backup Configuration File



cp postgresql.conf postgresql.conf\_bkp



\# Edit Configuration File



vi postgresql.conf



\# Restart PostgreSQL



systemctl restart postgresql-16



\# Verify Updated Parameters



psql -c "SHOW wal\_level;"

psql -c "SHOW archive\_mode;"

psql -c "SHOW archive\_command;"

psql -c "SHOW max\_wal\_senders;"



\# Force WAL Switch



psql -c "SELECT pg\_switch\_wal();"



\# Verify Archived WAL



ls -lrth /pgarchive



\# Check Archiver Statistics



psql -c "SELECT \* FROM pg\_stat\_archiver;"



psql -c "SELECT archived\_count,failed\_count,last\_archived\_wal,last\_archived\_time FROM pg\_stat\_archiver;"

