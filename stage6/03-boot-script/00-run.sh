#!/bin/bash -e

# Copy service and script
install -m 644 files/setup.service "${ROOTFS_DIR}/etc/systemd/system/setup.service"
install -m 644 files/xr-app.service "${ROOTFS_DIR}/etc/systemd/system/xr-app.service"
install -m 755 files/setup.sh "${ROOTFS_DIR}/usr/local/bin/setup.sh"
install -m 600 files/ssh_config "${ROOTFS_DIR}/home/pi/.ssh/config"

echo "$DEPLOY_KEY" > "${ROOTFS_DIR}/home/pi/.ssh/deploy_key"
chmod 600 "${ROOTFS_DIR}/home/pi/.ssh/deploy_key"

ln -sf "${ROOTFS_DIR}/lib/systemd/system/setup.service" "${ROOTFS_DIR}/etc/systemd/system/multi-user.target.wants/setup.service"

on_chroot << EOF
chown pi:pi /home/pi/.ssh/*
EOF