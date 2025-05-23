#!/bin/bash -e

echo "DisablePlugins=pnat" >> "${ROOTFS_DIR}/etc/bluetooth/main.conf"

sed -i "s/#alias ll='ls -l'/alias ll='ls -l'/" "${ROOTFS_DIR}/home/pi/.bashrc"

echo 'ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="072f", ATTR{idProduct}=="2200", TEST=="power/control", ATTR{power/control}="on"' > "${ROOTFS_DIR}/etc/udev/rules.d/99-pcscd.rules"
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="072f", ATTR{idProduct}=="2200", RUN+="/bin/systemctl restart pcscd.service"' >> "${ROOTFS_DIR}/etc/udev/rules.d/99-pcscd.rules"

