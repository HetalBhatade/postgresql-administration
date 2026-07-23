# PostgreSQL Background Processes

## Overview

PostgreSQL uses several background processes to manage memory, write data safely to disk, perform automatic maintenance, generate logs, and support backup and replication.

These processes start automatically when the PostgreSQL server starts. Unlike backend processes, they do not execute client SQL queries directly. Instead, they continuously perform internal tasks that help maintain database performance, consistency, and reliability.

---

# PostgreSQL Architecture Overview

The following diagram illustrates the major components of a PostgreSQL server, including the postmaster process, memory architecture, background processes, and persistent storage.

For this module, the primary focus is the **Background Processes** section. The memory components and storage architecture shown in the diagram are explained in their respective modules.

![PostgreSQL Architecture](screenshots/Memory-achitecture.png)

The diagram shows how:

- The **Postmaster** process accepts client connections and starts backend processes.
- Background processes perform internal maintenance tasks independently of client sessions.
- Shared Memory is used to cache data and coordinate server operations.
- WAL files, data files, and archive files are stored on disk to ensure durability and recovery.

---

# Background Processes

Background processes run independently of client sessions and perform essential maintenance tasks required for normal PostgreSQL operation.

The primary background processes are:

- Checkpointer
- Background Writer
- WAL Writer
- Autovacuum Launcher
- Autovacuum Worker
- Archiver (when WAL archiving is enabled)
- Logger
- Logical Replication Launcher (when logical replication is configured)

Each process is explained below.

---

## 1. Checkpointer

### Purpose

The Checkpointer periodically writes dirty pages from Shared Buffers to the data files during a checkpoint.

### Responsibilities

- Writes dirty buffers to disk.
- Creates checkpoint records in WAL.
- Reduces crash recovery time.
- Helps maintain database consistency.

---

## 2. Background Writer

### Purpose

The Background Writer periodically writes dirty pages from Shared Buffers to disk before a checkpoint occurs.

### Responsibilities

- Gradually flushes dirty buffers.
- Keeps free buffers available for backend processes.
- Reduces I/O spikes during checkpoints.

---

## 3. WAL Writer

### Purpose

The WAL Writer periodically flushes WAL records from WAL Buffers to WAL segment files.

### Responsibilities

- Writes WAL records to the `pg_wal` directory.
- Improves transaction durability.
- Reduces the amount of WAL writing performed by backend processes.

---

## 4. Autovacuum Launcher

### Purpose

The Autovacuum Launcher monitors databases and starts Autovacuum Worker processes whenever maintenance is required.

### Responsibilities

- Monitors database activity.
- Starts worker processes automatically.
- Helps maintain table health.

---

## 5. Autovacuum Worker

### Purpose

Autovacuum Workers automatically clean tables and update optimizer statistics.

### Responsibilities

- Removes dead tuples.
- Updates planner statistics.
- Helps prevent table bloat.
- Prevents transaction ID wraparound.
- Uses `autovacuum_work_mem` during maintenance operations.

---

## 6. Archiver (Optional)

### Purpose

The Archiver copies completed WAL segment files to the archive destination.

### Responsibilities

- Archives completed WAL files.
- Supports Point-in-Time Recovery (PITR).
- Supports backup and disaster recovery.

> The Archiver process starts only when `archive_mode` is enabled.

---

## 7. Logger

### Purpose

The Logger writes PostgreSQL server log messages to log files.

### Responsibilities

- Records server events.
- Stores error messages.
- Assists monitoring and troubleshooting.

---

## 8. Logical Replication Launcher (Optional)

### Purpose

The Logical Replication Launcher starts Logical Replication Worker processes.

### Responsibilities

- Starts logical replication workers.
- Manages logical replication tasks.
- Supports logical replication subscriptions.

> This process runs only when logical replication is configured.
