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
