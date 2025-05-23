#!/bin/bash -e

# Enable IP forwarding
echo "net.ipv4.ip_forward=1" >> "${ROOTFS_DIR}/etc/sysctl.conf"
echo "net.ipv6.conf.all.forwarding=1" >> "${ROOTFS_DIR}/etc/sysctl.conf"

# Enable Tailscale at boot
mkdir -p "${ROOTFS_DIR}/etc/systemd/system/multi-user.target.wants"

echo "$TS_KEY" > "${ROOTFS_DIR}/etc/tailscale-up.key"
chmod 644 "${ROOTFS_DIR}/etc/tailscale-up.key"

# Allow SSH via Tailscale
sed -i 's/#Port 22/Port 22/' "${ROOTFS_DIR}/etc/ssh/sshd_config"
