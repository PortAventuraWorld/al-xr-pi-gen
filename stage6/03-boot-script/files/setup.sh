#!/bin/bash -e

if [ ! -f /usr/bin/node ]; then
    # Install Node.js
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sh

    apt-get install -y nodejs

    setcap cap_net_raw+eip $(eval readlink -f `which node`)
fi

if [ -f "/etc/tailscale-up.key" ]; then
    # Install Tailscale
    AUTH_KEY=$(cat /etc/tailscale-up.key)

    # Generate a random serial
    SERIAL=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)
    echo $SERIAL > /home/pi/.serial
    curl -fsSL https://tailscale.com/install.sh | sh

    systemctl enable tailscaled

    sudo tailscale up --authkey "$AUTH_KEY" --ssh --hostname="xr-rpi-$SERIAL"

    rm -f /etc/tailscale-up.key
fi

# Clone Node.js app
APP_DIR="/home/pi/xr-app"

if [ ! -d "$APP_DIR" ]; then
    GIT_SSH_COMMAND="ssh -i /home/pi/.ssh/deploy_key -o StrictHostKeyChecking=no" git clone git@github.com:PortAventuraWorld/al-xr-totem "$APP_DIR"
    cd "$APP_DIR"
    npm install
    chown -R pi:pi "$APP_DIR"
fi

systemctl enable xr-app.service
systemctl start xr-app.service

systemctl disable setup.service
