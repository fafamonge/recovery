# Recovery

Independent Linux server recovery layer for SSH access backup, diagnostics, and emergency restore.

Recovery is designed for system administrators who need a controlled fallback path when primary SSH access to a Linux server is damaged, removed, or misconfigured.

## What it does

- Creates an independent `recovery` user
- Backs up `/root/.ssh`
- Preserves `authorized_keys`
- Provides diagnostic checks
- Restores root SSH access from a known-good backup
- Uses strict permissions
- Keeps recovery artifacts outside the normal root SSH path

## Default model

Recovery is designed to work well in a four-node infrastructure swarm by default, but it is not limited to four servers.

Example roles:

- node-01: primary application server
- node-02: mail/control server
- node-03: infrastructure node
- node-04: infrastructure node

## Project status

Early public release. Built from a real incident-response use case and being generalized for safe reuse.

## Author

**Rafael Monge**  
**EMPRETEL NETWORKS**  
El Salvador 🇸🇻

Created by Rafael Monge / EMPRETEL NETWORKS  
Made in El Salvador 🇸🇻
