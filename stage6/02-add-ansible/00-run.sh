#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/pi/.ssh
echo "$PUBKEY_SSH_FIRST_USER" > "${ROOTFS_DIR}/home/pi/.ssh/authorized_keys"
chmod 600 "${ROOTFS_DIR}/home/pi/.ssh/authorized_keys"
