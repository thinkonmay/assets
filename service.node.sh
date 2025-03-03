set -x

echo "[Unit]
Description=
After=network.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
Type=simple
User=root
ExecStart="$PWD"/daemon --proxy http://127.0.0.1:50001
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
Environment="ADDRESS=127.0.0.1"
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
systemctl start virtdaemon
journalctl -f -u virtdaemon
