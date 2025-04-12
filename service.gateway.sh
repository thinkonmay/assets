set -x
export turnMAC=$(yq '.interface.turn.mac' cluster.yaml | tr -d '"' )
export turnIF=$(ip link show | grep $turnMAC | head -n1 |  cut -d: -f2 | awk '{print $1}')

export apiMAC=$(yq '.interface.api.mac' cluster.yaml | tr -d '"' )
export apiIF=$(ip link show | grep $apiMAC | head -n1 |  cut -d: -f2 | awk '{print $1}')

export PUBLICIP="$(curl -s --interface $turnIF ipv4.icanhazip.com)"
export PRIVIP="$(ifdata -pa $apiIF)"


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
Environment="SERVICE_DOMAIN=play.2.thinkmay.net"
Environment="REDIRECT_URL=https://win11.thinkmay.net"
Type=simple
User=root
ExecStart="$PWD"/pb --secure --url http://"$PRIVIP":50000 --proxy http://127.0.0.1:50001
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
Environment="ADDRESS=127.0.0.1"
Environment="TURN="$PUBLICIP""
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
