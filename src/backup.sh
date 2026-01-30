#!/bin/bash

send_failure_notification() {
  if [ -z "$DISCORD_WEBHOOK_URL" ]; then
    echo "DISCORD_WEBHOOK_URL is not set. Exiting."
    return
  fi
  curl -X POST \
    -H 'Content-Type: application/json' \
    -d "{\"content\": \"${PBS_BACKUP_ID} - BACKUP FAILED\", \"description\": \"$1\"}" \
    "${DISCORD_WEBHOOK_URL}"
}

# Exec 5>&1 creates a file descriptor for stdout
exec 5>&1

# The variable catches output while tee sends it to fd 5 (terminal)
PBS_OUTPUT=$(proxmox-backup-client \
    backup \
    "${PBS_PXAR_NAME}.pxar:${PBS_BACKUP_SRC_DIR}" \
    --backup-id "${PBS_BACKUP_ID}" \
    --backup-type host \
    --all-file-systems \
    --ns "${PBS_NS}" \
    --keyfile "${PBS_KEY}" \
    --skip-lost-and-found \
    --change-detection-mode metadata \
  2>&1 | tee >(cat - >&5))

PBS_EXITCODE=${PIPESTATUS[0]}
if [ ${PBS_EXITCODE} -ne 0 ]; then
  send_failure_notification "$PBS_OUTPUT"
fi
