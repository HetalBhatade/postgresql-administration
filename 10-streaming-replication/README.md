# PostgreSQL Streaming Replication

## Objective

This project demonstrates the configuration and testing of PostgreSQL Physical Streaming Replication between a primary server and a standby server.

The lab covers the complete setup process, starting from primary server configuration and replication authentication through standby initialization, replication monitoring, and data replication testing.

## Architecture

```text
                    PostgreSQL Streaming Replication

                         PRIMARY SERVER
                              |
                              |
                         WAL Sender
                              |
                         WAL Streaming
                              |
                         WAL Receiver
                              |
                              |
                         STANDBY SERVER
                              |
                         WAL Replay
                              |
                       Read-Only Queries
