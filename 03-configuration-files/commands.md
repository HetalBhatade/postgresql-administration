
# PostgreSQL Configuration File Commands

This document contains the practical SQL queries and Linux commands used to explore PostgreSQL configuration files, verify their locations, inspect their contents, modify configuration parameters, and validate authentication configuration.

---

# Step 1 - View PostgreSQL Configuration Files

## Commands

```sql
SHOW config_file;

SHOW hba_file;

SHOW ident_file;

SHOW data_directory;
```

## Purpose

Displays the location of the PostgreSQL configuration files stored in the data directory.

## Verification

- all_conf_file.png
- postgresql.conf-file-path.png
- pg_hba.conf-path.png

---

# Step 2 - View pg_hba.conf Content

## Commands

```bash
cat pg_hba.conf
```

```sql
SELECT
    type,
    database,
    user_name,
    auth_method,
    options
FROM pg_hba_file_rules;
```

## Purpose

Displays the contents of the Host-Based Authentication configuration file and verifies the authentication rules currently loaded by PostgreSQL.

## Verification

- pg_hba.conf-content.png

---

# Step 3 - View Default pg_ident.conf

## Commands

```bash
cat pg_ident.conf
```

## Purpose

Displays the default contents of the PostgreSQL user mapping configuration file before any modifications.

## Verification

- pg_ident_file.png

---

# Step 4 - Modify Configuration using ALTER SYSTEM

## Commands

```sql
SHOW log_min_duration_statement;

ALTER SYSTEM SET log_min_duration_statement = 1000;

SELECT pg_reload_conf();

SHOW log_min_duration_statement;
```

```bash
cat postgresql.auto.conf
```

## Purpose

Changes a PostgreSQL configuration parameter using ALTER SYSTEM, reloads the configuration, and verifies that PostgreSQL automatically stores the parameter in postgresql.auto.conf.

## Verification

- auto.conf.file-test.png

---

# Step 5 - Create Test User for pg_ident.conf

## Commands

```sql
\du

CREATE ROLE oracle
LOGIN
PASSWORD 'Oracle@1234';

\du
```

## Purpose

Creates a PostgreSQL role used for demonstrating username mapping through pg_ident.conf.

## Verification

- pg_ident-file-command.png

---

# Step 6 - Update pg_ident.conf and pg_hba.conf

## Commands

```bash
cp -pr pg_ident.conf pg_ident.conf_bkp

vi pg_ident.conf

vi pg_hba.conf
```

```sql
SELECT pg_reload_conf();
```

## Purpose

Creates a backup of pg_ident.conf, updates both authentication configuration files, and reloads the PostgreSQL configuration.

## Verification

- pg_hba_conf-fileupdate.png

---

# Step 7 - Verify pg_ident Mapping

## Commands

```sql
SELECT *
FROM pg_ident_file_mappings;
```

## Purpose

Displays the username mappings currently loaded from pg_ident.conf.

## Verification

- pg_ident-file-result.png

---

# Step 8 - Verify pg_hba Rules

## Commands

```sql
SELECT
    type,
    database,
    user_name,
    auth_method,
    options
FROM pg_hba_file_rules;
```

## Purpose

Verifies that PostgreSQL successfully loaded the authentication rules defined in pg_hba.conf.

## Verification

- pg_ident-file-result.png
