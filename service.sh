set -x

echo "[Unit]
Description=
After=network.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
Type=simple
User=root
ExecStart="$PWD"/daemon --proxy http://10.20.40.1:50001
WorkingDirectory="$PWD"

Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/virtdaemon.service

echo "[Unit]
Description=
After=network.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
Environment="SERVICE_DOMAIN=play.2.thinkmay.net"
Environment="REDIRECT_URL=https://win11.thinkmay.net"
Type=simple
User=root
ExecStart="$PWD"/pb --secure --url http://10.20.40.1:50000 --proxy http://10.20.40.1:50001
WorkingDirectory="$PWD"

Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/pocketbase.service

echo "[Unit]
Description=
After=network.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
Environment="ADDRESS=10.20.40.1"
Environment="TURN=10.20.40.1"
Environment="PORT=50001"
Type=simple
User=root
ExecStart=nice -n -20 "$PWD"/proxy
WorkingDirectory="$PWD"

Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/proxy.service

systemctl daemon-reload
systemctl start proxy
systemctl start pocketbase
systemctl start virtdaemon
journalctl -f -u virtdaemon
