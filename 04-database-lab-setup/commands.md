# PostgreSQL Database Lab Setup Commands

This document contains the SQL commands and verification steps used to create the sample PostgreSQL database and database objects used throughout the PostgreSQL Administration lab.

---

# Step 1 - Create Database and Schema

## Purpose

Create the sample PostgreSQL database and application schema used throughout the PostgreSQL Administration lab.

## Commands

```sql
CREATE DATABASE companydb;

\c companydb

CREATE SCHEMA company;
```

## Evidence

![Database and Schema Creation](screenshots/db-schema-table-index-creation.png)

---

# Step 2 - Create Tables

## Purpose

Create the business tables required for the sample application.

## Command

The complete SQL script is available in:

- `scripts/companydb_lab_setup.sql`

The script contains the SQL statements used to create all application tables.

## Evidence

![Table Creation](screenshots/other-tables.png)

---

# Step 3 - Create Indexes

## Purpose

Create indexes to improve query performance.

## Command

Example syntax:

```sql
CREATE INDEX index_name
ON table_name(column_name);
```

The complete index creation statements are available in:

- `scripts/companydb_lab_setup.sql`

## Evidence

![Index Creation](screenshots/index_creation.png)

---

# Step 4 - Create Remaining Database Objects and verify 

## Purpose

Create the remaining database objects required for the sample application. Verify that the database objects were created successfully.

## Command

The complete SQL script is available in:

- `scripts/companydb_lab_setup.sql`

The script also includes:

- Views
- Functions
- Triggers
- Sample Data

---

## To Verify Database Objects .

## Commands

```sql
\dt
```

Lists all tables.

```sql
\di
```

Lists all indexes.

```sql
\dv
```

Lists all views.

```sql
\df
```

Lists all functions.

## Evidence

![Database Objects](screenshots/object-list.png)

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
