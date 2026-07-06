#!/bin/bash
set -euo pipefail

RECOVERY_USER="${RECOVERY_USER:-recovery}"
RECOVERY_BASE="${RECOVERY_BASE:-/opt/recovery}"
RECOVERY_CONF_DIR="${RECOVERY_CONF_DIR:-/etc/recovery}"

PURGE="${1:-}"

echo "Uninstalling Recovery..."

rm -f /etc/sudoers.d/recovery

rm -f "$RECOVERY_BASE/bin/recovery-backup-root-ssh" \
      "$RECOVERY_BASE/bin/recovery-restore-root-ssh" \
      "$RECOVERY_BASE/bin/recovery-check-root-ssh" \
      "$RECOVERY_BASE/bin/recovery-doctor"

if [ "$PURGE" = "--purge" ]; then
  echo "Purging Recovery data..."
  rm -rf "$RECOVERY_BASE"
  rm -rf "$RECOVERY_CONF_DIR"

  if id "$RECOVERY_USER" >/dev/null 2>&1; then
    userdel -r "$RECOVERY_USER" 2>/dev/null || userdel "$RECOVERY_USER"
  fi
else
  echo
  echo "Recovery binaries and sudoers removed."
  echo "Data preserved:"
  echo "  $RECOVERY_BASE"
  echo "  $RECOVERY_CONF_DIR"
  echo
  echo "To remove all data and the recovery user, run:"
  echo "  ./uninstall.sh --purge"
fi

echo "Recovery uninstall completed."
