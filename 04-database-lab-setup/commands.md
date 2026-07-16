# PostgreSQL Database Lab Setup Commands

This document contains the commands used to create the sample PostgreSQL database and verify the database objects used throughout the PostgreSQL Administration lab.

---

# Step 1 - Create Database

## Purpose

Create the sample database used throughout the PostgreSQL Administration lab.

## Command

```sql
CREATE DATABASE companydb;
```

## Evidence

![Database Creation](screenshots/db-schema-table-index-creation.png)

---

# Step 2 - Connect to the Database

## Purpose

Connect to the newly created database.

## Command

```sql
\c companydb
```

## Evidence

![Database Connection](screenshots/db-schema-table-index-creation.png)

---

# Step 3 - Create Schema and Initial Database Objects

## Purpose

Create the application schema and initial database objects.

## Command

```sql
CREATE SCHEMA company;
```

The complete SQL script is available in:

- `scripts/companydb_lab_setup.sql`

## Evidence

![Schema and Initial Objects](screenshots/db-schema-table-index-creation.png)

---

# Step 4 - Create Remaining Tables

## Purpose

Create the remaining business tables required for the PostgreSQL Administration lab.

## Command

Refer to:

- `scripts/companydb_lab_setup.sql`

## Evidence

![Remaining Tables](screenshots/other-tables.png)

---

# Step 5 - Create Indexes

## Purpose

Create indexes to improve query performance.

## Command

```sql
CREATE INDEX index_name
ON table_name(column_name);
```

The complete index creation statements are available in:

- `scripts/companydb_lab_setup.sql`

## Evidence

![Index Creation](screenshots/index_creation.png)

---

# Step 6 - Verify Database Objects

## Purpose

Verify that all database objects were created successfully.

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

# Step 7 - Verify Sample Data

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
