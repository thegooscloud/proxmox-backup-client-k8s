#!/bin/bash

proxmox-backup-client \
    backup \
    --backup-id "${PBS_BACKUP_ID}" \
    --backup-type host \
    --all-file-systems \
    --ns "${PBS_NS}" \
    --keyfile "${PBS_KEY}" \
    --skip-lost-and-found \
    --change-detection-mode metadata \
    "${PBS_PXAR_NAME}.pxar:${PBS_BACKUP_SRC_DIR}" \
  2>&1
