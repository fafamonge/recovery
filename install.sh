#!/bin/bash
set -euo pipefail

RECOVERY_USER="${RECOVERY_USER:-recovery}"
RECOVERY_BASE="${RECOVERY_BASE:-/opt/recovery}"
RECOVERY_CONF_DIR="${RECOVERY_CONF_DIR:-/etc/recovery}"

echo "Installing Recovery..."

if ! id "$RECOVERY_USER" >/dev/null 2>&1; then
  useradd -m -s /bin/bash "$RECOVERY_USER"
fi

passwd -l "$RECOVERY_USER" >/dev/null 2>&1 || true

install -d -m 700 -o root -g root "$RECOVERY_BASE"
install -d -m 700 -o root -g root "$RECOVERY_BASE/bin"
install -d -m 700 -o root -g root "$RECOVERY_BASE/backups"
install -d -m 700 -o root -g root "$RECOVERY_BASE/authorized_keys"
install -d -m 755 -o root -g root "$RECOVERY_CONF_DIR"

install -m 700 -o root -g root bin/recovery-backup-root-ssh "$RECOVERY_BASE/bin/recovery-backup-root-ssh"
install -m 700 -o root -g root bin/recovery-restore-root-ssh "$RECOVERY_BASE/bin/recovery-restore-root-ssh"
install -m 700 -o root -g root bin/recovery-check-root-ssh "$RECOVERY_BASE/bin/recovery-check-root-ssh"
install -m 700 -o root -g root bin/recovery-doctor "$RECOVERY_BASE/bin/recovery-doctor"

if [ ! -f "$RECOVERY_CONF_DIR/recovery.conf" ]; then
  install -m 600 -o root -g root config/recovery.conf.example "$RECOVERY_CONF_DIR/recovery.conf"
fi

install -m 440 -o root -g root sudoers/recovery /etc/sudoers.d/recovery
visudo -cf /etc/sudoers.d/recovery >/dev/null

install -d -m 700 -o "$RECOVERY_USER" -g "$RECOVERY_USER" "/home/$RECOVERY_USER/.ssh"

echo
echo "Recovery installed."
echo
echo "Next step:"
echo "  Add your recovery public key to:"
echo "  /home/$RECOVERY_USER/.ssh/authorized_keys"
echo
echo "Then run:"
echo "  sudo /opt/recovery/bin/recovery-doctor"
