
# PostgreSQL Database Lab Setup

## Overview

A PostgreSQL database is a logical container that stores application data and database objects. Multiple databases can exist within a single PostgreSQL database cluster, and each database operates independently.

For this lab, a sample database named `companydb` is used to demonstrate common PostgreSQL administration tasks such as backup and recovery, replication, Point-in-Time Recovery (PITR), maintenance, and performance testing.

---

# Database

A database is a collection of related data organized for efficient storage, retrieval, and management.

In this lab:

- Database Name: `companydb`

---

# Schema

A schema is a logical namespace within a database that groups related database objects.

Benefits of using schemas include:

- Better organization of database objects
- Simplified object management
- Reduced naming conflicts
- Improved security through schema-level privileges

The application objects in this lab are created under the `company` schema.

---

# Tables

Tables store business data in rows and columns.

The `company` schema contains multiple tables representing different business entities, including:

- departments
- employees
- customers
- products
- orders
- order_items
- payments
- audit_log

These tables are connected using primary keys and foreign keys to maintain data integrity.

---

# Indexes

Indexes improve query performance by allowing PostgreSQL to locate rows more efficiently without scanning the entire table.

Indexes are created on frequently searched columns such as employee department, salary, customer, and product information.

---

# Views

A view is a virtual table created from the result of a SQL query.

Views simplify complex queries and provide a reusable interface for accessing data.

---

# Functions

Functions contain reusable SQL or PL/pgSQL logic that can be executed whenever required.

Functions help centralize business logic and reduce repetitive SQL statements.

---

# Triggers

Triggers automatically execute a function when a specific database event occurs.

Typical events include:

- INSERT
- UPDATE
- DELETE

In this lab, a trigger records changes made to employee data in an audit table.

---

# Sample Data

Sample data is inserted into the tables to simulate a real-world application workload.

This data is used throughout the PostgreSQL Administration lab for:

- Backup and Restore
- Streaming Replication
- Logical Replication
- Point-in-Time Recovery (PITR)
- Performance Testing
- Maintenance Operations

---

# Object Verification

After creating the database objects, PostgreSQL system commands are used to verify their successful creation.

Examples include listing:

- Tables
- Indexes
- Views
- Functions

Verifying database objects ensures that the lab environment has been created successfully before proceeding with additional PostgreSQL administration tasks.
