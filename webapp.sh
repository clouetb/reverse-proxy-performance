#!/bin/bash
sudo yum update -y
sudo yum install -y python38-psycopg2 python38-pip python3-virtualenv python38-devel gcc gcc-c++ avahi

sudo sed -i 's/#host-name=.*$/host-name=webapp/g' /etc/avahi/avahi-daemon.conf
sudo sed -i 's/#domain-name=.*$/domain-name=local/g' /etc/avahi/avahi-daemon.conf
sudo systemctl enable avahi-daemon
sudo systemctl restart avahi-daemon

virtualenv -p /usr/bin/python3.8 env
cp /vagrant/webapp/app.py .
./env/bin/pip3 install flask

cat << __EOF__ > flask_app.service
[Unit]
Description=Flask App Service
After=syslog.target network.target
[Service]
Type=simple
User=${USER}
WorkingDirectory=${HOME}
ExecStart=${HOME}/env/bin/flask run --host=0.0.0.0
Restart=on-abort
[Install]
WantedBy=multi-user.target
__EOF__

sudo cp flask_app.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable flask_app
sudo systemctl restart flask_app

sudo yum install -y nginx
cat << __EOF__ > webapp.conf
upstream webapp {
    server localhost:5000;
}

log_format vhostlogs    '\$host \$remote_addr - \$remote_user [\$time_local] \$request_time '
                        '"\$request" \$status \$body_bytes_sent "\$http_referer" '
                        '"\$http_user_agent" "\$http_x_forwarded_for"';

server {
    listen 80;
    server_name webapp.local;
    access_log /var/log/nginx/webapp.local.access vhostlogs;
    location / {
        proxy_pass         http://webapp;
    }
}
__EOF__

sudo cp webapp.conf /etc/nginx/conf.d
sudo systemctl enable nginx
sudo systemctl restart nginx

set