# PostgreSQL Streaming Replication

## 1. What is Replication?

Replication is the process of maintaining a copy of data from one PostgreSQL server on another PostgreSQL server.

The main purpose of replication is to improve availability and reduce downtime when the primary server becomes unavailable.

A typical setup contains:

- Primary Server – source server that handles the main database workload.
- Standby Server – secondary server that receives and replays changes from the primary.

If the primary fails, the standby can be promoted to become the new primary through a failover process.

---

# 2. Why is Replication Used?

## High Availability

A standby helps reduce the impact of a primary server failure.

Without a standby:

```text
Primary Failure
      |
      ↓
Application unavailable
