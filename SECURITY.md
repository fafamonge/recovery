# Security Policy

Recovery is a security-sensitive infrastructure project.

## Reporting a vulnerability

Please do not publish exploitable vulnerabilities as public issues before responsible disclosure and remediation.

Report security concerns to the project maintainer through the contact information associated with the repository owner.

## Security principles

Recovery follows these principles:

- independent recovery access;
- SSH key authentication;
- locked recovery account password;
- least-privilege sudo policy;
- restrictive filesystem permissions;
- preservation before destructive restore operations;
- explicit administrative actions;
- no private keys or secrets stored in the repository.

## Important operational guidance

Always test the recovery account from a separate SSH session before relying on it.

Do not close your only working administrative session until recovery access has been independently verified.

Protect recovery private keys separately from the servers they protect.

Review the installed sudo policy before production deployment.

Recovery does not replace normal server hardening, backups, monitoring, audit logging, or incident response procedures.
