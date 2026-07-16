# PostgreSQL Database Lab Setup Commands

This document contains the SQL commands used to create the sample PostgreSQL database and verify the database objects used throughout the PostgreSQL Administration lab.

---

# Step 1 - Create the Database and Schema

## Purpose

Create the PostgreSQL sample database and the application schema used throughout the PostgreSQL Administration lab.

## Commands

```sql
CREATE DATABASE companydb;

\c companydb

CREATE SCHEMA company;
```

## Evidence

![Database and Schema Creation](screenshots/db-schema-table-index-creation.png)

---

# Step 2 - Create Remaining Tables

## Purpose

Create the remaining business tables required for the sample application.

## Command

The complete SQL script is available in:

- `scripts/companydb_lab_setup.sql`

## Evidence

![Table Creation](screenshots/other-tables.png)

---

# Step 3 - Create Indexes

## Purpose

Create indexes to improve query performance.

## Command

The complete SQL script is available in:

- `scripts/companydb_lab_setup.sql`

Example syntax:

```sql
CREATE INDEX index_name
ON table_name(column_name);
```

## Evidence

![Index Creation](screenshots/index_creation.png)

---

# Step 4 - Verify Database Objects

## Purpose

Verify that the database objects were created successfully.

## Commands

```sql
\dt

\di

\dv

\df
```

## Evidence

![Database Objects](screenshots/object-list.png)

---

# Step 5 - Create Database Objects

## Purpose

Create the remaining database objects required for the sample application.

## Command

The complete SQL script is available in:

- `scripts/companydb_lab_setup.sql`

The script includes:

- Tables
- Indexes
- Views
- Functions
- Triggers
- Sample Data

---

# Step 6 - Verify Sample Data

## Purpose

Verify that sample data has been successfully inserted into the tables.

## Commands

```sql
SELECT COUNT(*) FROM company.departments;

SELECT COUNT(*) FROM company.employees;

SELECT COUNT(*) FROM company.customers;

SELECT COUNT(*) FROM company.products;

SELECT COUNT(*) FROM company.orders;

SELECT COUNT(*) FROM company.order_items;

SELECT COUNT(*) FROM company.payments;
```

## Evidence

![Table Counts](screenshots/table-counts.png)
