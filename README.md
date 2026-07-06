# Recovery

Independent Linux server recovery layer for SSH access backup, diagnostics, and emergency restore.

Recovery provides a separate administrative recovery path for Linux servers when primary root SSH access is damaged, removed, or misconfigured.

It was designed from a real production incident in which legitimate root SSH access was unexpectedly removed by an automated system process. The project separates recovery access from the primary administrative path and provides backup, diagnostic, and restore tools.

## Features

- Independent `recovery` user
- SSH key-based recovery access
- Locked password authentication for the recovery account
- Least-privilege sudo policy
- Timestamped backups of `/root/.ssh`
- Configurable backup retention
- Known-good `authorized_keys` fallback copy
- Root SSH integrity checks
- Emergency root SSH restore
- Pre-restore preservation of the existing SSH directory
- Recovery diagnostics through `recovery-doctor`
- Conservative uninstall behavior

## Components

| Command | Purpose |
|---|---|
| `recovery-backup-root-ssh` | Creates a timestamped backup of `/root/.ssh` |
| `recovery-check-root-ssh` | Checks root SSH files, ownership, permissions, keys, and hash |
| `recovery-restore-root-ssh` | Restores root SSH access from the latest backup or fallback key file |
| `recovery-doctor` | Runs recovery access and infrastructure diagnostics |

## Installation

Clone the repository:

    git clone https://github.com/fafamonge/recovery.git
    cd recovery

Run the installer as root:

    ./install.sh

The installer creates the recovery account and directories, installs the commands, configuration, and least-privilege sudo policy.

After installation, add your recovery public key to:

    /home/recovery/.ssh/authorized_keys

Then set the correct ownership and permissions:

    chown recovery:recovery /home/recovery/.ssh/authorized_keys
    chmod 600 /home/recovery/.ssh/authorized_keys

Test access from another terminal before closing the current administrative session.

## Basic usage

Create a root SSH backup:

    sudo /opt/recovery/bin/recovery-backup-root-ssh

Check root SSH health:

    sudo /opt/recovery/bin/recovery-check-root-ssh

Run diagnostics:

    sudo /opt/recovery/bin/recovery-doctor

Restore root SSH:

    sudo /opt/recovery/bin/recovery-restore-root-ssh

## Configuration

Default configuration file:

    /etc/recovery/recovery.conf

Example:

    RECOVERY_BASE="/opt/recovery"
    RECOVERY_RETENTION="5"
    RECOVERY_LOG="/var/log/recovery-ssh.log"

## Default infrastructure model

Recovery can be installed on a single server or across an infrastructure swarm.

The project documentation uses a four-node swarm as the default example:

- node-01: primary application server
- node-02: mail or control server
- node-03: infrastructure node
- node-04: infrastructure node

The software itself has no four-node limit.

## Security model

Recovery is intentionally independent from root's SSH directory.

The default installation:

- locks password authentication for the `recovery` account;
- expects SSH public-key authentication;
- stores recovery data under `/opt/recovery`;
- protects recovery directories with root ownership and restrictive permissions;
- grants only the Recovery commands through sudo;
- preserves the previous `/root/.ssh` directory before restore.

See `SECURITY.md` for security considerations and vulnerability reporting.

## Project status

Recovery is under active development.

The initial public version is based on an operational implementation used across Linux infrastructure and is being generalized for safe reuse.

## License

MIT License.

See `LICENSE` for details.

## Author

**Rafael Monge**  
**EMPRETEL NETWORKS**  
El Salvador 🇸🇻

Created by Rafael Monge / EMPRETEL NETWORKS  
Made in El Salvador 🇸🇻
