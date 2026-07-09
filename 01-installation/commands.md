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



---

# Step 3 - Disable the Default PostgreSQL Module

## Command

```bash
sudo dnf -qy module disable PostgreSQL
```

## Purpose

Disables the default PostgreSQL module provided by the RHEL AppStream repository.

This ensures that PostgreSQL packages are installed from the official PostgreSQL Global Development Group (PGDG) repository instead of the operating system repository, preventing package version conflicts.

## Breakdown

- **sudo** – Executes the command with administrative privileges.
- **dnf** – Package manager used in RHEL 9.
- **-q** – Runs the command in quiet mode by suppressing unnecessary output.
- **-y** – Automatically answers "Yes" to confirmation prompts.
- **module** – Manages DNF software modules.
- **disable** – Disables the specified module.
- **PostgreSQL** – The default PostgreSQL AppStream module provided by RHEL.

## Screenshot

![Disable PostgreSQL Module](screenshots/01-dnf-disbale-mod-command.png)

## Expected Result

The PostgreSQL AppStream module is disabled successfully, and the command completes with a message similar to:

```text
Complete!
```

After this step, DNF installs PostgreSQL packages from the official PGDG repository instead of the RHEL AppStream repository.

---
