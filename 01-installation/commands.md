# PostgreSQL Installation Commands

This document contains the practical commands used to install PostgreSQL 16 on Red Hat Enterprise Linux 9.8.

---

# Step 1 - Update the Operating System

## Command

```bash
sudo dnf update -y
```

## Purpose

Updates all installed packages on the operating system to the latest available versions.

Running this command before installing PostgreSQL ensures that the operating system has the latest security updates, bug fixes, and required dependency packages.

## Command Breakdown

- **sudo** – Runs the command with administrative privileges.
- **dnf** – Default package manager in Red Hat Enterprise Linux 9.
- **update** – Updates all installed packages.
- **-y** – Automatically answers "Yes" to all confirmation prompts.

## Screenshot

![DNF Update Command](screenshots/01-dnf-update-command.png)

## Expected Result

The command completes successfully and the operating system packages are updated.


## Screenshot

![DNF Update Command](screenshots/01-dnf-update-success.png)



---

# Step 2 - Install the PostgreSQL PGDG Repository

## Command

```bash
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```

## Purpose

Installs the official PostgreSQL Global Development Group (PGDG) repository on Red Hat Enterprise Linux 9.8.

The default RHEL repositories may not provide the latest PostgreSQL version. Installing the PGDG repository allows the system to download PostgreSQL 16 packages directly from the official PostgreSQL repository.

## Command Breakdown

- **sudo** – Executes the command with administrative privileges.
- **dnf** – Package manager used in Red Hat Enterprise Linux 9.
- **install** – Installs a package.
- **-y** – Automatically answers "Yes" to all prompts.
- **https://download.postgresql.org/...** – Official PostgreSQL PGDG repository package.

## Execution Result

The following screenshot shows the execution of the command and the successful installation of the PostgreSQL PGDG repository package.

![Install PGDG Repository](screenshots/01-dnf-install-pgdg-repo-success-command.png)
