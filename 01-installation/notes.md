# PostgreSQL Installation Notes

## Introduction

PostgreSQL is a powerful, open-source Relational Database Management System (RDBMS) known for its reliability, extensibility, standards compliance, and advanced features. It is widely used for enterprise applications, web applications, analytics, data warehousing, and cloud-native applications.

This document provides the conceptual understanding of installing PostgreSQL 16 on Rocky Linux using the official PostgreSQL Global Development Group (PGDG) repository. The practical installation commands and their explanations are documented separately in `commands.md`.

---

## Lab Environment

| Component | Details |
|-----------|---------|
| Host Operating System | Windows 11 |
| Virtualization | VMware Workstation Pro 17 |
| Guest Operating System | Red Hat Enterprise Linux 9.8 (RHEL)  |
| PostgreSQL Version | PostgreSQL 16 |


## Servers

| Server | Status |
|--------|--------|
| Primary Server | Installed and configured successfully |
| Standby Server | Installation in progress |
---

# Learning Objectives

After completing this topic, I should be able to:

- Understand the PostgreSQL installation process on Linux.
- Install PostgreSQL using the official PGDG repository.
- Understand the purpose of the PGDG repository.
- Understand why the default PostgreSQL module is disabled.
- Understand the role of the DNF package manager.
- Initialize a PostgreSQL database cluster using `initdb`.
- Start and manage the PostgreSQL service.
- Connect to PostgreSQL using the `psql` client.
- Verify that PostgreSQL has been installed successfully.

---

# Prerequisites

Before installing PostgreSQL, ensure the following prerequisites are met:

- Rocky Linux 9 server
- Internet connectivity
- Root or sudo privileges
- Basic Linux command-line knowledge

---

# Topics Covered

This topic covers the following concepts:

- PostgreSQL Installation
- PostgreSQL Packages
- PostgreSQL Global Development Group (PGDG) Repository
- DNF Package Manager
- PostgreSQL Database Cluster
- Database Initialization (`initdb`)
- PostgreSQL Service Management
- PostgreSQL Data Directory
- PostgreSQL Configuration Files
- PostgreSQL Client (`psql`)
- Installation Verification

---

# Related Files

| File | Purpose |
|------|---------|
| `README.md` | Overview of the installation topic |
| `commands.md` | Installation commands with explanations |
| `lab-environment.md` | Details of the lab environment |
| `troubleshooting.md` | Installation issues and their resolutions |
| `interview-questions.md` | Interview questions related to PostgreSQL installation |
| `screenshots/` | Screenshots captured during the installation process |

---

# Summary

This document serves as the conceptual reference for PostgreSQL installation. The installation procedure, commands, screenshots, troubleshooting steps, and interview questions are maintained in their respective files to keep the documentation organized and easy to navigate.
